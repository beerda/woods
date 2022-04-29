test_that('t.list', {
  expect_equal(t(list(1:3, 11:13)), list(c(1, 11), c(2, 12), c(3, 13)))
})
