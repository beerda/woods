test_that("mode_result", {
    d <- woods_data(y = c(1, 2, 2, 3, 5),
                    x = data.frame(a = 1:5))

    r <- mode_result(d)
    expect_true(is.list(r))
    expect_equal(r$label, 'mode 2')
    expect_equal(r$value, 2)
})
