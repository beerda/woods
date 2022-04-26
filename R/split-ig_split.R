#'
#' @return
#' @author Michal Burda
#' @export
split.ig_split <- function(def, data, cfg) {
    indices <- data$x[[def$by]] <= def$cutpoint

    split(indices, data, cfg)
}
