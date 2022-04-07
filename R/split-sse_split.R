#'
#' @return
#' @author Michal Burda
#' @export
split.sse_split <- function(variables) {
    indices <- data$x[[def$by]] <= def$cutpoint

    split(indices, data, cfg)
}
