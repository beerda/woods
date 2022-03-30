tree <- function(data, cfg) {
    data <- cfg$prepare_tree_data(data)
    root <- node(data, cfg)

    structure(list(root = root),
              class = 'tree')
}


leaf_node <- function(data, cfg) {
    list(result = cfg$create_classification(data))
}


node <- function(data, cfg) {
    if (!is.na(cfg$max_height) && cfg$max_height <= 1) {
        res <- leaf_node(data, cfg)

    } else {
        node_data <- cfg$prepare_node_data(data)
        split_def <- cfg$find_best_split(node_data, cfg)
        split_data <- split(split_def, data, cfg)

        if (length(split_data$left$y) < cfg$node_size || length(split_data$right$y) < cfg$node_size) {
            res <- leaf_node(data, cfg)

        } else {
            cfg$max_height <- cfg$max_height - 1
            res <- list(split = split_def,
                        left = node(split_data$left, cfg),
                        right = node(split_data$right, cfg))
        }
    }

    res
}
