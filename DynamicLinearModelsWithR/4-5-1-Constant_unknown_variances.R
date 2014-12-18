# Constant unknown variances
# observations univariate (m=1)
# time-invariant V, W
# W diagonal
# d-inverse gamma prior

library(dlm)

data <- read.table( "Datasets/invest2.dat", colClasses="numeric" )
data <- ts( data[,2]/1000, start=1960 )
plot(data)

set.seed(5672)
MCMC <- 12000

gibbsOut <- dlmGibbsDIG( data,
                        mod=dlmModPoly(2),
                        a.y=1,
                        b.y=1000,
                        a.theta=10,
                        b.theta=1000,
                        n.sample=MCMC,
                        thin=1,
                        save.states=FALSE
                        )

str( gibbsOut$dW[,"W.1"] )

burn <- 2000
use <- MCMC - burn
from <- 0.05*use

plot( gibbsOut$dV[-(1:burn)] )

plot( gibbsOut$dW[-(1:burn), "W.1"] )

plot( gibbsOut$dW[-(1:burn), "W.2"] )

plot( gibbsOut$dW[-(1:burn), "W.1"],  gibbsOut$dW[-(1:burn), "W.2"] )

plot( ergMean(gibbsOut$dV[-(1:2*burn)]),
     type = 'l',
     xlab="",
     ylab=""
     )

plot( ergMean(gibbsOut$dV[-(1:burn)]),
     type = 'l',
     xaxt='n',
     xlab="",
     ylab=""
     )
at <- pretty( c(0,use), n=3 )
at <- at[at>=from]
axis( 1, 
     at=at-from,
     labels=format(at))

mcmcMean( cbind( gibbsOut$dV[-(1:burn) ],
                 gibbsOut$dW[-(1:burn) ]) )

x <- matrix( rexp(1000), nc=4 )
plot( ts(x) )
dimnames(x) <- list( NULL, LETTERS[1:NCOL(x)] )
mcmcSD(x)
mcmcMean(x)
em <- ergMean( x, m = 51 )
plot( ts(em, start=51 ),
     xlab="Iteration",
     main="Ergodic means" 
     )

