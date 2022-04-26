test_that("ig_split", {
    x <- c(1, 2, 3, 4, 5)
    y <- c(T, T, F, T, F)

    entr <- function(y) {
        p <- proportions(table(y))
        r <- -1 * sum(p * log2(p))
        r[is.nan(r)] <- 0

        r
    }

    igfun <- function(i) {
        e1 <- entr(y[1:i])
        if (i < 5) {
            e2 <- entr(y[(i+1):5])
        } else {
            e2 <- 0
        }
        ratio <- i / length(y)
        e <- ratio * e1 + (1 - ratio) * e2

        entr(y) - e
    }

    res <- compute_entropy(y, x, FALSE)

    expect_true(is.data.frame(res))
    expect_equal(res$x, x[1:5])
    expect_equal(res$y, y[1:5])
    expect_equal(res$entropy, sapply(1:5, function(i) entr(y[1:i])))

    res <- compute_entropy(y, x, TRUE)

    expect_true(is.data.frame(res))
    expect_equal(res$x, x[1:5])
    expect_equal(res$y, y[1:5])
    expect_equal(res$entropy, c(sapply(2:5, function(i) entr(y[i:5])),
                                0))

    res <- ig_split(woods_data(y = y, x = data.frame(x = x)),
                    list())

    expected <- sapply(1:5, igfun)
    best <- which.max(expected)

    expect_true(is.list(res))
    expect_true(inherits(res, 'ig_split'))
    expect_equal(res$by, 'x')
    expect_equal(res$cutpoint, x[best])
    expect_equal(res$ig, expected[best])
    expect_equal(res$label, paste('x <=', x[best]))
})


test_that("ig_split trivial cases", {
    res <- ig_split(woods_data(y = 1, x = data.frame(x = 1)),
                    list())

    expect_true(is.list(res))
    expect_true(inherits(res, 'ig_split'))
    expect_equal(res$by, 'x')
    expect_equal(res$cutpoint, 1)
    expect_equal(res$ig, 0)
    expect_equal(res$label, 'x <= 1')
})
