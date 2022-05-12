remove_constants <- function(data) {
    const <- sapply(data$x, is_constant)
    data$x <- data$x[, !const, drop = FALSE]

    data
}
