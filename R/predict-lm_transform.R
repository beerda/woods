#'
#' @return
#' @author Michal Burda
#' @export
predict.lm_transform <- function(obj, data) {
    colnames(data) <- paste0('x.', colnames(data))
    res <- suppressWarnings(predict.glm(obj$fit, data))

    res
}
