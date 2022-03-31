#' Create the empty Gauss rulebase
#'
#' @param n_inputs the number of input variables
#' @param n_parts the number of Gauss fuzzy sets to partition the space of each variable to
#' @return An instance of the `gaus_rulebase` S3 class, which is a list with the following elements:
#'     - n_inputs - the number of input variables
#'     - n_parts - the number of fuzzy sets in the partitioning of the space of each input variable
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
gauss_rulebase <- function(n_inputs, n_parts) {
    mat <- matrix(0, nrow = n_inputs, ncol = n_parts)

    args <- rep(list(seq_len(n_parts)), n_inputs)
    args <- c(args, list(KEEP.OUT.ATTRS = FALSE))
    antecedents <- do.call(expand.grid, args)
    antecedents <- as.matrix(antecedents)
    dimnames(antecedents) <- NULL

    consequents <- matrix(0, ncol = nrow(antecedents), nrow = n_inputs + 1)

    structure(list(n_inputs = n_inputs,
                   n_parts = n_parts,
                   means = mat,
                   stdevs = mat,
                   antecedents = antecedents,
                   consequents = consequents),
              class = 'gauss_rulebase')
}


#' @export
is.gauss_rulebase <- function(x) {
    inherits(x, 'gauss_rulebase')
}
