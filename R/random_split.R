#'
#' @return
#' @author Michal Burda
#' @export
random_split <- function(data, cfg) {
    by <- sample(colnames(data$x), 1)
    cutpoint <- sample(data$x[[by]], 1)

    structure(list(label = paste(by, '<=', cutpoint),
                   by = by,
                   cutpoint = cutpoint),
              class = 'random_split')
}
