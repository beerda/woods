#'
#' @return
#' @author Michal Burda
#' @export
t.list <- function(x, ...) {
    assert_that(is.list(x))

    lengths <- sapply(x, length)
    lengths <- unique(lengths)
    if (length(lengths) != 1) {
        stop('Cannot transpose lists with elements of different lengths')
    }

    do.call(Map, c(f = c, x))
}
