#' Thee node split based on the Information Gain (IG)
#'
#' @return
#' @author Michal Burda
#' @export
#' @seealso https://scientistcafe.com/ids/splitting-criteria.html
ig_split <- function(data, cfg) {
    if (length(data$y) <= 1) {
        return(create_ig_split(by = colnames(data$x)[1],
                               cutpoint = data$x[[1]][1],
                               ig = 0))
    }

    splits <- lapply(colnames(data$x), function(by) {
        le <- compute_entropy(data$y, data$x[[by]], FALSE)
        g <- compute_entropy(data$y, data$x[[by]], TRUE)
        ratio <- seq_len(nrow(data$x)) / nrow(data$x)
        entropy <- ratio * le$entropy + (1 - ratio) * g$entropy
        ig <- entropy[length(entropy)] - entropy
        i <- which.max(ig)
        cutpoint <- le$x[i]
        create_ig_split(by, cutpoint, ig[i])
    })

    ig <- sapply(splits, function(s) s$ig)
    best <- which.max(ig)

    splits[[best]]

}


create_ig_split <- function(by, cutpoint, ig) {
    structure(list(label = paste(by, '<=', cutpoint),
                   by = by,
                   cutpoint = cutpoint,
                   ig = ig),
              class = 'ig_split')
}


compute_entropy <- function(y, x, decreasing) {
    model <- data.frame(y = y, x = x)
    model <- model[order(model$x, decreasing = decreasing), ]

    m <- model.matrix(~ y - 1, data.frame(y = model$y))
    cum_m <- apply(m, 2, cumsum)
    p <- cum_m / seq_len(nrow(m))
    entropy <- -1 * rowSums(p * log2(p))
    entropy[is.nan(entropy)] <- 0
    model$entropy <- entropy

    if (decreasing) {
        model <- model[order(model$x), ]
        model$entropy <- c(model$entropy[-1], 0)
    }

    model
}
