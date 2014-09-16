help(solve)

help( '[[' )

# list installed packages
library()

# list all objects (variables/arrays/strings/functions/...)
objects()
ls()

# remove var from session
rm(x)

# vector
x <- c(10.3, 3.5, 7.2)

help(c)

1/x

y <- c( x, 0, x )

seq( -4, 4 ) -> s3

help(seq)

s4 <- seq( from=-4, by=0.2, length=10)

s5 <- rep( x, times=3 )

s6 <- rep( x, each=3 )

temp <- x > 8

labs <- paste( c("X","Y"), 1:10, sep='')

z <- 1:8

digits <- as.character(z)

d <- as.integer( digits )

e <- numeric()

e[3] <- 12

length(e)

attr( e, "dim" )

help( factor )

# a factor is a vector used to specify a discrete classification (grouping) of
# the components of other vectors of the same length

state <- c("tas", "sa",  "qld", "nsw", "nsw", "nt",  "wa",  "wa",
             "qld", "vic", "nsw", "vic", "qld", "qld", "sa",  "tas",
             "sa",  "nt",  "wa",  "vic", "qld", "nsw", "nsw", "wa",
             "sa",  "act", "nsw", "vic", "vic", "act")

statef <- factor( state )

levels (statef)

# arrays

dim(z) <- c(3,5,100)

help(unlist)

# packages
library()

library(dlm)

search()
