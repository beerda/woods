#'
#' @return
#' @author Michal Burda
#' @export
#' @importFrom Rfast sort_unique
cutpoint_finder_factory <- function(compute_criterion, which_criterion, type) {
    function(data, cfg) {
        # empty data?
        if (length(data$y) <= 0) {
            return(NULL)
        }

        # only 1 row in data?
        if (length(data$y) <= 1) {
            return(cutpoint_condition(var = colnames(data$x)[1],
                                      cutpoint =  data$x[[1]][1],
                                      type = type,
                                      criterion = 0))
        }

        variants <- lapply(colnames(data$x), function(var) {
            points <- sort_unique(data$x[[var]])
            points <- points[-length(points)]  # remove the hightest value

            if (length(points) <= 0) {
                return(data.frame())
            }

            data.frame(var = var, cutpoint = points)
        })
        variants <- do.call(rbind, variants)

        # no applicable variants?
        if (nrow(variants) <= 0) {
            return(NULL)
        }

        variants$criterion <- sapply(seq_len(nrow(variants)), function(i) {
            var <- variants$var[i]
            cutpoint <- variants$cutpoint[i]
            x <- data$x[[var]]
            indices <- (x <= cutpoint)

            compute_criterion(data$y, indices)
        })

        best <- which_criterion(variants$criterion)

        cutpoint_condition(var = variants$var[best],
                           cutpoint = variants$cutpoint[best],
                           type = type,
                           criterion = variants$criterion[best])
    }
}
