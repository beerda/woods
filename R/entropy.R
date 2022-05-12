#'
#' @return
#' @author Michal Burda
#' @export
entropy <- function(x) {
    p <- table(x)
    p <- proportions(p)
    p <- as.vector(p)

    res <- p * log2(p)
    res[is.nan(res)] <- 0

    -1 * sum(res)
}


#'
#' @return
#' @author Michal Burda
#' @export
entropy_prob <- function(...) {
    p <- c(...)
    res <- p * log2(p)
    res[is.nan(res)] <- 0

    -1 * sum(res)
}
