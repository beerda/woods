#'
#' @return
#' @author Michal Burda
#' @export
split.sse_split <- function(def, data, cfg) {
    indices <- data$x[[def$by]] <= def$cutpoint

    split(indices, data, cfg)
}
