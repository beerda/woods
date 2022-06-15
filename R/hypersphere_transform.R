#'
#' @return
#' @author Michal Burda
#' @export
hypersphere_transform <- function(data) {
    if (nrow(data$x) < 5) {
        return(NULL)
    }

    med <- vapply(data$x, median, 0)
    iqr <- vapply(data$x, IQR, 0)

    if (any(iqr == 0)) {
        iqr[] <- 1   # to avoid division by 0 in predict.hypersphere_transform
    }

    structure(list(medians = med, iqr = iqr),
              class = 'hypersphere_transform')
}
