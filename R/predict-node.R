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
        tr_data <- newdata
        if (!is.null(object$transformation)) {
            preds <- lapply(object$transformation, function(f) as.numeric(predict(f, tr_data)))
            tr_data <- do.call(cbind, c(list(tr_data), preds))
        }
        condition <- predict(object$split, tr_data)
        if (length(condition) != nrow(tr_data)) {
            stop('Internal error: length of condition evaluation differs from length of data')
        }
        if (any(is.na(condition))) {
            stop('Internal error: condition is NA')
        }

        res <- rep(NA, length(condition))
        if (any(condition)) {
            res[condition] <- predict(object$left, newdata[condition, , drop = FALSE])
        }
        if (any(!condition)) {
            res[!condition] <- predict(object$right, newdata[!condition, , drop = FALSE])
        }
    }

    res
}
