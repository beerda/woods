#' Compute the Information Gain Ratio (IGR)
#' @return
#' @author Michal Burda
#' @export
#' @seealso https://scientistcafe.com/ids/splitting-criteria.html
#' @import forcats
igr <- function(x1, x2) {
    lenxx <- length(x1) + length(x2)
    prop1 <- length(x1) / lenxx
    prop2 <- length(x2) / lenxx
    before <- entropy(fct_c(x1, x2))
    after <- prop1 * entropy(x1) + prop2 * entropy(x2)
    si <- entropy_prob(prop1, prop2)

    (before - after) / si
}


#' Compute the Information Gain Ratio (IGR)
#' @return
#' @author Michal Burda
#' @export
#' @seealso https://scientistcafe.com/ids/splitting-criteria.html
igr_by_indices <- function(x, indices) {
    if (!is.factor(x)) {
        x <- factor(x)
    }
    .igr_by_indices(x, as.logical(indices))
}
