#'
#' @return
#' @author Michal Burda
#' @export
gini_condition <- function(data, cfg) {
    assert_that(is.factor(data$y))

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

    cutpoints <- lapply(colnames(data$x), function(var) {
        res <- list(value = 0, gini = 1)
        points <- data$x[[var]]
        if (is.numeric(points)) {
            o <- order(points)
            y <- as.integer(data$y)
            n <- nlevels(data$y)
            res <- .gini_split_numeric(points, o - 1, y - 1, n)
        } else {
            stop('not yet implemented')
        }

        res
    })

    gini <- sapply(cutpoints, function(res) res$gini)
    values <- sapply(cutpoints, function(res) res$value)
    best <- which.min(gini)

    cutpoint_condition(var = colnames(data$x)[best],
                       cutpoint = values[best],
                       type = 'gini',
                       criterion = gini[best])
}
