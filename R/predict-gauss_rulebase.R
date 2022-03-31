#'
#' @return
#' @author Michal Burda
#' @export
predict.gauss_rulebase <- function(rulebase, inputs, ...) {
    fire <- gauss_firing(rulebase, inputs)
    cons <- gauss_consequent(rulebase, inputs)

    sum(cons * fire) / sum(fire)
}


# Compute the matrix of membership degrees for each input (rows) and each
# partitioning Gauss fuzzy set (cols)
gauss_membership <- function(rulebase, inputs) {
    assert_that(is.vector(inputs) && is.numeric(inputs))
    assert_that(is.gauss_rulebase(rulebase))
    assert_that(length(inputs) == rulebase$n_inputs)

    1 / (1 + ((inputs - rulebase$means) / rulebase$stdevs)^2)
}


# Return the firing strength of the rules in the rulebase for the given input
# as a numeric vector.
gauss_firing <- function(rulebase, inputs) {
    memb <- gauss_membership(rulebase, inputs)
    fire <- sapply(seq_len(rulebase$n_inputs),
                   function(i) memb[i, rulebase$antecedents[, i]])
   apply(fire, 1, prod)
}


# Compute the value of the linear functions in the consequents of the rulebase
gauss_consequent <- function(rulebase, inputs) {
    as.vector(c(1, inputs) %*% rulebase$consequents)
}
