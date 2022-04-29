#'
#' @return
#' @author Michal Burda
#' @export
predict.tree <- function(object, newdata, ...) {
    predict(object$root, newdata, ...)
}
