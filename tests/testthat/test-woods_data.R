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


test_that("woods data conversions to numeric", {
    y <- 1:5
    x <- data.frame(a = c(T, T, F, T, F),
                    b = factor(letters[1:5], levels = letters, ordered = TRUE),
                    c = factor(letters[2:6], levels = letters, ordered = TRUE),
                    d = factor(letters[c(1, 1, 2, 3, 2)], levels = letters[1:3], ordered = FALSE),
                    z = 5:1)
    d <- woods_data(y = y, x = x)

    expect_true(is.woods_data(d))
    expect_true(is.data.frame(d$x))
    expect_equal(ncol(d$x), 7)
    expect_equal(d$x$a, c(1, 1, 0, 1, 0))
    expect_equal(d$x$b, 1:5)
    expect_equal(d$x$c, 2:6)
    expect_equal(d$x$d.a, c(1, 1, 0, 0, 0))
    expect_equal(d$x$d.b, c(0, 0, 1, 0, 1))
    expect_equal(d$x$d.c, c(0, 0, 0, 1, 0))
    expect_equal(d$x$z, 5:1)

})


test_that("woods_data subsetting numeric y", {
    y <- 1:5
    x <- data.frame(a = 11:15,
                    b = 21:25)
    d <- woods_data(y = y, x = x)

    d <- d[c(T, T, F, F, F), ]
    expect_true(is.woods_data(d))
    expect_true(is.data.frame(d$x))
    expect_equal(ncol(d$x), 2)
    expect_equal(d$x$a, 11:12)
    expect_equal(d$x$b, 21:22)
    expect_equal(d$y, 1:2)

})


test_that("woods_data subsetting factor y", {
    y <- factor(letters[1:5])
    x <- data.frame(a = 11:15,
                    b = 21:25)
    d <- woods_data(y = y, x = x)

    d <- d[c(T, T, F, F, F), ]
    expect_true(is.woods_data(d))
    expect_true(is.data.frame(d$x))
    expect_equal(ncol(d$x), 2)
    expect_equal(d$x$a, 11:12)
    expect_equal(d$x$b, 21:22)
    expect_equal(d$y, factor(letters[1:2], levels = letters[1:5]))

})
