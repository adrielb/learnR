library(inline)

fibR <- function(n) {
	if (n==0) return(0)
	if (n==1) return(1)
	return (fibR(n-1) + fibR(n-2))
}

fibR( 10 )


incltxt <- '
int fibonacci( const int x ) {
	if ( x == 0 ) return 0;
	if ( x == 1 ) return 1;
	return fibonacci( x-1 ) + fibonacci( x-2 );
}
'

fibRcpp <- cxxfunction(signature(xs="int"),
											 plugin="Rcpp",
											 incl=incltxt,
											 body='
	int x = Rcpp::as<int>(xs);
	int fib = fibonacci(x);
	return Rcpp::wrap(fib);
')

fibRcpp( 10 )


# using attributes
sourceCpp( "fibonacci.cpp" )
fibonacci( 20 )

# memoization in R
mfibR <- local({
	memo <- c(1,1,rep(NA,1000))
	f <- function(x) {
		if (x==0) return(0)
		if (x <0) return(NA)
		if (x>length(memo)) stop("x too big")
		if (!is.na(memo[x])) return( memo[x] )
		ans <- f(x-2) + f(x-1)
		memo[x] <- ans
		ans
	}
})

mfibR( 10 )

# memoization in C++
mincltxt <- '
#include <algorithm>
#include <stdexcept>
#include <cmath>
#include <iostream>
class Fib {
public:
	Fib( unsigned int n = 1000 ) {
		memo.resize(n);
		std::fill( memo.begin(), memo.end(), NAN);
		memo[0] = 1.0;
		memo[1] = 1.0;
	}
	double fibonacci( int x ) {
		if( x < 0 ) {
			return( (double) NAN);
		}
		if( x >= (int) memo.size() ) 
			throw std::range_error(\"x too large\");
		if (! ::isnan( memo[x] ) )
			return memo[x];
		memo[x] = fibonacci(x-2) + fibonacci(x-1);
		return memo[x];
	}
private:
	std::vector<double> memo;
};
'

mfibRcpp <- cxxfunction(signature(xs="int"),
												plugin="Rcpp",
												includes=mincltxt,
												body='
int x = Rcpp::as<int>(xs);
Fib f;
return Rcpp::wrap( f.fibonacci(x-1) );
')

mfibRcpp(10)


