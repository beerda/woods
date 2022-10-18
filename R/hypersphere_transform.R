#'
#' @return
#' @author Michal Burda
#' @export
hypersphere_transform <- function(data, cfg) {
    if (nrow(data$x) < 5) {
        return(NULL)
    }

    means <- vapply(data$x, mean, 0)
    sds <- vapply(data$x, sd, 0)
    if (any(sds == 0)) {
        sds[] <- 1   # to avoid division by 0 in predict.hypersphere_transform
    }
    xx <- lapply(seq_along(data$x), function(i) (data$x[[i]] - means[i]) / sds[i])
    yy <- data$y

    if (!is.factor(yy)) {
        stop('only factor y is allowed in hypersphere_transform')
    }

    centers <- lapply(xx, function(val) tapply(val, yy, mean))
    centmat <- matrix(unlist(centers), ncol=length(centers)) # columns are variables, rows are y's classes
    dists <- dist(centmat)
    dists <- as.matrix(dists)
    best <- which.max(rowSums(dists))
    centroid <- centmat[best, , drop = TRUE]

    structure(list(scale_means = means,
                   scale_sds = sds,
                   centroid = centroid),
              class = 'hypersphere_transform')
}
