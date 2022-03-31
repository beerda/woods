test_that("woods_data", {
    y <- 1:5
    x <- data.frame(a = 2 * (1:5), b = 3 * (1:5))
    d <- woods_data(y = y, x = x)

    expect_true(is.woods_data(d))
    expect_equal(d$x, x)
    expect_equal(d$y, y)

    i <- c(T, T, F, T, F)
    d2 <- d[i, ]

    expect_true(is.woods_data(d2))
    expect_equal(d2$x, x[i, , drop=FALSE])
    expect_equal(d2$y, y[i])

    d2 <- d[, 'a']
    expect_true(is.woods_data(d2))
    expect_true(is.data.frame(d2$x))
    expect_equal(d2$x, data.frame(a = x$a))
    expect_equal(d2$y, y)
})


test_that("woods_data with single column x", {
    y <- 1:5
    x <- data.frame(a = 2 * (1:5))
    d <- woods_data(y = y, x = x)

    expect_true(is.woods_data(d))
    expect_true(is.data.frame(d$x))
    expect_equal(d$x, x)
    expect_equal(d$y, y)


    i <- c(T, T, F, T, F)
    d2 <- d[i, ]

    expect_true(is.woods_data(d2))
    expect_true(is.data.frame(d2$x))
    expect_equal(d2$x, x[i, , drop=FALSE])
    expect_equal(d2$y, y[i])
})
