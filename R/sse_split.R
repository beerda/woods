#' Tree node split based on the Sum of Squared Error (SSE)
#'
#' @return
#' @author Michal Burda
#' @export
#' @seealso https://scientistcafe.com/ids/splitting-criteria.html
sse_split <- function(data, cfg) {
    assert_that(is.numeric(data$y))

    if (length(data$y) <= 1) {
        return(create_sse_split(by = colnames(data$x)[1],
                                cutpoint = data$x[[1]][1],
                                sse = 0))
    }

    splits <- lapply(colnames(data$x), function(by) {
        le <- compute_sse(data$y, data$x[[by]], FALSE)
        g <- compute_sse(data$y, data$x[[by]], TRUE)
        sse <- le$sse + g$sse
        i <- which.min(sse)
        cutpoint <- le$x[i]
        create_sse_split(by, cutpoint, sse[i])
    })

    sse <- sapply(splits, function(s) s$sse)
    best <- which.min(sse)

    splits[[best]]
}


create_sse_split <- function(by, cutpoint, sse) {
    structure(list(label = paste(by, '<=', cutpoint),
                   by = by,
                   cutpoint = cutpoint,
                   sse = sse),
              class = 'sse_split')
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
