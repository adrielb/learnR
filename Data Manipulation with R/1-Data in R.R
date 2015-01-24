# 1-Data in R

# Two of the most important attributes describing an R obj:
# mode() - numeric / character / logical
# class() - 


mylist <- list( a=c(1,2,3), b=c("cat","dog","duck"), d=factor("a","b","a") )

sapply( mylist, mode )

sapply( mylist, class )

# elements of a vec assigned names
x <- c(one=1, two=2, three=3)
print(x)

x <- 1:3
print(x)
names(x) <- c('one','two','three')
print(x)

names(x)[1:2] <- c('uno', 'dos')
print(x)

# R will recycle vector of shorter length
1:10 + c(1,2)

# warns if not an even multiple
1:10 + c(1,2,3)

# matricies internally stored as stacked columns
rmat <- matrix( rnorm( 15 ), 5, 3,
							 dimnames=list(NULL, c('A', 'B', 'C')))
print(rmat)

dimnames(rmat) 

mylist <- list(
							 c(1,4,7),
							 "dog",
							 4,
							 "cat",
							 TRUE,
							 c(9,5,10)
							 )
mylist

sapply( mylist, mode)

mylist <- list(c(1,5,3),
							 c('one', 'three', 'five'),
							 'end'
							 )
names(mylist) <- c('first','second','third')
print(mylist)

# which functions will treat the class specially
methods(print)

ls.str(mylist)
str(mylist)

# 1.4 Structure of R Objects

mylist <- list( 
  a=c(1,2,3),
	b=c("cat", "dog", "duck"),
	d=factor("a","b","a")
)
summary(mylist)
str(mylist)

# 1.5 Conversion
nums = c(12,10,8,12,10,12,8,10,12,8)
tt <- table(nums)
print(tt)
names(tt)
sum(names(tt) * tt)
sum(as.numeric(names(tt)) * tt)

# 1.6 Missing Values
x <- c(1,2,4,NA,9,2,NA,1)
summary(x)

x[!is.na(x)]

na.omit(x)

complete.cases(x)



