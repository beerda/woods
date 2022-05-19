#' Create a function for row-wise and col-wise resampling of data
#'
#' For rows and columns, the resampling is performed with and without replacement, respectively.
#'
#' @param rows either a NULL value indicating no resampling should be done at all,
#'     or a positive value indicating the required number of rows
#'     or a function that from a number of rows of input data computes the required number of
#'     rows to be selected
#' @param cols  either a NULL value indicating no resampling should be done at all,
#'     or a positive value indicating the required number of columns
#'     or a function that from a number of columns of input data computes the required number of
#'     columns to be selected
#' @return a single-argument function that takes an instance of the `woods_data` S3 class and
#'     resamples its values to satisfy the number of rows and columns as specified by the `rows`
#'     and `cols` arguments described above.
#' @author Michal Burda
#' @export
resampling_factory <- function(rows = NULL, cols = NULL) {
    assert_that(is.null(rows) || is.count(rows) || is.function(rows))
    assert_that(is.null(cols) || is.count(cols) || is.function(cols))

    row_sampler <- .create_sampler(rows, TRUE)
    col_sampler <- .create_sampler(cols, FALSE)

    function(data) {
        i <- row_sampler(nrow(data$x))
        j <- col_sampler(ncol(data$x))

        data[i, j]
    }
}


.create_sampler <- function(variant, replace) {
    if (is.null(variant)) {
        return(seq_len)
    }

    result_size <- variant
    if (is.count(variant)) {
        result_size <- function(x) variant
    }

    function(n) {
        size <- result_size(n)
        size <- min(n, size)
        sample(n, size, replace = replace)
    }
}
