# Data structures

#   type:            1d       2d       nd
#   homogeneous:     Vector   Matrix   Array
#   heterogrenous:   List     Data

# no 0d types, scalars are length one

# str(): human readable description of R data structure

#
# Vectors
#  1. typeof() 
#  2. length()
#  3. attributes()

# is.vector(): TRUE if its a vector with no attr
# is.atomic() || is.list() : test if actually a vector

# Types of atomic vectors
#  1. logical
#  2. integer
#  3. numeric 
#  4. character
# rare types
#  5. complex
#  6. raw

# c() : combine, creates atomic vectors
dbl_var <- c( 1, 2.5, 5.4 )
str(dbl_var)

# L suffix: get integers
int_var <- c(1L, 6L, 10L)
str( int_var )

# TRUE and FALSE create logical vectors
log_var <- c( TRUE, T, FALSE, F )
str( log_var )

chr_var <- c( "some", "strings" )

# atomic vectors are always flat, even when nesting c()'s'
c( 1, c( 2, c( 3, 4 ) , NA ) )

#  Type and tests
int_var <- c( 1L, 7L, 10L)
typeof( int_var )
is.integer( int_var )
is.atomic( int_var )

dbl_var <- c( 1, 3.4, 22.1 )
typeof( dbl_var )
is.double( dbl_var )
is.atomic( dbl_var )

# True for both double and integer
is.numeric( int_var )
is.numeric( dbl_var )

# Coercion - different types coerced to most flexible type
# logical -> integer -> double -> character

# yields a character
str( c( "a", 1 ) )

# TRUE = 1, FALSE = 0
x  <-  c( F, F, T )
as.numeric( x )
sum( x )
mean( x )
