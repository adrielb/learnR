# 2 - Wavelets
library(wavethresh)

y <- c(1,1,7,9,2,8,8,6)
length(y)

# Haar wavelets
ywd <- wd( y, filter.number=1, family="DaubExPhase")

names(ywd)

ywd$filter

# wavelet coef
ywd$D

accessD( ywd, level=2)

plot(ywd)

# as matrix transform
W1 <- t(GenW( filter.number=1, family="DaubExPhase"))
print( W1)

# orthogonal
W1 %*% t(W1)

# 2.2.7 Haar wavelet examples
yy <- DJ.EX()$doppler
yy <- DJ.EX()$blocks
plot(yy)

yywd <- wd( yy, filter.number=1, family="DaubExPhase")
x <- 1:1024

oldpar <- par( mfrow=c(2,2) )

plot( x, yy, type="l", xlab="x", ylab="Doppler" )
plot( x, yy, type="l", xlab="x", ylab="Doppler" )

plot( yywd, main="" )
plot( yywd, scaling="by.level", main="")


accessD( wd( DJ.EX()$blocks), level=8)[1:15]
