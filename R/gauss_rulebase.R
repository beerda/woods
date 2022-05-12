#' Create the empty Gauss rulebase
#'
#' @return An instance of the `gaus_rulebase` S3 class, which is a list with the following elements:
#'     - n_inputs - the number of input variables
#'     - n_parts - the size of the partition of each input variable, i.e., the number of fuzzy sets
#'       in the partitioning of the space of each input variable
#'     - means - an $(n_inputs, n_parts)$ matrix of the $m$ parameters of the Gauss distribution, for
#'       input $i$ and part $j$
#'     - stdevs - an $(n_inputs, n_parts)$ matrix of the $\sigma$ parameters of the Gauss distribution,
#'       for input $i$ and part $j$
#'     - antecedents - an $(k, n_inputs)$ matrix of combinations of parts assigned to inputs
#'     - consequents - an $(n_inputs + 1, k)$ matrix of linear function
#'
#'     Here $k = n_parts^{n_inputs}$ stands for the number of rules in the rulebase.
#' @author Michal Burda
#' @export
gauss_rulebase <- function(data, cfg) {
    assert_that(is.woods_data(data))
    assert_that(is.list(cfg))
    assert_that(is.numeric(data$y))

    n_inputs <- ncol(data$x)

    split_indices <- ceiling(seq_along(data$y) / (length(data$y) / cfg$n_parts))
    split_indices <- split(seq_along(data$y), split_indices)

    ind_r <- rep(seq_len(n_inputs), times = cfg$n_parts)
    ind_c <- rep(seq_len(cfg$n_parts), each = n_inputs)
    sorted_x <- lapply(data$x, sort)

    .execute_on_split <- function(f) {
        function(row, col) {
            x <- sorted_x[[row]]
            i <- split_indices[[col]]
            f(x[i])
        }
    }

    means <- mapply(.execute_on_split(mean), ind_r, ind_c)
    means[is.na(means)] <- 0    # if not enough data (1) in a split
    dim(means) <- c(n_inputs, cfg$n_parts)

    stdevs <- mapply(.execute_on_split(sd), ind_r, ind_c)
    stdevs[is.na(stdevs)] <- 1  # if not enough data (2) in a split
    stdevs <- stdevs
    dim(stdevs) <- c(n_inputs, cfg$n_parts)


    args <- rep(list(seq_len(cfg$n_parts)), n_inputs)
    args <- c(args, list(KEEP.OUT.ATTRS = FALSE))
    antecedents <- do.call(expand.grid, args)
    antecedents <- as.matrix(antecedents)
    dimnames(antecedents) <- NULL


    consequents <- matrix(0, ncol = nrow(antecedents), nrow = n_inputs + 1)

    rb <- structure(list(variables = colnames(data$x),
                         n_inputs = n_inputs,
                         n_parts = cfg$n_parts,
                         means = means,
                         stdevs = stdevs,
                         antecedents = antecedents,
                         consequents = consequents),
                    class = 'gauss_rulebase')

    weights <- apply(data$x, 1, function(row) { gauss_firing(rb, row) })

    d <- data$x
    colnames(d) <- paste0('d', seq_along(d))
    d$y <- data$y

    .fit_lm <- function(ante) {
        w <- weights[ante, ]
        fit <- lm(y ~ ., data = d, weights = w)
        as.vector(coef(fit))
    }

    rb$consequents <- sapply(seq_len(nrow(weights)), .fit_lm)
    rb$consequents[is.na(rb$consequents)] <- 0    # this occurs if an input is linear combination of other inputs

    rb
}


#' @export
is.gauss_rulebase <- function(x) {
    inherits(x, 'gauss_rulebase')
}
