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
                          n_tree = 500,
                          mtry = if (is.factor(y)) floor(sqrt(ncol(x))) else max(floor(ncol(x) / 3), 1),
                          max_height = NA,
                          node_size = if (is.factor(y)) 1 else 5,
                          resample_rows = TRUE,
                          principal_component = FALSE,
                          linear_model = FALSE,
                          hypersphere = FALSE,
                          f_transform = FALSE) {
    assert_that(is.atomic(y) && !is.null(y))
    assert_that(is.data.frame(x))
    assert_that(is.count(n_tree))
    assert_that(is.na(max_height) || is.count(max_height))
    assert_that(is.count(node_size))
    assert_that(is.flag(principal_component))
    assert_that(is.flag(linear_model))
    assert_that(is.flag(hypersphere))
    assert_that(is.flag(f_transform))

    data <- woods_data(y = y, x = x)

    cat('Running woods with principal_component=', principal_component,
        ' linear_model=', linear_model,
        ' hypersphere=', hypersphere,
        ' f_transform=', f_transform, '\n', sep='');

    if (is.numeric(data$y)) {
        find_best_split <- sse_condition
        create_result <- mean_result
        leaf_type <- 'mean'
        split_type <- 'sum of squared error'
        levels <- NULL
    } else {
        find_best_split <- igr_condition
        create_result <- mode_result
        leaf_type <- 'mode'
        split_type <- 'information gain'
        levels <- levels(data$y)
    }

    resample <- resampling_factory(rows = if (resample_rows) identity else NULL,
                                   cols = mtry)

    transformations <- list()
    if (principal_component) {
        transformations$..PC.. = pc_transform
    }
    if (linear_model) {
        transformations$..LM.. = lm_transform
    }
    if (hypersphere) {
        transformations$..HS.. = hypersphere_transform
    }
    if (f_transform) {
        transformations$..FT.. = fuzzy_transform
    }

    cfg <- list(max_height = max_height,
                node_size = node_size,
                prepare_tree_data = identity,
                prepare_node_data = resample,
                transformations = transformations,
                find_best_split = find_best_split,
                create_result = create_result)

    model <- lapply(seq_len(n_tree), function(i) tree(data, cfg))

    structure(list(call = match.call(),
                   model = model,
                   split_type = split_type,
                   leaf_type = leaf_type,
                   variables = colnames(x),
                   levels = levels),
              class = 'woods')
}


#' @author Michal Burda
#' @export
is.woods <- function(x) {
    inherits(x, 'woods') &&
        is.list(x) &&
        !is.null(x$call) &&
        !is.null(x$model) &&
        !is.null(x$split_type) &&
        !is.null(x$leaf_type) &&
        !is.null(x$variables)
}


#' Print the trained double random forest
#'
#' @author Michal Burda
#' @export
print.woods <- function(x, ...) {
    cat('Call: ')
    print(x$call)
    cat('Split: ', x$split_type, '\n', sep = '')
    cat('Leaves: ', x$leaf_type, '\n', sep = '')
    cat('\nModel:\n')
    print(x$model)
}
