#' Train the double random forest
#'
#' @return the double random forest model
#' @author Michal Burda
#' @import assertthat
#' @export
woods <- function(...) {
    UseMethod('woods')
}


#' Train the double random forest
#'
#' @return the double random forest model
#' @author Michal Burda
#' @export
woods.formula <- function(formula,
                          data,
                          subset = NULL,
                          na.action = na.fail,
                          ...) {
    mf <- match.call(expand.dots = FALSE)
    m <- match(c('formula', 'data', 'subset', 'na.action'), names(mf), 0L)
    mf <- mf[c(1L, m)]
    mf$drop.unused.levels <- TRUE
    mf[[1L]] <- quote(stats::model.frame)
    mf <- eval(mf, parent.frame())

    mt <- attr(mf, 'terms')
    attr(mt, 'intercept') <- 0

    y <- model.response(mf)
    attr(y, 'na.action') <- attr(mf, 'na.action')

    mf <- model.frame(terms(reformulate(attributes(mt)$term.labels,
                                        response = NULL,
                                        intercept = FALSE)),
                      data.frame(mf))

    res <- woods.default(y, mf, ...)
    res$call <- match.call()
    res$na.action <- attr(mf, 'na.action')
    #res$terms <- mt

    res
}

#' Train the double random forest
#'
#' @return the double random forest model
#' @author Michal Burda
#' @export
woods.default <- function(y,
                          x,
                          n_tree = 2,
                          mtry = ceiling(sqrt(ncol(x))),
                          max_height = NA,
                          node_size = 1) {
    assert_that(is.count(n_tree))
    assert_that(is.na(max_height) || is.count(max_height))
    assert_that(is.count(node_size))

    data <- woods_data(y = y, x = x)

    cfg <- list(max_height = max_height,
                node_size = node_size,
                prepare_tree_data = identity,
                prepare_node_data = resampling_factory(cols = mtry),
                find_best_split = random_split,
                create_result = mode_result)

    model <- lapply(seq_len(n_tree), function(i) tree(data, cfg))

    structure(list(call = match.call(),
                   model = model),
              class = 'woods')
}


#' Print the trained double random forest
#'
#' @author Michal Burda
#' @export
print.woods <- function(x, ...) {
    cat('Call:\n')
    print(x$call)
    cat('\nModel:\n')
    print(x$model)
}
