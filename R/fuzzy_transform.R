#'
#' @return
#' @author Michal Burda
#' @export
#' @import lfl
fuzzy_transform <- function(data, cfg) {
    partitions <- cfg$ft_partitions

    if (nrow(data$x) < partitions^ncol(data$x)) {
        return(NULL)
    }

    y <- data$y
    levs <- NULL
    if (is.factor(y)) {
        levs <- levels(y)
        i <- runif(length(levs))
        i[which.max(i)] <- 1    # ensure at least one level is selected
        i[which.min(i)] <- 0    # ensure at least one level is not selected
        levs <- levs[i > 0.5]
        y <- as.numeric(y %in% levs)
    }

    breaks <- lapply(data$x, equifreq, partitions, 'infinity', 'infinity')
    x <- as.matrix(data$x)
    xmemb <- fcut(x, breaks = breaks)
    fit <- ft(x, xmemb, y, order = 1)

    structure(list(fit = fit,
                   breaks = breaks,
                   levels = levs),
              class = 'fuzzy_transform')
}
