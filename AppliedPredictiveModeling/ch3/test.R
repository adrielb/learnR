install.packages( "caret" )

library(ggplot2)
library(dplyr)
library(caret)
library(e1071)
library(AppliedPredictiveModeling)

# Box Cox to resolve skewness# {{{
BoxCox <- function ( x, l ) {
  (x^l-1) / l
}

x <- seq(-5,5,length.out=100)  
bc <- BoxCox( x, 2 )
plot( x, bc, ylim=c(-5,5) )
lines( x, BoxCox( x, -1 ))
lines( x, BoxCox( x, 0.5 ))
# }}}

# spatial sign transform # {{{
n <- 1000
df <- data.frame( a=rnorm(n), b=rnorm(n) )

df$s <- sqrt(df$a^2 + df$b^2)
df$a2 <- df$a / df$s
df$b2 <- df$b / df$s

ggplot( data=df, aes(x=a, y=b)) +
  geom_point() +
  ggtitle( "original data" )

ggplot( data=df, aes(x=a2, y=b2)) +
  geom_point() +
  ggtitle( "spatial sign transform" )

qplot( x=seq_along(df$s), y=s, data=df, geom="point")
# }}}

apropos('geom')

?geom_point

RSiteSearch( 'geom_point'  )

install.packages( "AppliedPredictiveModeling" )

# load data
data(segmentationOriginal)

typeof(segmentationOriginal)

names(segmentationOriginal)

nrow( segmentationOriginal)

# delete columns
segData <- segmentationOriginal %>% subset( Case == "Train" )
cellID <- segData$Cell
class <- segData$Class
case <- segData$Case
segData <- segData[,-(1:3)]

# columns with binary data
statusColNum <- grep( "Status", names(segData) )

# remove those cols
segData <- segData[, -statusColNum]

names(segmentationOriginal)

#
# Transformations
install.packages( "e1071" )


skewness(segData$AngleCh1)

skewValues <- apply( segData, 2, skewness )

head( skewValues )

hist( skewValues )

qplot( x=skewValues, geom="bar")

df <- data.frame( skewValues )
df$v=names(skewValues)
df <- df %>% arrange( skewValues )
head(df)

qplot( x=v, y=skewValues, data=df, geom='bar', stat='identity')

# estimating boxcox transform parameter

Ch1AreaTrans <- BoxCoxTrans( segData$AreaCh1 )

head( segData$AreaCh1 )

predict( Ch1AreaTrans, head( segData$AreaCh1 ))

pcaObject <- prcomp(segData, 
                    center = TRUE,
                    scale. = TRUE )

# Calc cummulated percentages
percentVariance <- pcaObject$sd^2 / sum( pcaObject$sd^2 ) * 100

qplot( x=seq_along(percentVariance), y= percentVariance )

head( pcaObject$x[,1:4] )

head( pcaObject$rotation[,1:4])

# spatial sign transform
ss <- spatialSign( segData )

qplot( x=ss[,7], y=ss[,2] )

# administer a series of transformations
trans <- preProcess( segData,
                    method = c("BoxCox", "center", "scale", "pca"))

transformed <- predict( trans, segData )

#
# Filtering - near-zero variance predictors

nearZeroVar( segData )

# filter correlated predictors
correlations <- cor( segData )
dim( correlations)

install.packages( "corrplot" )

library(corrplot)

corrplot( correlations, order="hclust")

highCorr <- findCorrelation( correlations, cutoff = 0.75)

filteredSegData <- segData[, -highCorr]

#
# Creating Dummy Variables

raw <- read.csv("../ch2/vehicles.csv")



head(carSubset)









