#' Count mentions of key words in Lenin's work
#'
#' Counts how often a key word occurs in Lenin's work. Considers word
#' boundaries, optionally considers letter case.
#'
#' @param words vector of key words to search for
#' @param ignore_case logical, should case sensitivity be considered?
#'
#' @returns Returns the lenin data frame with two new columns added:
#' \describe{
#'   \item{mentions}{number of occurrences of the key word in the `text` column}
#'   \item{word}{key word}
#' }
#' The data frame will be in "long" format, with a new row for each key word.
#' @export

count_lenin_mentions <- function(words, ignore_case = TRUE) {
  lenin <- getExportedValue(getNamespace(packageName()), "lenin")
  count_mentions_in_dataframe(words, lenin, ignore_case)
}

#' Count occurrences of each of a vector of words in a vector of texts
#'
#' This helper function, combined with e.g. purrr, makes it easier to count how
#' often each word in a vector of words occurs within a vector of character
#' strings. Considers word boundaries, optionally considers letter case.
#'
#' @param text vector of character string to search for key words
#' @param words vector of key terms to look for
#' @param ignore_case should case (capital letters) be considered in matching?
#' @export

count_text_mentions <- function(text, words, ignore_case = TRUE) {
  setNames(
    stack(
      vapply(
        words,
        function(x) {
          suppressWarnings(
            sum(
              str_count(text, regex(paste0("\\b", x, "\\b"), ignore_case))
            )
          )
        },
        FUN.VALUE = numeric(1)
      )
    ),
    c("mentions", "word")
  )
}

#' Count number of occurrences key words in a text column of a data frame
#'
#' @inheritParams count_lenin_mentions
#' @param dataframe data frame, with a column called `"text"`
#' @noRd

count_mentions_in_dataframe <- function(words, dataframe, ignore_case = TRUE) {
  dataframe$mentions <- purrr::map(dataframe$text, count_text_mentions, words)
  tidyr::unnest(dataframe, .data$mentions)
}
