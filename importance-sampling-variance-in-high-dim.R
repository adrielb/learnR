prod(dnorm( c(0,0) ))
pmvnorm( mean=rep(0,2),
         diag(1, nrow=2)
        )

n_samples = 10

P <- function( x ) {
  prod( dnorm( x ) )
}

Q <- function( x ) {
  prod( dnorm( x, sd = 2) )
}

Qs <- function( ndim ) {
  rnorm( ndim, sd = 2)
}
Qs(3)

PQratio <- function( n, ndim ) {
  samples <- sapply( 1:n, function(a) {
    x <- Qs(ndim) 
    Px <- P(x)
    Qx <- Q(x)
    pq = Px / Qx
  } )
  samples
}

pq = PQratio( 100, 10 )
plot(pq)

var( pq )

var_ndim <- sapply( 1:10, function(ndim) var(PQratio( 10000, ndim )) )
plot(var_ndim)

impVar <- function( D ) {
  s <- 2
  (s^2 / ( 2 - s^-2 ))^(D/2) - 1
}
dims <- seq( 1, 10, length.out=100 )
lines( dims, impVar(dims) )

