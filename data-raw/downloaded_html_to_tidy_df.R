# First, make sure you have all of the MIA's pages for Lenin downloaded (see
# README). This script extracts locally stored HTM files, transforms them into a tidy
# data frame, and saves that as an RDS file (about 100 KB)

library(dplyr)
library(rvest)

#------------------------------------------------------------------------------
# Parsing/tidying functions
#------------------------------------------------------------------------------
# This function takes a file path as an argument and returns a data frame
# containing a column for the file path, for the HTML class of the text (usually
# not available, but could be useful in some analysis -- for example,
# salutations and quotes are annotated), and the text. Each row corresponds
# approximately to a paragraph, but depends on how the document was marked up.

parse_page <- function(fp) {
  page <- read_html(fp)

  article_title <- page %>%
    html_element(".title") %>%
    html_text()

  text_class <- page %>%
    html_elements("p:not(p.endnote):not(p.information)") %>%
    html_attrs() %>%
    as.character()

  article_text <- page %>%
    html_elements("p:not(p.endnote):not(p.information)") %>%
    html_text()

  if (is.null(article_title) || length(article_title) == 0) {
    article_title <- link
  }

  if (is.null(text_class) || length(text_class) == 0) {
    text_class <- NA
  }

  if (is.null(article_text) || length(article_text) == 0) {
    article_text <- NA
  }

  data.frame(
    url = fp,
    title = article_title,
    text_annotation = text_class,
    text = article_text
  )
}

# This function takes a data frame returned by parse_html and does some fairly
# simple text tidying to make it analysis ready.
tidy_parsed_html <- function(pages) {
  pages %>%
    mutate(
      # fix white space issues
      text = gsub("\t|\n", " ", text),
      text = gsub(" ( )+", " ", text),
      # remove annotations
      text = gsub("\\[[0-9]+\\]", "", text),
      # fix HTML parsing empty strings
      text_annotation = case_when(
        text_annotation == "character(0)" ~ NA_character_, # nothing
        grepl(" ", text_annotation)       ~ NA_character_, # just CSS
        TRUE                   ~ text_annotation # neat labels
      ),
      # tidy up titles for nicer aesthetics
      # remove anything with numbers in between square brackets
      title = tools::toTitleCase(tolower(gsub("\\[[0-9]*\\]", "", title))),
      # add year
      year = gsub(".*/([0-9]{4})/.*", "\\1", url),
      # make url more generic
      url = gsub("../mia/lenin/archive/lenin/", "", url, fixed = TRUE)
    )
}

#------------------------------------------------------------------------------
# Get list of files to read
#------------------------------------------------------------------------------

# update this path to the "works" folder on your machine:
base_dir <- file.path("..", "mia", "lenin", "archive", "lenin", "works")

# If you've downloaded the Lenin archives from MIA according to the instructions
# in the README of this package, you'll notice that there are a number of nested
# files. All the individual works are stored in folders named after the year in
# which they were written. Other folders link to index pages that allow other
# groupings of Lenin's work, such as by theme. To make it a little easier to
# remove duplicates etc later, rather than parse all files, this script just
# looks at the htm files stored in folders named after years. It also excludes
# index files (which are essentially just tables of contents).

all_files <- list.files(
  base_dir,
  recursive = TRUE,
  pattern = "\\.htm",
  full.names = TRUE
)
files_by_year <- all_files[grepl(".*/[0-9]{4}/.*", all_files)]
files_no_index <- files_by_year[!grepl("index", files_by_year)]
rm(all_files, files_by_year)

#------------------------------------------------------------------------------
# Extract/Transform/Load
#------------------------------------------------------------------------------

all_pages <- lapply(files_no_index, parse_page)

lenin <- bind_rows(all_pages) %>%
  tidy_parsed_html() %>%
  filter(nchar(text) >= 2)

# bespoke data-cleaning...
lenin <- lenin %>%
  mutate(
    title = ifelse(
      grepl("/cons-logic/", url),
      "Conspectus of Hegel’s book 'The Science of Logic'",
      title
    )
  )


usethis::use_data(lenin, overwrite = TRUE)
