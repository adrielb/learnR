library(AER)

# Making custom summary() for OOP {{{
normsample <- function( n, ... ) {
  rval  <- rnorm( n, ... )
  class(rval)  <-  "normsample"
  return(rval)
}

x <- normsample( 10, mean =5 )
class(x)

summary( x )

summary.normsample <- function( obj, ... ) {
  rval <- c(length(obj), mean(obj), sd(obj))
  names(rval)  <-  c( "sample size", "mean", "standard deviation" )
  return( rval )
}

summary( x )
plot(x)
# }}}

# ploting  {{{
data("Journals")
Journals$citeprice <- Journals$price / Journals$citations
attach( Journals )

plot( log(subs), log(citeprice) )
rug( log(subs) )
rug( log(citeprice), side=2 )
detach( Journals )

# or in one line without 'attach'
plot( log(subs) ~ log(citeprice), data=Journals )

# plot a function
curve( dnorm
      , from=-5
      , to = 5
      , col = "slategray"
      , lwd = 13
      , main = "Density asdfsdf"
)

data( "CPS1985" )
str( CPS1985 )

# probability density 
hist( log(CPS1985$wage), freq=FALSE )
lines( density(log(CPS1985$wage)) , col=4 )

attach(CPS1985)

occupation
tab <- table(occupation)
str(tab)
prop.table(tab)

barplot(tab)
pie(tab)

# }}}



