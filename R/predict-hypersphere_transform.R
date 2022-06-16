#'
#' @return
#' @author Michal Burda
#' @export
predict.hypersphere_transform <- function(obj, data) {
    data <- data[, names(obj$scale_means), drop = FALSE]
    xx <- lapply(seq_along(data), function(i) (data[[i]] - obj$scale_means[i]) / obj$scale_sds[i])
    xx <- matrix(unlist(xx), ncol = length(xx))

    apply(xx, 1, function(row) {
        sum((row - obj$centroid)^2)
    })
}
