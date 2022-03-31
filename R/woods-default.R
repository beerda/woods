#' Train the double random forest
#'
#' @return the double random forest model
#' @author Michal Burda
#' @import assertthat
#' @export
woods.default <- function(y,
                          x,
                          n_tree = 2,
                          max_height = NA,
                          node_size = 1) {
    assert_that(is.count(n_tree))
    assert_that(is.na(max_height) || is.count(max_height))
    assert_that(is.count(node_size))

    data <- woods_data(y = y, x = x)

    cfg <- list(max_height = max_height,
                node_size = node_size,
                prepare_tree_data = identity,
                prepare_node_data = identity,
                find_best_split = random_split,
                create_result = mode_result)

    model <- lapply(seq_len(n_tree), function(i) tree(data, cfg))

    structure(list(call = match.call(),
                   model = model),
              class = 'woods')
}
