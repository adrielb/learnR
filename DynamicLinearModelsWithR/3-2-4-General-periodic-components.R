library(dlm)

# tau : period arg 
# q : number of harmonics

model <- 
    dlmModTrig(
               q = 2,
               tau = 130.51,
               dV = 0,
               dW = rep( c(1765e-2,3102e-4), each = 2 )
               ) + 
    dlmModPoly(
            order = 1,
            dV = 0.7452,
            dW = 0.1606
            )

sspots <- sqrt( sunspots )
sspots.smooth <- dlmSmooth( sspots, model )

# 5: local level
# 1,3: periodic components

y <- cbind( sspots,
           tcrossprod(
                      dropFirst( sspots.smooth$s[,c(1,3,5)] ),
                      matrix( c(0,0,1,1,1,0), nr = 2, byrow = TRUE)))

colnames( y ) <- c("Sunspots", "Level", "Periodic")

plot( y, yax.flip = TRUE, oma.multi = c(2,0,1,0) )

plot(sspots)
lines(y[,2])
