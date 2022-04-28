test_that('igr_condition', {
    x <- c(1, 2, 3, 4, 5)
    y <- c(T, T, F, T, F)

    igfun <- function(i) {
        e1 <- entropy(y[1:i])
        if (i < 5) {
            e2 <- entropy(y[(i+1):5])
        } else {
            e2 <- 0
        }
        x <- c(rep(1, i), rep(2, 5 - i))
        si <- entropy(x)
        ratio <- i / length(y)
        e <- ratio * e1 + (1 - ratio) * e2

        (entropy(y) - e) / si
    }


    res <- igr_condition(woods_data(y = y, x = data.frame(x = x)),
                         list())

    expected <- sapply(1:4, igfun)
    best <- which.max(expected)

    expect_true(is.list(res))
    expect_true(inherits(res, 'cutpoint_condition'))
    expect_equal(res$var, 'x')
    expect_equal(res$cutpoint, x[best])
    expect_equal(res$type, 'igr')
    expect_equal(res$criterion, expected[best])
    expect_equal(res$label, paste('x <=', x[best]))
})
