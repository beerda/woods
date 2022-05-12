remove_constants <- function(data) {
    const <- sapply(data$x, function(col) { all(duplicated(col)[-1]) })
    data$x <- data$x[, !const, drop = FALSE]

    data
}
