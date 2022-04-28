#'
#' @return
#' @author Michal Burda
#' @export
cutpoint_finder_factory <- function(compute_criterion, which_criterion, type) {
    function(data, cfg) {
        if (length(data$y) <= 0) {
            stop('Unable to find cutpoint on empty data')

        } else if (length(data$y) <= 1) {
            var <- colnames(data$x)[1]
            cutpoint <- data$x[[1]][1]
            criterion <- 0

        } else {
            variants <- lapply(colnames(data$x), function(var) {
                data.frame(var = var, cutpoint = unique(data$x[[var]]))
            })
            variants <- do.call(rbind, variants)

            variants$criterion <- sapply(seq_len(nrow(variants)), function(i) {
                var <- variants$var[i]
                cutpoint <- variants$cutpoint[i]
                x <- data$x[[var]]
                indices <- x <= cutpoint
                y1 <- data$y[indices]
                y2 <- data$y[!indices]
                compute_criterion(y1, y2, x)
            })

            best <- which_criterion(variants$criterion)
            var <- variants$var[best]
            cutpoint <- variants$cutpoint[best]
            criterion <- variants$criterion[best]
        }

        cutpoint_condition(var = var, cutpoint = cutpoint, type = type, criterion = criterion)
    }
}
