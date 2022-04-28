test_that('igr', {
    y1 <- c(rep(0, 25), rep(1, 5))
    y2 <- c(rep(1, 20), rep(0, 0))
    x <- c(rep(0, length(y1)), rep(1, length(y2)))

    expect_equal(igr(y1, y2), 0.61 / entropy(x),
                 tolerance = 0.0001)
})
