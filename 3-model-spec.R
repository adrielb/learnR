library(dlm)

data <-  ts(read.table("Datasets/lakeSuperior.dat", 
                        skip = 3,
                        colClasses = "numeric")[,2],
            start = 1900 )

plot( data 
     ,type = 'p'
     ,ylab = "Precipitation"
     )

W  <- 0.121
V  <- 9.465
W  <- .1
V  <- 10
signalToNoise  <- W / V
model <- dlmModPoly( order = 1, dV = V, dW = W )
filter <- dlmFilter( data, model )

sqCt = sqrt(unlist( dlmSvd2var(filter$U.C, filter$D.C) ))
plot( dropFirst( sqCt ))

# 90% CI = 100 - 2 * 0.05
cInterval <- qnorm( 0.05, lower = FALSE ) * sqCt
ci <- as.vector( filter$m ) + cInterval %o% c(-1,1)

mtci = cbind( filter$m, ci )
mtci = dropFirst( mtci )

plot( 
     mtci,
     plot.type = "s",
     lty=c(1,5,5),
     ylim = c(20,40)
)

lines( data
      ,type = 'p')

#
# smoothing

smooth <- dlmSmooth( filter )

sqSt <- sqrt(unlist( dlmSvd2var(smooth$U.S, smooth$D.S) )) 
plot(sqSt)

# 90% CI = 100 - 2 * 0.05
cInterval <- qnorm( 0.05, lower = FALSE ) * sqSt
ci <- as.vector( smooth$s ) + cInterval %o% c(-1,1)

stci = cbind( smooth$s, ci )
stci = dropFirst( stci )

plot( 
     stci,
     plot.type = "s",
     lty=c(1,5,5),
     ylim = c(20,40)
)

lines(data
      ,type='p')

