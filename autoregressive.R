phi <- -.9910
sd <- 0.1
T = 100
e <- rnorm(T, sd=sd )
c <- 0
AR1 <- function( y, t ) {
  c + phi * y + e[t]
}
AR1(1)
yt = rep( 1, T )
for(i in 2:T) {
  yt[i]  <- AR1( yt[i-1], i )
}
plot(yt, type="b")
lines(e)
c / (1-phi)
sd / (1-phi)^2

hist(yt)
