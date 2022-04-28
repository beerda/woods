#' Compute Sum of Squared Error (SSE)
#'
#' @return
#' @author Michal Burda
#' @export
#' @seealso https://scientistcafe.com/ids/splitting-criteria.html
sse <- function(x) {
    sum((x - mean(x))^2)
}
