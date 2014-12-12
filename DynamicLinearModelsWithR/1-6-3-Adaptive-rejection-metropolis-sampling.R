# Log-concave density -> very efficient mcmc (ARMS)
# Gibbs would get stuck in one of the two modes
# support must be bounded convex set

bimodal <- function( x ) {
  log( prod( dnorm(x, mean = 3) ) +
       prod( dnorm(x, mean = -3) ) )
}

bimodal( c(3,3) )

supp <- function( x ) {
  all( x > (-10) ) * all( x < 10 )
}

supp( 3 )
supp( c(3,3) )
supp( c(3,30) )

x_init <- c(-2,2)

y <- arms( x_init, bimodal, supp, 5000 )

str( y )

plot( y )

