# http://cran.r-project.org/doc/contrib/de_Jonge+van_der_Loo-Introduction_to_data_cleaning_with_R.pdf

# 2.1 techincally correct data
#   * stored in data.frame
#   * each column is of an R-type
#      * numbers: 'numeric' , 'integer'
#      * text: 'character'
#      * categorical: 'factor' , 'ordered'


# 2.2 Reading text data into a R data.frame
# import: 
#   read.table  - most flexible importer
#   read.delim  - tab / period
#   read.delim2 - tab / comma
#   read.csv    - comma / period
#   read.csv2   - semicolon / comma
#   read.fwf    - fixed width
# args:
#   header
#   col.names
#   na.string
#   colClasses
#   stringAsFactors - TRUE: converts all character vectors into factor vectors
# inspect:
#   head
#   str
#   summary

person <- read.csv( "unnamed.txt" )

person <- read.csv(
                   file = "unnamed.txt"
                   , header = FALSE
                   , col.names = c("age", "height")
                   )

# '5.7*' makes whole column a 'factor' 
str( person )

# Error: scan() expected 'a real', got '5.7*'
person <- read.csv(
                   file = "unnamed.txt"
                   , header = FALSE
                   , col.names = c("age", "height")
                   , colClasses = c('numeric', 'numeric')
                   )

# keep column as character
person <- read.csv(
                   file = "unnamed.txt"
                   , header = FALSE
                   , col.names = c("age", "height")
                   , stringsAsFactors = FALSE
                   )
str( person )

# now character type '5.7*' replaced as extra NA
person$height <- as.numeric( person$height )

#
# 2.2.2 Reading data with readLines
txt <- readLines( "daltons.txt" )

# detect comment lines '%'
# grepl - [TRUE, FALSE] array
I <- grepl( "^%", txt )
# remove comment lines
dat <- txt[!I]

# split lines into separate fields
fieldList <- strsplit( dat, split="," )

# standardize rows
assignFields <- function(x) {
    out <- character(3)
    # get names
    i <- grepl( "[[:alpha:]]", x )
    out[1] <- x[i]
    # get birth date (if any)
    i <- which( as.numeric(x) < 1890 )
    out[2] <- ifelse( length(i) > 0, x[i], NA )
    # get death date (if any)
    i <- which( as.numeric(x) > 1890 )
    out[3] <- ifelse( length(i) > 0, x[i], NA )
    out
}

standardFields <- lapply( fieldList, assignFields )

as.numeric( fieldList[3] )

which( c(FALSE, TRUE, TRUE) )

# Parallel application of lapply 
library( parallel )
cluster <- makeCluster( 4 )
standardFields <- parLapply( cl=cluster, fieldList, assignFields )
stopCluster( cluster )

# 5. Transform to data.frame
# list -> matrix -> data.frame
M <- matrix( unlist( standardField )
            , nrow = length( standardFields ),
            , byrow = TRUE )

colnames( M ) <- c("name", "birth", "death")

daltons <- as.data.frame( M, stringsAsFactors=FALSE )

str( daltons )

# 6. Normalize and coerce to correct types
# characters -> numeric / factor types
daltons$birth <- as.numeric( daltons$birth )
daltons$death <- as.numeric( daltons$death )
str( daltons )

# or using transform()
daltons <- transform( daltons,
                     , birth = as.numeric(birth)
                     , death = as.numeric(death) )

