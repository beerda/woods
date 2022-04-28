test_that('entropy', {
    expect_equal(entropy(factor(c(rep(1, 5), rep(2, 25)), levels=1:2)),
                 0.65, tolerance = 0.0001)
    expect_equal(entropy(factor(c(rep(1, 20), rep(2, 20)), levels=1:2)),
                 1)
    expect_equal(entropy(factor(c(rep(1, 20), rep(2, 0)), levels=1:2)),
                 0)
})
