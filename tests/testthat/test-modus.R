test_that('modus', {
  expect_equal(modus(c(1:5, 3)), 3)
  expect_equal(modus(c(T, F, F, T, F, F, T)), F)
  expect_equal(modus(c(1, NA, 3, NA, NA, 1)), NA_real_)
  expect_equal(modus(c(1, NA, 3, NA, NA, 1), na.rm = TRUE), 1)

  fact <- factor(c('a', 'b', 'b', 'c', 'a', 'b'),
                 levels = letters[1:5])
  expect_equal(modus(fact), factor('b', levels = letters[1:5]))
})
