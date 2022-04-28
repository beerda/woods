#'
#' @return
#' @author Michal Burda
#' @export
igr_condition <- cutpoint_finder_factory(
    compute_criterion = function(y1, y2) { igr(y1, y2) },
    which_criterion = which.max,
    type = 'igr'
)
