cat('--------------------------------------\n')

library(rmake)
library(woods)
library(caret)
library(mlbench)
library(doParallel)

methodName <- getParam('method')
dataName <- getParam('data')
targetName <- getParam('target')
targetFile <- getParam('.target')

print(methodName)
print(dataName)
print(targetName)

set.seed(335)

# prepare dataset
data(list = dataName)
d <- get(dataName)
d$ID <- NULL
d$Id <- NULL
d$id <- NULL
d <- na.omit(d)

# prepare formula
formula <- paste(targetName, '~ .')
formula <- as.formula(formula)

# prepare method
method <- if (methodName == 'woods') woodsModelInfo else methodName

# prepare train control
trControl <- trainControl(method = 'repeatedcv',
                          number = 10,
                          repeats = 1)

# fit the model in parallel
#cl <- makePSOCKcluster(14)
#registerDoParallel(cl)
fit <- train(formula,
             data = d,
             method = method,
             trControl = trControl)
#stopCluster(cl)

# print and save
print(fit)
saveRDS(fit, targetFile)
