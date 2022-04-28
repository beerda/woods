#' Compute the Information Gain Ratio (IGR)
#' @return
#' @author Michal Burda
#' @export
#' @seealso https://scientistcafe.com/ids/splitting-criteria.html
igr <- function(x1, x2) {
    prop <- length(x1) / (length(x1) + length(x2))
    before <- entropy(c(x1, x2))
    after <- prop * entropy(x1) + (1 - prop) * entropy(x2)
    si <- entropy(c(rep(1, length(x1)), rep(0, length(x2))))

    (before - after) / si
}
