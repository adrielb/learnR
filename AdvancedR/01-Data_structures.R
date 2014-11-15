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

#
# Lists
#   elements can be of any type
#   constructed using list()
x <- list( 1:3, "a", c(T,F,T), c(2.8, 1.2) )

# lists are recursive vectors
x <- list( list( list("a") ) )
str(x)
is.recursive(x)

# c() will combine several lists into one
x <- list( list( 1,2 ), c(3,4) )
y <- c( list( 1, 2 ), c(3, 4) )
str(x)
str(y)
typeof(y)
is.list( y )

# convert list into atomic vector
z <- unlist( x )
typeof(z)

#
# Exercises
# 3. 
c(1, FALSE)
c("a", 1)
c(list(1), "a")
c( TRUE, 1L )

# 
# Attributes
#   arbitrary metadata
#   attr( x, name) - individual access
#   attributes( x ) - all at once
y <- 1:10
attr( y, "my_atr" ) <- "some vec"
attr( y, "my_atr" )
str( attributes( y ) )

# structure() adds attributes to objects
structure( 1:10, my_attribute = "another vec" )

# attributes are lost when modifying a vector
attributes( y[1] )
attributes( sum( y[1] ) )

# Only three attributes are not lost
#  1. names()
#  2. dim()
#  3. class()

# Name a vector
#  1. at creation
#  2. at modification
#  3. at copy
y <- c( a = 1, 2, 3 )
attributes( y )

x <- 1:3
names( x ) <- c( "a", "b", "c" )

x <- setNames( 1:3, c("a", "b", "c") )

names(y)
names(x)
names(z)

# removes names
unname( x )

#
# Factors
#   stores categorical data
#   class() of 'factor' - like an integer vector 
#   levels() set of allowed values
x <- factor( c("a", "b", "b", "a") )
class(x)
levels(x)

# cant use values not in levels()
x[2] <- "c"

# cant combine factors
c( factor( "a" ), factor( "b" ) )

# can use factors that are not even in the dataset
sex_char <- c("m", "m", "m")
sex_factor <- factor( sex_char, levels=c("m","f") )
table(sex_factor)

# non-numeric values produce factor cols instead of NA's
z <- read.csv( text = "value\n12\n1\n.\n9" )
typeof(z$value)
as.double( z$value )
class( z$value )
as.double( as.character( z$value ) )

z <- read.csv( text = "value\n12\n1\n.\n9", na.strings = "." )
typeof(z$value)
class( z$value )
z$value

# use stringsAsFactors = FALSE to prevent confounding data coercions

#
# Exercises
structure( 1:5, comment = "my attr" )
?comment

f1 <- factor( letters )
levels( f1 ) <- rev( levels( f1 ) )

f2 <- rev( factor( letters ) )
f3 <- factor( letters, levels=rev(letters) )

#
# Matrices and Arrays
#   dim() makes a vector into an array
#   a 2D array is a matrix 
a <- matrix( 1:6, ncol=3, nrow=2 )
b <- array( 1:12, c(2,3,2) )

# can also modify dim in place
c <- 1:6
dim(c) <- c(3,2)
dim(c) <- c(2,3)

# length() - nrow(), ncol() for matrices; dim() for arrays
# names()  - rownames(), colnames()     ; dimnames()
# c()      - cbind(), rbind()           ; abind()
length(a)
nrow(a)
ncol(a)
rownames(a)  <- c("A", "B")
colnames(a)  <- c("a", "b", "c")
a

length(b)
dim(b)
dimnames(b) <- list( 
                    c( "one", "two" ),
                    c( "a", "b", "c" ),
                    c( "A", "B" )
                    )
b

is.matrix()
is.array()
as.matrix()
as.array()

# 1D vectors, single row matrix, single col, or single dim array
str(1:4)
# column vector
str( matrix( 1:4, ncol=1 ) )
# row vector
str( matrix( 1:4, nrow=1 ) )
# array vector
str( array( 1:4, 4 ) )

# lists can also have their dims set
l <- list( 1:3, "a", TRUE, 1.0 )
dim(l) <- c( 2, 2 )

#
# Exercises
dim( 1:3 )

x <- matrix( 1:4, nrow=2 )
is.matrix( x )
is.array( x )

x1 <- array( 1:5, c(1,1,5) )
x2 <- array( 1:5, c(1,5,1) )
x3 <- array( 1:5, c(5,1,1) )

#
# Data frames
#  -a list of equal length vectors
df <- data.frame( x = 1:3, y = c("a", "b", "c") )
str( df )

# the default behavior is to turn strings into factors
df <- data.frame( 
                 x = 1:3, 
                 y = c("a", "b", "c"),
                 stringsAsFactors = FALSE
                 )
str( df )

typeof( df )
class( df )
is.data.frame( df )

# combining data frames with cbind(), rbind()
cbind( df, data.frame( z=1:3 ) )
rbind( df, data.frame( x=10, y="z" ) )

# use data.frame() to combine cols since cbind() may create a matrix instead
# 'bad' data frame coerced to Factor types:
bad <- data.frame( cbind( a=1:2, b=c("a", "b") ))
str(bad)

good <- data.frame( 
                   a=1:2, 
                   b=c("a", "b"),
                   stringsAsFactors = FALSE
                   )
str(good)

# Special columns
#  a column that is a list
df <- data.frame( x = 1:3 )
df$y <- list( 1:2, 1:3, 1:4 )
df

# however this fails: tries to put each list item into its own column
df <- data.frame( x = 1:3, y = list( 1:2, 1:3, 1:4 ) )

# I() - inhibits coercion 
dfI <- data.frame( 
                  x = 1:3,
                  y = I( list(1:2, 1:3, 1:4) )
                  )
str( dfI )
dfI[2, "y"]

# add a column that is a matrix or array
dfm <- data.frame( 
                  x = 1:3,
                  y = I( matrix( 1:9, nrow = 3 ) )
                  )
str(dfm)
dfm[2, "y"]

#
# Exercises
attributes( df )

df <- data.frame( 
                 x = 1:3, 
                 y = c("a", "b", "c"),
                 stringsAsFactors = FALSE
                 )
as.matrix( df )

df = data.frame( a=I(matrix()), y=I(list()) )
str( df )
