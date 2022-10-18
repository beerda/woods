#'
#' @return
#' @author Michal Burda
#' @export
lm_transform <- function(data, cfg) {
    family <- if (is.numeric(data$y)) gaussian() else binomial()
    data <- as.data.frame(data)
    fit <- suppressWarnings(glm(y ~ .,
                                data = data,
                                family = family))

    structure(list(fit = fit),
              class = 'lm_transform')
}
