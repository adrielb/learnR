x <- seq( -9, 9, 0.01)

k <- exp( -abs( sin(x) ))

plot( x, k ) 

phi <- function(x) { 
	c( 1, x, x*x ) 
}
phi <- Vectorize( phi )

phi( 3 )

w <- c(5,2,.1)

w * phi( 3 )

N <- 8
x <- seq( -4, 4, length.out=N)
PHI <- as.matrix( phi( x ) )
y <- t(PHI) %*% w
plot( x, y )

library(MASS)



sigma.w <- matrix( rep( 1, N*N ), N,N) 
sigma.w <- diag( N )
prior.w <- mvrnorm( n=100, mu=rep(0, N), Sigma=sigma.w )
plot( prior.w[,c(3,1)] )


# simulated data# {{{
N <- 100
X <- c(runif(N/2, -10, -3), runif(N/2, 3, 10))
Xs <- seq( -14, 14, length.out=140)
f <- 0.3*X^2 + 4*cos(2*X) + 10
noise <- 1e-0
Y <- f + rnorm(N,sd=noise)
plot(X,Y)
# }}}

# Squared exponential covariance function# {{{
scale <- 1.0
k <- function( x1, x2 ) {
	0*1e0*exp( -0.5*(x1-x2)^2 / scale ) +
	0*1e0*exp( -0.5*(x1-x2)^2 / 10*scale ) +
  1*1e0*x1%*%x2*exp( -0.5*(x1-x2)^2 / 1*scale ) +
	1e0
}
k <- Vectorize( k )
k(0, Xs)
plot( Xs, k(1, Xs) )
# }}}

fbar <- function( xs ) {
	a %*% k(xs,X)
}
fbar <- Vectorize(fbar)

K <- outer( X, X, k)
U <- chol(K + noise*diag(N))
a <- backsolve( U, backsolve( U, Y, transpose=TRUE))
plot( X, Y, col='blue', pch=19, xlim=c(-15,15), ylim=c(0, 45) )
points( Xs, fbar( Xs ), col='green', pch=19 )

image( sort(K) )








