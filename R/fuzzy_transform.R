#'
#' @return
#' @author Michal Burda
#' @export
#' @import lfl
fuzzy_transform <- function(data) {
    y <- data$y
    levs <- NULL
    if (is.factor(y)) {
        levs <- levels(y)
        i <- runif(length(levs))
        i[which.max(i)] <- 1    # ensure at least one level is selected
        levs <- levs[i > 0.5]
        y <- as.numeric(y %in% levs)
    }

    breaks <- lapply(data$x, equifreq, 3, 'infinity', 'infinity')
    x <- as.matrix(data$x)
    xmemb <- fcut(x, breaks = breaks)
    fit <- ft(x, xmemb, y, order = 0)

    structure(list(fit = fit,
                   breaks = breaks,
                   levels = levs),
              class = 'fuzzy_transform')
}
