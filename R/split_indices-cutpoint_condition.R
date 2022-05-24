#'
#' @return
#' @author Michal Burda
#' @export
split_indices.cutpoint_condition <- function(def, data, cfg) {
    data$x[[def$var]] <= def$cutpoint
}
