library( dlm )

# purely seasonal time series
# ** series has zero mean!!!

model <- dlmModSeas( 
                    frequency = 4,
                    dV = 1.0,
                    dW = c(0,0,0) )

s1 <- c( 2, 5, 4, 1 )
s1 <- s1 - mean( s1 )
s5 <- rep( s1, times=19 )
s6 <- s5 + 0.1*rnorm( length(s5) )

plot( s6 )
lines( s5 )

filtered <- dlmFilter( s6, model)

plot( s5 )
lines( filtered$f )

# should be similar
tail( filtered$m, 1 )
s1

