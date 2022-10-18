#'
#' @return
#' @author Michal Burda
#' @export
pc_transform <- function(data, cfg) {
    fit <- try(prcomp(data$x, center = TRUE, scale. = TRUE, rank. = 1),
               silent = TRUE)

    if (inherits(fit, 'try-error')) {
        return(NULL)
    }

    structure(list(fit = fit),
              class = 'pc_transform')
}
