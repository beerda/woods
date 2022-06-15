#'
#' @return
#' @author Michal Burda
#' @export
predict.hypersphere_transform <- function(obj, data) {
    data <- data[, names(obj$medians), drop = FALSE]
    res <- apply(data, 1, function(row) {
        sum(((row - obj$medians) / obj$iqr)^2)
    })

    sqrt(res)
}
