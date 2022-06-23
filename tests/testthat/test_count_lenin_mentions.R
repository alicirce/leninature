test_that("String counts work", {
  # sheep tests word boundaries
  # cow tests capitalization
  text_to_search <- "Cow cow pig Horsesheep sheep cow sheeppig"
  search1 <- count_text_mentions(text_to_search, c("cow", "sheep"), TRUE)
  search2 <- count_text_mentions(text_to_search, c("cow", "sheep"), FALSE)
  expect_equal(search1$mentions[search1$word == "cow"], 3L)
  expect_equal(search2$mentions[search1$word == "cow"], 2L)
  expect_equal(search1$mentions[search1$word == "sheep"], 1L)
  expect_true(inherits(search1, "data.frame"))
  expect_equal(nrow(search2), 2L)
  expect_named(search1, c("mentions", "word"))
})

test_that("string count over data frame works", {
  test_df <- data.frame(
    rownum = 1:3,
    text = c(
      "Cow cow pig Horsesheep sheep cow sheeppig",
      "Pig sheep",
      "horse"
    )
  )
  words_to_find <- c("cow", "sheep", "pig")
  count_df <- count_mentions_in_dataframe(words_to_find, test_df)
  expect_true(inherits(count_df, "data.frame"))
  expect_equal(nrow(count_df), nrow(test_df) * length(words_to_find))
  expect_equal(as.character(count_df$word), rep(words_to_find, 3))
  expect_equal(count_df$mentions, c(3, 1, 1, 0, 1, 1, 0, 0, 0))
})
