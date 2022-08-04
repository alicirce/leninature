#' Count mentions of key words in Lenin's work
#'
#' Counts how often a key word occurs in Lenin's work. Considers word
#' boundaries, optionally considers letter case.
#'
#' @param words vector of key words to search for
#' @param ignore_case logical, should case sensitivity be considered?
#' @param word_boundaries logical, should word boundaries be considered?
#' @param return_all_rows logical, return all rows, or only rows with 1+
#'   instance? It's considerably faster to only return rows with 1+ instance for
#'   large data frames and/or infrequent words.
#'
#' @returns Returns the lenin data frame with two new columns added:
#' \describe{
#'   \item{mentions}{number of occurrences of the key word in the `text` column}
#'   \item{word}{key word}
#' }
#' The data frame will be in "long" format, with a new row for each key word. If
#' `return_all_rows` is set to `FALSE` only rows with at least one mention for
#' one of the words
#' @export

count_lenin_mentions <- function(
  words,
  ignore_case = TRUE,
  word_boundaries = TRUE,
  return_all_rows = FALSE
  ) {
  lenin <- getExportedValue(getNamespace(packageName()), "lenin")
  ggtextcounts::count_mentions_in_dataframe(
    dataframe = lenin,
    words = words,
    ignore_case = ignore_case,
    word_boundaries = word_boundaries,
    return_all_rows = return_all_rows
  )
}
