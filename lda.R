library(MASS)
library(dplyr)
library(ggplot2)
library(tidyr)

sigma <- matrix( c( 10, 3, 3, 2 ), 2, 2 )
s1 = mvrnorm( n=100, c(5,1), sigma  )
s2 = mvrnorm( n=100, c(1,5), sigma  )

data <- data_frame(
  x1 = c(s1[,1], s2[,1]),
  x2 = c(s1[,2], s2[,2]),
  class = c(rep(0, nrow(s1)), rep(1, nrow(s2))) %>% factor()
)
print(data)
ggplot( data, aes(x=x1, y=x2, color=class) ) + 
geom_point( shape=16, size=5 )

sol <- lda( class ~ x1 + x2, data )
print(sol)

xx=seq(-10,15,0.1)
yy=seq(-5,10,0.1)

coors <- data_frame(
  x1=rep(xx, length(yy)),
  x2=rep(yy, each=length(xx))
)
ggplot( coors, aes(x=x1, y=x2) ) +
geom_point(  )

p <- predict( sol, coors )
str(p) 

plot( p$posterior[,1] ) 

plot( as.vector(p$class) ) 

coors$p1 <- p$posterior[,1]
coors$p2 <- p$posterior[,2]
coors$class <- p$class
head(coors)

ggplot() +
geom_tile( data=coors, aes(x=x1, y=x2, fill=p1)) +
stat_contour( data=coors, breaks=c(0.5), color="green", aes(x=x1, y=x2, z=p1) ) +
geom_point( data=data, size=4, aes(x=x1, y=x2, color=class) )

# Softmax {{{
T <- rnorm(100)
plot(T)

expT <- exp(T)
sumT <- sum(expT)
softmax <- expT / sumT
plot(softmax)
sum(softmax)

plot( T, softmax )

softmax <- function( T, temp=1 ) {
  expT <- exp( T/temp )
  sumT <- sum(expT)
  expT / sumT
}

sm <- softmax( T, 0.1) 
plot(sm)
sum(sm)



# }}}
