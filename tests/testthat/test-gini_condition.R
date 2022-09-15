gini <- function(l1, l2, r1, r2) {
    # l1 - number of T on the left
    # l2 - number of elements on the left
    # r1 - number of T on the right
    # r2 - number of elements on the right
    left <- 1 - ((l1 / l2)^2 + (1 - (l1 / l2))^2)
    right <- 1 - ((r1 / r2)^2 + (1 - (r1 / r2))^2)

    (left * l2 + right * r2) / (l2 + r2)
}


test_that('gini_condition', {
    x <- c(1, 2, 3, 4, 5)
    y <- factor(c(T, T, F, T, F))

    res <- gini_condition(woods_data(y = y, x = data.frame(x = x)),
                          list())

    expected <- c(gini(1, 1, 2, 4),
                  gini(2, 2, 1, 3),
                  gini(2, 3, 1, 2),
                  gini(3, 4, 0, 1))
    best <- which.min(expected)

    expect_true(is.list(res))
    expect_true(inherits(res, 'cutpoint_condition'))
    expect_equal(res$var, 'x')
    expect_equal(res$cutpoint, x[best])
    expect_equal(res$type, 'gini')
    expect_equal(res$criterion, expected[best])
    expect_equal(res$label, paste('x <=', x[best]))
})


test_that('gini_condition - repeated values', {
    x <- c(1, 2, 2, 4, 5)
    y <- factor(c(T, T, F, T, F))

    res <- gini_condition(woods_data(y = y, x = data.frame(x = x)),
                          list())

    expected <- c(gini(1, 1, 2, 4),
                  gini(2, 3, 1, 2),
                  gini(2, 3, 1, 2),
                  gini(3, 4, 0, 1))
    best <- which.min(expected)

    expect_true(is.list(res))
    expect_true(inherits(res, 'cutpoint_condition'))
    expect_equal(res$var, 'x')
    expect_equal(res$cutpoint, x[best])
    expect_equal(res$type, 'gini')
    expect_equal(res$criterion, expected[best])
    expect_equal(res$label, paste('x <=', x[best]))
})


test_that('gini_condition - repeated last', {
    x <- c(1, 2, 4, 4, 4)
    y <- factor(c(F, F, F, T, T))

    res <- gini_condition(woods_data(y = y, x = data.frame(x = x)),
                          list())

    expected <- c(gini(0, 1, 2, 4),
                  gini(0, 2, 2, 3),
                  gini(0, 2, 2, 3),
                  gini(0, 2, 2, 3))
    best <- which.min(expected)

    expect_true(is.list(res))
    expect_true(inherits(res, 'cutpoint_condition'))
    expect_equal(res$var, 'x')
    expect_equal(res$cutpoint, x[best])
    expect_equal(res$type, 'gini')
    expect_equal(res$criterion, expected[best])
    expect_equal(res$label, paste('x <=', x[best]))
})
