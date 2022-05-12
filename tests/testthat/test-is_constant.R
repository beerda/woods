test_that('is_constant', {
    expect_true(is_constant(5))
    expect_true(is_constant(rep(1, 10)))
    expect_true(is_constant(rep(NA, 10)))
    expect_true(is_constant(rep('a', 10)))

    expect_false(is_constant(1:5))
    expect_false(is_constant(c(1, 2, 2, 2, 2, 2)))
    expect_false(is_constant(c(2, 2, 1, 2, 2, 2)))
    expect_false(is_constant(c(2, 2, 2, 2, 2, 1)))
})
