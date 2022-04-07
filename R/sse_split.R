#'
#' @return
#' @author Michal Burda
#' @export
sse_split <- function(data, cfg) {
    assert_that(is.numeric(data$y))

    splits <- lapply(colnames(data$x), function(by) {
        le <- compute_sse(data$y, data$x[[by]], FALSE)
        g <- compute_sse(data$y, data$x[[by]], TRUE)
        sse <- le$sse + g$sse
        i <- which.min(sse)
        cutpoint <- le$x[i]

        structure(list(label = paste(by, '<=', cutpoint),
                       by = by,
                       cutpoint = cutpoint,
                       sse = sse[i]),
                  class = 'sse_split')
    })

    sse <- sapply(splits, function(s) s$sse)
    best <- which.min(sse)

    splits[[best]]
}


compute_sse <- function(y, x, decreasing) {
    model <- data.frame(y = y, x = x)
    model <- model[order(model$x, decreasing = decreasing), ]
    model$ysq <- model$y^2
    model$cumsum_y <- cumsum(model$y)
    model$cumsum_ysq <- cumsum(model$ysq)
    model$count <- seq_len(nrow(model))
    model$mean <- model$cumsum_y / model$count
    last <- model[nrow(model), , drop = FALSE]

    model$sse <- model$cumsum_ysq  - 2 * model$mean * model$cumsum_y + model$mean^2 * model$count
    if (decreasing) {
        model <- model[order(model$x), ]
        model$sse <- c(model$sse[-1], 0)
    }

    model[-nrow(model), ]
}
