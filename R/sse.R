#' Compute Sum of Squared Error (SSE)
#'
#' @return
#' @author Michal Burda
#' @export
sse <- function(x) {
    sum((x - mean(x))^2)
}
