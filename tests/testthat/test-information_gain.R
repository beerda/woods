test_that('information_gain', {
  expect_equal(information_gain(y = c(rep(1, 5), rep(2, 25), rep(1, 20)),
                                by = c(rep(TRUE, 30), rep(FALSE, 20))),
               0.39, tolerance = 0.0001)
})
