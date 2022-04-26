#'
#' @return
#' @author Michal Burda
#' @export
information_gain <- function(y, by) {
    assert_that(is.logical(by))

    m <- mean(by)

    m * entropy(y[by]) + (1 - m) * entropy(y[!by])
}
