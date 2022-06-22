.miParameters <- data.frame(parameter = c('mtry', 'principal_component', 'linear_model', 'hypersphere', 'f_transform'),
                            class = c('numeric', 'logical', 'logical', 'logical', 'logical'),
                            label = c('mtry', 'principal_component', 'linear_model', 'hypersphere', 'f_transform'))


.miGrid <- function(x, y, len = NULL, search = 'grid') {
    expand.grid(mtry = 2:5,
                principal_component = TRUE,
                linear_model = TRUE,
                hypersphere = TRUE,
                f_transform = TRUE)
}


.miFit <- function(x, y, wts, param, lev, last, weights, classProbs, ...) {
    woods::woods(y = y,
                 x = as.data.frame(x),
                 n_tree = 500,
                 mtry = param$mtry,
                 principal_component = param$principal_component,
                 linear_model = param$linear_model,
                 hypersphere = param$hypersphere,
                 f_transform = param$f_transform)
}


.miPredict <- function(modelFit, newdata, preProc = NULL, submodels = NULL) {
    predict(object = modelFit,
            newdata = as.data.frame(newdata))
}


.miSort <- function(x) {
    x[order(x$mtry), ]
}


.miLevels <- function(x) {
    x$levels
}


#' @export
woodsModelInfo <- list(type = c('Classification', 'Regression'),
                       library = 'woods',
                       loop = NULL,
                       parameters = .miParameters,
                       grid = .miGrid,
                       fit = .miFit,
                       predict = .miPredict,
                       prob = NULL,
                       sort = .miSort,
                       levels = .miLevels)
