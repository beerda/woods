test_that("sse_split", {
    x <- c(1, 2, 3, 4, 5)
    y <- c(2, 5, 1, 4, 3)

    sumfun <- function(y) sum((y - mean(y))^2)
    ssefun <- function(i) sumfun(y[1:i]) + sumfun(y[(i + 1):5])

    res <- compute_sse(y, x, FALSE)

    expect_true(is.data.frame(res))
    expect_equal(res$x, x[1:4])
    expect_equal(res$y, y[1:4])
    expect_equal(res$sse, sapply(1:4, function(i) sumfun(y[1:i])))

    res <- compute_sse(y, x, TRUE)

    expect_true(is.data.frame(res))
    expect_equal(res$x, x[1:4])
    expect_equal(res$y, y[1:4])
    expect_equal(res$sse, sapply(2:5, function(i) sumfun(y[i:5])))

    res <- sse_split(woods_data(y = y, x = data.frame(x = x)),
                     list())

    expected <- sapply(1:4, ssefun)
    best <- which.min(expected)

    expect_true(is.list(res))
    expect_true(inherits(res, 'sse_split'))
    expect_equal(res$by, 'x')
    expect_equal(res$cutpoint, x[best])
    expect_equal(res$sse, expected[best])
    expect_equal(res$label, paste('x <=', x[best]))
})
