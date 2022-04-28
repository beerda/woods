#'
#' @return
#' @author Michal Burda
#' @export
split.cutpoint_condition <- function(def, data, cfg) {
    indices <- data$x[[def$var]] <= def$cutpoint

    split(indices, data, cfg)
}
