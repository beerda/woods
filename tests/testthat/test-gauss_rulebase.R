test_that("gauss_rulebase", {
    d <- woods_data(y = 1:50,
                    x = data.frame(a = 2 * (1:50), b = 3 * (1:50)))

    rb <- gauss_rulebase(d, list(n_parts = 3))

    expect_true(is.gauss_rulebase(rb))
    expect_true(is.list(rb))
    expect_equal(rb$variables, c('a', 'b'))
    expect_equal(rb$n_inputs, 2)
    expect_equal(rb$n_parts, 3)
    expect_equal(nrow(rb$means), 2)
    expect_equal(ncol(rb$means), 3)
    expect_equal(nrow(rb$stdevs), 2)
    expect_equal(ncol(rb$stdevs), 3)
    expect_equal(nrow(rb$antecedents), 3^2)
    expect_equal(ncol(rb$antecedents), 2)
    expect_equal(nrow(rb$consequents), 2 + 1)
    expect_equal(ncol(rb$consequents), 3^2)
})


test_that("gauss_rulebase (single variable)", {
    d <- woods_data(y = c(1:10, 21:30, 41:50),
                    x = data.frame(x = 2 * (1:30)))

    rb <- gauss_rulebase(d, list(n_parts = 3))

    expect_true(is.gauss_rulebase(rb))
    expect_true(is.list(rb))
    expect_equal(rb$variables, c('x'))
    expect_equal(rb$n_inputs, 1)
    expect_equal(rb$n_parts, 3)

    expect_equal(nrow(rb$means), 1)
    expect_equal(ncol(rb$means), 3)
    expect_equal(rb$means, matrix(c(mean(2 * (1:10)), mean(2 * (11:20)), mean(2 * (21:30))), ncol = 3))

    expect_equal(nrow(rb$stdevs), 1)
    expect_equal(ncol(rb$stdevs), 3)
    expect_equal(rb$stdevs, matrix(c(sd(2 * (1:10)), sd(2 * (11:20)), sd(2 * (21:30))), ncol = 3))

    expect_equal(nrow(rb$antecedents), 3^1)
    expect_equal(ncol(rb$antecedents), 1)
    expect_equal(rb$antecedents, matrix(1:3, nrow = 3))

    expect_equal(nrow(rb$consequents), 1 + 1)
    expect_equal(ncol(rb$consequents), 3^1)
})
