# 2.3 Type Conversion
# Coercion - converting from one type to another
#   as.numeric 
#   as.integer
#   as.character 
#   as.logical 
#   as.factor
#   as.ordered

# values that cannot be converted are 'NA'
as.numeric( c( "7", "7*", "7.0", "7,0" ) )

# class() returns "character" / "integer" / "numeric" / "factor"
class( c("abc", "def") )
class( 1:10 )
class( c( pi, exp(1) ) )
class( factor( c("abc", "def") ) )

# quickly retrieve all the classes in a column of data.frame
sapply( dat, class )

# Under the hood, R objects are C structures
typeof( c("abc", "def") )
typeof( 1:10 )
typeof( c( pi, exp(1) ) )
typeof( factor( c("abc", "def") ) )

# class: user point of view
# type: R's point of view

#
# 2.3.2 Recoding factors
# 'factor' variables are integer vectors
# level(): translation table of values
f <- factor( c("a", "b", "a", "a", "c") )
levels(f)

# converting an integer table to a factor table
gender <- c(2,1,1,2,0,1,1)
recode <- c(male=1, female=2)
gender <- factor( gender, levels=recode, labels=names(recode) )
str(recode)

# levels have no natural ordering
# however it can be useful to fix one of the levels as the reference level
gender <- relevel( gender, ref="female" )

# levels can be reordered depending on the mean
age <- c( 27, 52, 65, 34, 89, 45, 68 )
gender <- reorder( gender, age)

# removing mean by setting attribute to null
attr( gender, "scores" )  <-  NULL
gender

#
# 2.3.3 Converting to dates
# time instances: 
#   Date
#   POSIXlt
#   POSIXct - most portable, time since Jan 1, 1970 00:00
current_time <- Sys.time()
class( current_time )
current_time

# text -> date
library( lubridate )
dates <- c("15/02/2013", "15 Feb 13", "It happened on 15 02 '13")
dmy( dates )

# two digit year numbers:
dmy( "01 01 68" )
dmy( "01 01 69" )

# this fails to parse
dmy( "15 Febr. 2013" )

# custom textual format
dates <- c("15-9-2009", "16-07-2008", "17 12-2007", "29-02-2011")
as.POSIXct( dates, format = "%d-%m-%Y" )

# list all date formats: %d, %m, %Y, ...
?strptime

# convert POSIXct back to character
mybirth <- dmy( "28 Sep 1976" )
format( mybirth, format="I was born on %B %d, %Y" )







