#' Create the data structure used internally in the [woods()] algorithm.
#'
#' @param y the response vector
#' @param x the independent variables as data.frame
#' @return the S3 object of class `woods_data`
#' @author Michal Burda
#' @export
woods_data <- function(y, x) {
    assert_that(is.vector(y))
    assert_that(is.data.frame(x))

    structure(list(y = y, x = x),
              class = 'woods_data')
}


#' @export
is.woods_data <- function(x) {
    inherits(x, 'woods_data')
}


#' @export
`[.woods_data` <- function(x, i, j, drop=FALSE) {
    if (drop) warning('drop ignored')

    woods_data(y = x$y[i],
               x = x$x[i, j, drop=FALSE])
}
