install.packages("wavethresh")

library(wavethresh)

phi <- function(x) {
	if( x <= 0) {
		0
	} else if (x < 0.5) {
		1
	} else if (x < 1) {
		-1
	} else if (x >= 1) {
		0
	}
}
phi <- Vectorize(phi)

dx <- 0.001
x <- seq( -2, 3, dx )
phi(x)

plot( phi, -2, 3)

# j and k INTEGERS
# j: dialation
# k: translation
wavelets <- function(j,k,x) {
	2^(j/2) * phi( 2^j * x - k)
}

w <- wavelets( 0, 1.3, x)
plot( x, w, type="l" )

w1 <- wavelets( 0, 0, x)
w2 <- wavelets( 0, 0, x)
plot( x, w1, type="l")
lines( x, w2, col="red")
lines( x, w1*w2, col="blue", lwd=4)
sum(w1*w2)*dx
