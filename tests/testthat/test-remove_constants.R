test_that('remove_constants (no constant)', {
    y <- 1:5
    x <- data.frame(a = 2 * (1:5), b = 3 * (1:5))
    d <- woods_data(y = y, x = x)

    res <- remove_constants(d)
    expect_equal(res, d)
})


test_that('remove_constants (single constant)', {
    y <- 1:5
    x <- data.frame(a = 2 * (1:5), b = rep(100, 5))
    d <- woods_data(y = y, x = x)

    res <- remove_constants(d)
    expect_true(is.woods_data(res))
    expect_equal(nrow(res$x), 5)
    expect_equal(ncol(res$x), 1)
    expect_equal(res$x$a, x$a)
    expect_equal(res$y, y)
})


test_that('remove_constants (all constant)', {
    y <- 1:5
    x <- data.frame(a = rep(1, 5), b = rep(100, 5))
    d <- woods_data(y = y, x = x)

    res <- remove_constants(d)
    expect_true(is.woods_data(res))
    expect_equal(nrow(res$x), 5)
    expect_equal(ncol(res$x), 0)
    expect_equal(res$y, y)

    res <- remove_constants(d)
    expect_true(is.woods_data(res))
    expect_equal(nrow(res$x), 5)
    expect_equal(ncol(res$x), 0)
    expect_equal(res$y, y)
})
