#'
#' @return
#' @author Michal Burda
#' @export
print.tree <- function(x, ...) {
    print_node(x$root, '')
}


print_node <- function(node, prefix) {
    if (!is.null(node$split)) {
        cat(prefix, node$split$label, '\n', sep = '')
        prefix <- paste0(prefix, '\t')
        print_node(node$left, prefix)
        print_node(node$right, prefix)

    } else {
        cat(prefix, node$result$label, '\n', sep = '')
    }
}
