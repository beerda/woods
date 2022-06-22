#'
#' @return
#' @author Michal Burda
#' @export
#' @import lfl
predict.fuzzy_transform <- function(obj, data) {
    x <- data[, names(obj$breaks), drop = FALSE]
    x <- as.matrix(x)
    xmemb <- fcut(x, breaks = obj$breaks)

    predict(obj$fit, x, xmemb)
}
