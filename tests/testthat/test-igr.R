test_that('igr', {
    y1 <- factor(c(rep(0, 25), rep(1, 5)), levels=0:1)
    y2 <- factor(c(rep(1, 20), rep(0, 0)), levels=0:1)
    x <- factor(c(rep(0, length(y1)), rep(1, length(y2))), levels=0:1)

    expect_equal(igr(y1, y2), 0.61 / entropy(x),
                 tolerance = 0.0001)
})
