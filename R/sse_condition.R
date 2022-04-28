#'
#' @return
#' @author michal burda
#' @export
sse_condition <- cutpoint_finder_factory(
    compute_criterion = function(y1, y2) { sse(y1) + sse(y2) },
    which_criterion = which.min,
    type = 'sse'
)
