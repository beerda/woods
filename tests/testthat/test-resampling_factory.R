test_that("resampling_factory", {
    set.seed(234)

    d <- woods_data(y = 1:5,
                    x = data.frame(a = 2 * (1:5), b = 3 * (1:5), c = 1:5, d = 1:5))

    f <- resampling_factory(rows = NULL, cols = NULL)
    expect_true(is.function(f))
    r <- f(d)
    expect_true(is.woods_data(r))
    expect_equal(length(r$y), 5)
    expect_equal(nrow(r$x), 5)
    expect_equal(ncol(r$x), 4)
    expect_true(all(r$y == d$y))

    f <- resampling_factory(rows = identity, cols = identity)
    expect_true(is.function(f))
    r <- f(d)
    expect_true(is.woods_data(r))
    expect_equal(length(r$y), 5)
    expect_equal(nrow(r$x), 5)
    expect_equal(ncol(r$x), 4)
    expect_true(any(r$y != d$y))

    f <- resampling_factory(rows = 3, cols = 2)
    expect_true(is.function(f))
    r <- f(d)
    expect_true(is.woods_data(r))
    expect_equal(length(r$y), 3)
    expect_equal(nrow(r$x), 3)
    expect_equal(ncol(r$x), 2)

    f <- resampling_factory(rows = 100, cols = 100)
    expect_true(is.function(f))
    r <- f(d)
    expect_true(is.woods_data(r))
    expect_equal(length(r$y), 5)
    expect_equal(nrow(r$x), 5)
    expect_equal(ncol(r$x), 4)

    f <- resampling_factory(rows = function(x) floor(x / 2),
                            cols = function(x) floor(x / 2) - 1)
    expect_true(is.function(f))
    r <- f(d)
    expect_true(is.woods_data(r))
    expect_equal(length(r$y), 2)
    expect_equal(nrow(r$x), 2)
    expect_equal(ncol(r$x), 1)
})
