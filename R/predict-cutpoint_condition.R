#' Returns vector of logical values indicating satisfiability of the condition in data rows
#'
#' @return
#' @author Michal Burda
#' @export
predict.cutpoint_condition <- function(object, newdata, ...) {
    assert_that(is.cutpoint_condition(object))
    assert_that(is.data.frame(newdata))

    newdata[[object$var]] <= object$cutpoint
}
