#'
#' @return
#' @author Michal Burda
#' @export
predict.node <- function(object, newdata, ...) {
    assert_that(is.node(object))
    assert_that(is.data.frame(newdata))

    if (is.leafnode(object)) {
        res <- rep(object$result$value, nrow(newdata))
    } else {
        condition <- predict(object$split, newdata)
        if (length(condition) != nrow(newdata)) {
            stop('Internal error: length of condition evaluation differs from length of data')
        }
        if (any(is.na(condition))) {
            stop('Internal error: condition is NA')
        }

        res <- rep(NA, length(condition))
        res[condition] <- predict(object$left, newdata[condition, ])
        res[!condition] <- predict(object$right, newdata[!condition, ])
    }

    res
}
