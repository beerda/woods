#'
#' @return
#' @author Michal Burda
#' @export
split_data.cutpoint_condition <- function(def, data, cfg) {
    indices <- data$x[[def$var]] <= def$cutpoint

    split_data(indices, data, cfg)
}
