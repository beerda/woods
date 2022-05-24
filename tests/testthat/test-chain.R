test_that('chain', {
    f1 <- function(x, sep = ' ') paste(x, '1', sep = sep)
    f2 <- function(x, sep = ' ') paste(x, '2', sep = sep)
    f3 <- function(x, sep = ' ') paste(x, '3', sep = sep)
    l <- list(f1, f2, f3)

    expect_equal(chain(l, '0'), '0 1 2 3')
    expect_equal(chain(l, '0', '+'), '0+1+2+3')
})
