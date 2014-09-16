library(dlm)

rw <- dlm( 
          m0 = 0,
          C0 = 10,
          FF = 1,
          V = 1.4,
          GG = 1,
          W = 0.2)

unlist( rw )

matrix(c(1,0), nr = 1)
help(matrix)

rep( 0, 9 )

lg <- dlm( 
          FF = matrix(c(1,0), nr = 1),
          V = 1.4,
          GG = matrix( c(1,0,1,1), nr = 2 ),
          W = diag( c(0, 0.2) ),
          m0 = rep(0,2),
          C0 = 10 * diag(2)
          )

unlist( lg )

is.dlm(lg)

# Modifying DLM object
V(lg) <- 0.8
W(lg)[2,2] <- 0.5

# time-invariant: m0, C0, FF, V, GG, W
# time varying: X, JFF, JV, JGG, JW

# time varying linear regression

# covariates
x <- rnorm( 100 )

dlr <- dlm( 
           FF = matrix( c(1,0), nr = 1 ),
           V = 1.3,
           GG = diag( 2 ),
           W = diag( c(0.4, 0.2)),
           m0 = rep(0,2),
           C0 = 10*diag(2),
           JFF = matrix( c(0,1), nr=1 ),
           X = x
           )

X(dlr)

# User needs to make sure DLM is specified correctly after modifications
JV(rw) <- 1

is.dlm(rw)

dlm(rw)

# Vt = 0.75, t=1...10
# Vt = 1.25, t=11..30
X(rw) <- rep( c(0.75, 1.25), c(10,20) )

rw <- dlm(rw)

V(rw)

#
# 
rwp <- dlmModPoly( 
           order = 1,
           dV = 0.8,
           dW = 0.1,
           C0 = 100
           )

myMod <- dlmModPoly()

#
# dlm Filtering

NilePoly <- dlmModPoly( order = 1, dV = 15100, dW = 1468 )
unlist (NilePoly)

NileFilt <- dlmFilter( Nile, NilePoly )

str(NileFilt, 1)

n <- length( Nile )

attach( NileFilt )

# reconstructs variances from SVD
dlmSvd2var( U.C[[n+1]], D.C[n+1,] )

plot(
     Nile,
     type = 'p',
     col  = c("darkgrey"),
     xlab = "",
     ylab = "Level"
     )

mod1 <- dlmModPoly( 
                   order = 1,
                   dV = 15100,
                   dW = 755
                   )

NileFilt1  <- dlmFilter( Nile, mod1 )

lines( dropFirst(NileFilt1$m), lty="longdash" )

mod2 <- dlmModPoly( 
                   order = 1,
                   dV = 15100,
                   dW = 7550
                   )

NileFilt2  <- dlmFilter( Nile, mod2 )

lines( dropFirst(NileFilt2$m), lty="dotdash" )

leg <- c( "data",
         paste("filtered, W/V = ",
               format=(c(W(mod1)/V(mod1),
                         W(mod2)/V(mod2)
                         ))))

legend( "bottomright", 
       legend = leg,
       col = c("darkgrey", "black", "black"),
       lty = c("solid", "longdash", "dotdash"),
       pch = c(1,NA,NA),
       bty = "n"
       )

#
# DLM smoothing

NileSmooth <- dlmSmooth( NileFilt )

str( NileSmooth, 1 )

attach( NileSmooth )

drop( dlmSvd2var( U.S[[n+1]], D.S[n+1,] ) )

drop( dlmSvd2var( U.C[[n+1]], D.C[n+1,] ) )

drop( dlmSvd2var( U.S[[n/2+1]], D.S[n/2+1,] ) )

drop( dlmSvd2var( U.C[[n/2+1]], D.C[n/2+1,] ) )


# intervals
hwid <- qnorm( 0.25, lower = FALSE ) * sqrt( unlist( dlmSvd2var(U.S, D.S) ) )

smooth <- cbind( s, as.vector(s) + hwid %o% c(-1,1) )

plot( 
     dropFirst( smooth ),
     plot.type='s',
     type="l",
     lty=c(1,5,5),
     ylab="Level",
     xlab="",
     ylim=range(Nile)
     )

lines(Nile, type="p", col="darkgrey")

legend( 
       "bottomleft",
       col = c("darkgrey", rep("black",2)),
       lty = c(1,1,5),
       pch = c(1,NA,NA),
       bty = "n",
       legend = c("data", "smooth level", "95% probability limits")
       )

#
# DLM smoothing + seasonal
expd <- ts( 
           read.table(
                      "Datasets/qconsum.dat",
                      skip = 4,
                      colClasses = "numeric")[,1],
           start = c(1957,1),
           frequency = 4)

expd.dlm <- dlm(
                m0 = rep(0,4),
                C0 = 1e8 * diag( 4 ),
                FF = matrix( c(1,1,0,0), nr=1 ),
                V  = 1e-3,
                GG = bdiag( 
                           matrix(1),
                           matrix( c(-1,-1,-1,1,0,0,0,1,0),
                                  nr = 3,
                                  byrow = TRUE)),
                W = diag( 
                         c(771.35, 86.48, 0, 0),
                         nr = 4)
                )

plot( expd,
     xlab = "",
     ylab = "Expenditures",
     type = 'p',
     col = "darkgrey")

### Filter
expdFilt <- dlmFilter( expd, expd.dlm )

lines( dropFirst( expdFilt$m[,1] ), 
      lty = "dotdash" )

### Smooth
expdSmooth <- dlmSmooth( expdFilt )

lines( dropFirst(expdSmooth$s[,1]),
      lty = "longdash")

legend( "bottomright",
       col = c("darkgrey", rep("black", 2)),
       lty = c("solid", "dotdash", "longdash"),
       pch = c(1, NA, NA),
       bty = "n",
       legend = c("data", "filtered", "smooth")
       )

### seasonal
plot( dropFirst( expdSmooth$s[,3] ),
     type = 'o',
     xlab = "",
     ylab = "Expenditures - Seasonal",
     )
abline( h = 0 )

unlist( expdSmooth )
