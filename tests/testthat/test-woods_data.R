test_that("woods_data", {
    y <- 1:5
    x <- data.frame(a = 2 * (1:5), b = 3 * (1:5))
    d <- woods_data(y = y, x = x)

    expect_equal(class(d), 'woods_data')
    expect_equal(d$x, x)
    expect_equal(d$y, y)
})
