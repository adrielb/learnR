# Ch 3: From techincally correct data to consistent data
# 
# consistent data - techincally correct data fit for statistical analysis
#   * in-record
#   * cross-record
#   * cross-dataset
# 
# Process:
#  1) Detection of inconsistency
#  2) Selection of field in multivariate relations
#  3) Correction of the fields

# 3.1 Detection and localization of errors
# 3.1.1  Missing Values (NA)
# 
# The analyst must decide what to do with missing data
# 
# na.rm - leave out records with missing data
age <- c( 23, 15, NA )
mean( age )
# NA
mean( age, na.rm=TRUE )
# 19

# complete.cases() - detects rows that do not contain any missing values
person <- read.csv(
                   file = "unnamed.txt"
                   , header = FALSE
                   , col.names = c("age", "height")
                   )
print(person)
complete.cases( person )

# alternatively, use na.omit
(persons_complete <- na.omit( person ))

na.action( persons_complete )

#
# 3.1.2 Special Values
# handle Inf, NA, NaN prior to statistical analysis

# is.finite() - values that are not in the set of real numbers
is.finite( c( 1, Inf, NaN, NA ) )

# check every column in a data.frame
is.special <- function(x) {
    if( is.numeric(x) )
        !is.finite( x ) 
    else
        is.na(x)
}

person

sapply( person, is.special )

sapply( person, is.finite )

#
# 3.1.3 Outliers
# outliers should be detected but not necessarily removed

# outlier detection with box-and-whiskers plot
x <- c( 1:10, 20, 30)
boxplot(x)
boxplot.stats(x)$out

boxplot.stats(x, coef=2)$out

# box plots fails when data is distributed skewly

# Hiridoglou and Berthelot: outliers on exponential dist

# rule constraints - negative age, pregnant man, ...
install.packages("editrules")
library(editrules)

people <- read.csv( "people.txt" )
print(people)

E <- editset( c( "age >= 0", "age <= 150" ) )
print(E)

violatedEdits( E, people )

E <- editfile("./edits.txt") 
print(E)

ve <- violatedEdits( E, people )
print(ve)
summary( ve )
plot(ve)

# Minimize number of fields altered in edit violations
id <- c(2, 5)
people[id,]

violatedEdits( E, people[id,])

# le$adapt - minimal set of variables to adapt
le <- localizeErrors( E, people[id, ], method="mip" )
print(le)

people[2,"status"] <- "single"
people[5,"height"] <- 7
people[5,"agegroup"] <- "adult"
summary( violatedEdits(E, people[id,] ))






