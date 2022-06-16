#'
#' @return
#' @author Michal Burda
#' @export
inspect <- function(fit) {
    assert_that(is.woods(fit))

    res <- lapply(seq_along(fit$model), function(i) {
        inspect_node(fit$model[[i]]$root, i, 1)
    })

    do.call(rbind, res)
}


inspect_node <- function(node, tree_number, depth) {
    res <- data.frame(tree = tree_number,
                      depth = depth,
                      n = node$n)

    if (is.leafnode(node)) {
        res$node <- 'leaf'
        res$var <- NA
    } else {
        res$node <- 'split'
        res$var <- node$split$var
        res <- rbind(res, inspect_node(node$left, tree_number, depth + 1))
        res <- rbind(res, inspect_node(node$right, tree_number, depth + 1))
    }

    res
}
