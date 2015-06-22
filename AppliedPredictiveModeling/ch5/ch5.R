# 5: Measuring Performance in Regression models
library(caret)

observed <- c(0.22, 0.83, -0.12, 0.89, -0.23, -1.30, -0.15, -1.4,
              0.62, 0.99, -0.18, 0.32, 0.34, -0.30, 0.04, -0.87,
              0.55, -1.30, -1.15, 0.20)

predicted <- c(0.24, 0.78, -0.66, 0.53, 0.70, -0.75, -0.41, -0.43,
               0.49, 0.79, -1.19, 0.06, 0.75, -0.07, 0.43, -0.42,
               -0.25, -0.64, -1.26, -0.07)

residualValues <- observed - predicted
summary(residualValues)

qplot( observed, predicted, size=10, xlim=c(-1.5,1.1), ylim=c(-1.5,1.1)) +
  geom_abline( intercept=0, slope=1, size=2, color='darkred', linetype='dashed' )

qplot( predicted, residualValues, size=10 ) +
  geom_abline( intercept=0, slope=0, size=2, color='darkred', linetype='dashed' )


R2( predicted, observed)

RMSE( predicted, observed)

cor( predicted, observed)
cor( predicted, observed)^2

cor( predicted, observed, method='spearman')


library(reshape)
m<-cbind(1:4,5:8,-(5:8))
colnames(m)<-c("time","y1","y2")
m<-as.data.frame(m)
m2 <- melt(m, id="time")
m2
ggplot( data=m2, aes(x=time, y=value, color=variable)) +
  geom_line() +
  ylab( "y" )

