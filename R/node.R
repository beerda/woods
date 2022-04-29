node <- function(data, cfg) {
    if (!is.na(cfg$max_height) && cfg$max_height <= 1) {
        res <- leaf(data, cfg)

    } else {
        node_data <- cfg$prepare_node_data(data)
        split_def <- cfg$find_best_split(node_data, cfg)
        split_data <- split(split_def, data, cfg)

        if (length(split_data$left$y) < cfg$node_size || length(split_data$right$y) < cfg$node_size) {
            res <- leaf(data, cfg)

        } else {
            cfg$max_height <- cfg$max_height - 1
            res <- structure(list(split = split_def,
                                  left = node(split_data$left, cfg),
                                  right = node(split_data$right, cfg)),
                             class = 'node')
        }
    }

    res
}


leaf <- function(data, cfg) {
    structure(list(result = cfg$create_result(data)),
              class = c('node', 'leaf'))
}


#' @export
is.node <- function(x) {
    inherits(x, 'node')
}


#' @export
is.leafnode <- function(x) {
    inherits(x, 'node') && inherits(x, 'leaf')
}


#' @export
print.node <- function(x, prefix, ...) {
    if (!is.null(x$split)) {
        cat(prefix, x$split$label, ' (', class(x$split)[1], ')', '\n', sep = '')
        prefix <- paste0(prefix, '    ')
        print(x$left, prefix)
        print(x$right, prefix)

    } else {
        cat(prefix, x$result$label, '\n', sep = '')
    }
}
