#'
#' @return
#' @author Michal Burda
#' @export
predict.pc_transform <- function(obj, data) {
    as.numeric(predict(obj$fit, data))
}
