#'
#' @return
#' @author michal burda
#' @export
cutpoint_condition <- function(var, cutpoint, type, criterion, ...) {
    structure(list(label = paste(var, '<=', cutpoint),
                   var = var,
                   cutpoint = cutpoint,
                   type = type,
                   criterion = criterion,
                   ...),
              class = 'cutpoint_condition')
}
