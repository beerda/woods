#'
#' @return
#' @author michal burda
#' @export
sse_condition <- cutpoint_finder_factory(
    compute_criterion = function(y, indices) { sse(y[indices]) + sse(y[!indices]) },
    which_criterion = which.min,
    type = 'sse'
)
