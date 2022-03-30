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

    mf <- model.frame(terms(reformulate(attributes(mt)$term.labels, response = )),
                      data.frame(mf))

    res <- woods.default(y, mf, ...)
    res$call <- match.call()
    res$na.action <- attr(mf, 'na.action')
    #res$terms <- mt

    res
}
