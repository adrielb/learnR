# 02 - Subsetting

# types: [, [[ and $
# compliments str()

# Outline
#   Data types for atomic vectors, lists, matricies, data frames and S3 objects
#   Operators [[ and $
#   Combining subsetting and assignment
#   Applications


#
# Data Types
x <- c( 3.1, 4.2, 7.8, 1.0 )

# Positive Integers
x[ c(3,1) ]

x[ order(x) ]

x[ c(2,2,2,2) ]

# Reals are truncated
x[ c( 3.2 ) ]

# Negative Ints - omit elements
x[ c(-1) ]

# Can't mix pos and neg 
x[ c(3, -1) ]

# Logical vectors
x[ c(FALSE,TRUE,FALSE,TRUE) ]

# Short logical vecs are cycled
x[ c( TRUE, FALSE ) ]
x[ c( TRUE, FALSE, TRUE, FALSE ) ]

# NA's are passed thru
x[ c( TRUE, FALSE, NA, TRUE ) ]

# Nothing - returns original vec
x[]

# Zero
x[0]

# Using names
(y <- setNames( x, letters[1:4] ))

y[ c("d", "a") ]

y[ c( "a", "a", "a" ) ]

z <- c( abc = 1, def = 2 )
str(z)

z[ c( "abc", "a", "def" ) ]


# Matrices and arrays
a <- matrix( 1:9, nrow = 3 )
colnames( a ) <- c( "A", "B", "C" )
a

# Blank subsetting returns all rows or cols
a[1:2, ]

a[ c( F,T,F ), c( "B", "A" ) ]

# drop second row
a[-2, ]

# drop second col
a[ , -2 ]

# matricies can be subsetted as a single vector
(vals <- outer( 1:5, 1:5, FUN="paste", sep=","))
vals[ c( 4, 15 ) ]

vals[ 1:3, c(T,T,F,F,F)  ]

# selection with integer matrix 
vals <- outer( 1:5, 1:5, FUN="paste", sep="," )
select <- matrix( ncol = 2, byrow = TRUE,
                 c( 1,1,
                    3,1,
                    2,4))
vals[select]



# Data Frames
df <- data.frame( 
                 x = 1:3,
                 y = 3:1,
                 z = letters[1:3]
                )
df
df[ df$x == 2, ]

df[ c(1, 3) ]
df[ , c( "x", "z" ) ]
df[ c(1, 3), ]

df[ df$x<4,  ]

# simplfication
str( df["x"] )
str( df[, "x"] )

# Exercises
mtcars[ mtcars$cyl == 4,  ]
mtcars[2:4,]
mtcars[ mtcars$cyl <= 5, ]
mtcars[ mtcars$cyl == 4 | mtcars$cyl == 6,  ]

x <- 1:5
x[NA]
x[NA_real_]

x <- outer( 1:5, 1:5, FUN="*" )
x[ upper.tri(x, diag = TRUE ) ]

str(mtcars)
mtcars[1:20] # cols
mtcars[1:20,] # rows

mydiag <- function( x ) {
  s = dim(x)[1]
  diags = matrix( ncol=2, byrow=TRUE, rep( 1:s, each = 2 ))
  return( x[diags] )
}

mydiag( x )

#
# Subsetting Operators

# [[ only returns a single value
a <- list( a = 1, b = 2 )
a[[1]]
a[["a"]]

# vector [[ indexes recursively
b <- list( a = list( b = list( c = list( d=1 ) )) )
b[[c( "a", "b", "c", "d" )]]
b[["a"]][["b"]][["c"]][[""]]

# data frames are lists of columns
mtcars[[1]]
mtcars[["cyl"]]

# Simplyfying vs Preserving Subsetting
# simplyfying subsets returns simplest data structure that represents the output
# Preserving subsets keeps the structure of the output the same

df[,1]
df[,1,drop=F]

# atomic vector - removes names
x <- c( a=1, b=2 )
x[[1]]
x[1]

# list - num 1 vs list( num 1 )
y <- list( a=1, b=2 )
str( y[[1]] )
str( y[1] )

# factor - drops unused levels
z <- factor( c( "a", "b" ) )
str(z[1, drop = TRUE])
str(z[1])

# matrix - drops dims of length 1
a <- matrix( 1:4, nrow = 2)
a[1,]
a[1, , drop=FALSE]

# data frame - returns vector for one col instead of data frame
df <- data.frame( a=1:2, b=1:2 )
str(df)
str(df[[1]])
str(df[1])

str( df[, "a"] )
str( df[, "a", drop=FALSE])

# $ - equivalent to x[["y", exact=FALSE]]
mtcars$mp
mtcars$mpg 
# warnPartialMatchDollar to TRUE prevents this

# doesnt work translated to mtcars[["var"]] 
var <- "mpg"
mtcars$var
mtcars[[var]]

# missing and out of bounds indexes
x <- 1:4
str( x[5] )

