#'
#' @return
#' @author Michal Burda
#' @export
igr_condition <- cutpoint_finder_factory(
    compute_criterion = function(y, indices) { igr_by_indices(y, indices) },
    which_criterion = which.max,
    type = 'igr'
)
