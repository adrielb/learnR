library(dplyr)
library(tidyr)
library(lattice)
library(ggplot2)
library(caret)
library(e1071)
library(ggplot2)
library(AppliedPredictiveModeling)
library(kernlab)
data(twoClassData)

str(predictors)

str(classes)

df <- data.frame( predictors, classes)
head(df)

ggplot( data=df, aes(x=PredictorA, y=PredictorB, color=classes)) +
  geom_point(size=5)

# Data Splitting
set.seed(1)

trainingRows <- createDataPartition( classes, p=0.80, list=FALSE)

trainPredictors <- predictors[trainingRows,]

trainClasses <- classes[trainingRows]

testPredictors <- predictors[-trainingRows,]

testClasses <- classes[-trainingRows]

?maxDissim

df$isTraining <- FALSE
head(df)

df$isTraining[trainingRows] <- TRUE
head(df,20)

head(df)
dfmelt <- df %>% gather( A, B, c(classes, isTraining))
head(dfmelt)
str(dfmelt)

ggplot() +
  geom_point( data=df, size=5, aes(x=PredictorA, y=PredictorB,color=classes) ) +
  geom_point( data=df, size=2, aes(x=PredictorA, y=PredictorB,color=isTraining))


# Resampling
set.seed(1)

repeatedSplits <- createDataPartition( trainClasses, 
                                      p = 0.80,
                                      times = 3)
str(repeatedSplits)


ggplot() +
geom_point(data=df[repeatedSplits$Resample1,], aes(x=PredictorA, y=PredictorB)) +
geom_point(data=df[repeatedSplits$Resample2,], aes(x=PredictorA, y=PredictorB)) + 
geom_point(data=df[repeatedSplits$Resample3,], aes(x=PredictorA, y=PredictorB)) 


set.seed(1)

cvSplits <- createFolds(trainClasses, 
                        k = 10,
                        returnTrain = TRUE)

str( cvSplits )

fold1 <- cvSplits[[1]]

cvPredictors1 <- trainPredictors[ fold1, ]
cvClasses1 <- trainClasses[fold1]

# basic model building in R
trainPredictors <- predictors[trainingRows,]
trainPredictors <- as.matrix( trainPredictors )

knnFit <- knn3( x = trainPredictors,
                y = trainClasses,
                k = 5)

testPredictions <- predict( knnFit, newdata = testPredictors, type="class")

#
# Determination of Tuning Parameters

# e1071 - tune()
# ipred - errorest()
# caret - train()
data(GermanCredit)
str(GermanCredit)

nearZeroVar(GermanCredit)

gc <- GermanCredit[1:5]
str(gc)
gc["ResidenceDuration"] <- factor( gc[,"ResidenceDuration"] )
gc$Class <- GermanCredit[,"Class"]
str(gc)

pairs(gc)

install.packages( "GGally" )

library(GGally)

ggpairs(gc) 

ggpairs(gc, color="Class")

# ~/apps/R/library/AppliedPredictiveModeling/chapters/04_Over_Fitting.R

install.packages( c("kernlab", "doMC") )

#
# Between-Model Comparisons