# Missing and out of bounds (OOB)
x <- 1:4
str( x[5] )
str( x[NA_real_] )
str( x[NULL] )

# operator: [, [[
# index: OOB, NA_real_, NULL
# results: NA, x[0], Error, NULL

# Exercises
mod <- lm( mpg ~ wt, data = mtcars )
str(mod)

mod$df.residual 

str(summary(mod))

summary(mod)$r.squared

summary(mod)[["r.squared"]]


#
# Subsetting and assignment
x <- 1:5
x[ c(1,2) ] <- 2:3
x

# LHS length must match RHS length
x[-1] <- 4:1
x

# duplicate idx work
x[c(1,1)] <- 2:3

# can't mix NA's with integers
x[c(1,NA)] <- c(1,2)

# Can mix NA's with logicals
x[c(T,F,NA)] <- 1

# useful for conditionally modifying a vector
df <- data.frame( a=c(1,10,NA) )
df$a[ df$a<5 ] <- 0
df$a

# Subsetting nothing preserves object class
mtcars[] <- lapply( mtcars, as.integer )
str(mtcars)
mtcars   <- lapply( mtcars, as.integer )
str(mtcars)

# remove component from a list
x <- list( a=1, b=2 )
x[["b"]] <- NULL
str(x)

# add a NULL to a list
y <- list( a=1 )
y["b"] <- list( NULL )
str(y)

#
# Applications

# Lookup tables ( character subsetting )
x <- c( "m", "f", "u", "f", "f", "m", "m" )
lookup <- c( m="Male", f="Female", u=NA )
s <- lookup[x]
s
unname( s )

# Integer Subsetting
grades <- c( 1,2,2,3,1 )
info <- data.frame( 
  grade = 3:1,
  desc = c("Excellent", "Good", "Poor"),
  fail = c(F,F,T)
)

# match( data, lookup.table )
id <- match( grades, info$grade )
info[id,]

rownames(info) <- info$grade
info[as.character(grades),]

# also interation(), paste(), plyr::id(), merge(), plyr::join()

# Random Samples
df <- data.frame( 
  x = rep(1:3, each=2),
  y = 6:1,
  z = letters[1:6]
)

df[ sample( nrow(df) ),  ]

df[ sample( nrow(df),3 ),  ]

df[ sample( nrow(df),6,replace=T ),  ]

# Ordering
x <- c("b", "c", "a")
order(x)
x[order(x)]

# Random reorder
df2 <- df[sample(nrow(df)), 3:1]
df2[order(df2$x),]
df2[,order(names(df2))]

# also: sort(), plyr::arrange()

# Expanding aggregated counts
df <- data.frame( 
  x = c(2,4,1),
  y = c(9,11,6),
  n = c(3,5,1)
)
a <- rep( 1:nrow(df), df$n )
df[a,]

# Removing col from data frames
# set col to NULL
df <- data.frame(
  x=1:3,
  y=3:1,
  z=letters[1:3]
)
df$z <- NULL
str(df)

# or remove by subsetting
df <- data.frame(
  x=1:3,
  y=3:1,
  z=letters[1:3]
)
df[ c("x", "y") ]

# or remove by set difference
df[ setdiff(names(df),"z") ]

# Selecting rows based on a condition
mtcars[ mtcars$gear==5, ]

mtcars[ mtcars$gear==5 & mtcars$cyl==4, ]

# use De Morgan's Laws to simplify boolean expressions
# or by using non-standard evaluation
subset( mtcars, gear==5 )

subset( mtcars, gear==5 & cyl==4 )

# Boolean algebra (logical subsetting) vs sets (integer subsetting)
# few TRUE's many FALSE's, use set representation (faster)
# which() converts bools to ints
x <- sample(10) < 4
which(x)

unwhich <- function(x,n) {
  out <- rep_len( FALSE, n)
  out[x] <- TRUE
  out
}

# unwhich() converts ints to bools
unwhich( which(x), 10 )

(x1 <- 1:10 %% 2 == 0)
(x2 <- which(x1))
(y1 <- 1:10 %% 5 == 0)
(y2 <- which(y1))

# intersection
# boolean
x1 & y1
# ints
intersect( x2, y2 )

# union
x1 | y1
union( x2, y2 )

# set difference
x1 & !y1
setdiff( x2, y2 )

# Exclusive OR
xor( x1, y1 )
setdiff( union( x2, y2), intersect(x2,y2) )

# Exercises
df <- data.frame( 
                 x = 1:3,
                 y = 3:1,
                 z = letters[1:3]
                )

df[ sample( nrow(df) ),  sample( colnames(df) ) ]

df[ sample( nrow(df) ),  sample( ncol(df) ) ]

m <- 2
df[ sample( nrow(df), m ), ]

contiguousSample <- 1:m + sample( nrow(df)-m+1, 1 ) - 1
df[ contiguousSample, ]

df[ order( colnames(df) ) ]
