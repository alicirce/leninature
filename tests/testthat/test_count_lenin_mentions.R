test_that("string count over lenin works", {
  count_df <- count_lenin_mentions(c("dog", "cat"), T, T, F)
  expect_true(inherits(count_df, "data.frame"))
  expect_equal(nrow(count_df), 104)
  expect_named(
    count_df,
    c("url", "title", "text_annotation", "text", "year", "mentions", "word")
  )
})
