library(dlm)

data <-  ts(read.table("Datasets/invest2.dat", 
                        colClasses = "numeric")[,2],
            start = 1960 )

plot( data 
     ,type = 'p'
     ,ylab = "Investment"
     )

modLinear <- dlmModPoly( dV = 10
                        ,dW = c(102236,321803))
modLinear <- dlmModPoly( dV = 10
                        ,dW = c(102236,321803))
filterLinear <- dlmFilter( data, modLinear )
forecastLinear <- dlmForecast( filterLinear, n = 5 )
lines( filterLinear$f )

modLocal <- dlmModPoly( dV = 10
                       ,dW = c( 0, 515939 ))
filterLocal <- dlmFilter( data, modLocal )
forecastLocal <- dlmForecast( filterLocal, n = 5 )

plot( data 
     ,type = 'p'
     ,ylab = "Investment"
     ,xlim = c(1960, 2006)
     ,ylim = c(2000, 21000)
     )

lines( filterLinear$f )
lines( filterLocal$f )

lines( forecastLinear$f )
lines( forecastLocal$f )

filterLinear

resid <- residuals( filterLinear, sd = FALSE )

plot( resid )

qqnorm( resid )
qqline( resid )

tsdiag( filterLinear )

#
# measures of forecasting accuracy
# MAD - mean absolute deviation
# MSE - mean square error
# MAPE - mean absolute percentage error
# Theil U - Compares MSE of model to MSE of "no-change" model
# Theil U < 1 : model produces better forecasts than trivial model
e <- filterLinear$f - data
e <- e[-(1:5)]
plot( e )

residuals( filterLinear )$sd
MAD <- mean( abs(e) )
MSE <- mean( e^2 )
MAPE <- mean( abs(e) / data[-(1:5)] )
TheilUmodel <- sum( e^2 )
TheilUnoChnage <- sum( diff(data[-(1:4)])^2 )
TheilU <- sqrt( TheilUmodel / TheilUnoChnage )

lines( filterLinear$m[,1])

plot( filterLinear$m )

#
# smoothing
smoothLinear <- dlmSmooth( filterLinear )

plot( smoothLinear$s )
