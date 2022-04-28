#'
#' @return
#' @author Michal Burda
#' @export
entropy <- function(x) {
    p <- table(x)
    p <- proportions(p)
    p <- as.vector(p)

    -1 * sum(p * log2(p))
}
