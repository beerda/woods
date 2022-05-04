test_that("split_data.default", {
    y <- 1:5
    x <- data.frame(a = 2 * (1:5), b = 3 * (1:5))
    d <- woods_data(y = y, x = x)
    cfg <- list()

    i <- c(T, T, F, T, F)
    r <- split_data(i, d, cfg)

    expect_true(is.list(r))
    expect_true(is.woods_data(r$left))
    expect_true(is.woods_data(r$right))
    expect_equal(r$left$x, x[i, , drop=FALSE])
    expect_equal(r$left$y, y[i])
    expect_equal(r$right$x, x[!i, , drop=FALSE])
    expect_equal(r$right$y, y[!i])
})
