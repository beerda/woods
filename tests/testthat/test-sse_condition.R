test_that('sse_condition', {
    x <- c(1, 2, 3, 4, 5)
    y <- c(2, 5, 1, 4, 3)

    sumfun <- function(y) sum((y - mean(y))^2)
    ssefun <- function(i) sumfun(y[1:i]) + sumfun(y[(i + 1):5])

    res <- sse_condition(woods_data(y = y, x = data.frame(x = x)),
                         list())

    expected <- sapply(1:4, ssefun)
    best <- which.min(expected)

    expect_true(is.list(res))
    expect_true(inherits(res, 'cutpoint_condition'))
    expect_equal(res$var, 'x')
    expect_equal(res$cutpoint, x[best])
    expect_equal(res$type, 'sse')
    expect_equal(res$criterion, expected[best])
    expect_equal(res$label, paste('x <=', x[best]))
})
