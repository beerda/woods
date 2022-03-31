#' Create a function for row-wise and col-wisse resampling of data
#'
#' For rows and columns, the resampling is performed with and without replacement, respectively.
#'
#' @param rows either a positive value indicating the required number of rows
#'     or a function that from a number of rows of input data computes the required number of
#'     rows to be selected
#' @param cols either a positive value indicating the required number of columns
#'     or a function that from a number of columns of input data computes the required number of
#'     columns to be selected
#' @return a single-argument function that takes an instance of the `woods_data` S3 class and
#'     resamples its values to satisfy the number of rows and columns as specified by the `rows`
#'     and `cols` arguments described above.
#' @author Michal Burda
#' @export
resampling_factory <- function(rows = identity, cols = identity) {
    assert_that(is.count(rows) || is.function(rows))
    assert_that(is.count(cols) || is.function(cols))

    result_m <- rows
    if (is.count(rows)) {
        result_m <- function(x) rows
    }

    result_n <- cols
    if (is.count(cols)) {
        result_n <- function(x) cols
    }

    function(data) {
        m <- nrow(data$x)
        n <- ncol(data$x)
        i <- sample(m, result_m(m), replace = TRUE)
        j <- sample(n, result_n(n), replace = FALSE)

        data[i, j]
    }
}
