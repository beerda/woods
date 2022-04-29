#'
#' @return
#' @author Michal Burda
#' @export
predict.woods <- function(object, newdata, ...) {
    assert_that(is.woods(object))
    assert_that(is.data.frame(newdata))

    missingVars <- !sapply(object$variables, function(v) v %in% colnames(newdata))
    if (sum(missingVars) > 0) {
        missingVars <- object$variables[missingVars]
        stop('Data columns not found in "newdata": ', paste(missingVars, collapse = ', '))
    }

    res <- lapply(object$model, function(m) predict(m, newdata))
    res <- t(res)

    aggreg <- ifelse(is.numeric(res), mean, modus)
    res <- lapply(res, aggreg)
    res <- unlist(res)

    if (!is.null(object$levels)) {
        res <- factor(object$levels[res], levels = object$levels)
    }

    res
}
