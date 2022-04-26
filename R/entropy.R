#'
#' @return
#' @author Michal Burda
#' @export
entropy <- function(y) {
    p <- table(y)
    p <- proportions(p)
    p <- as.vector(p)

    -1 * sum(p * log2(p))
}
