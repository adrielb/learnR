# 2.4 character manipulation
#    gender
## 1 M
## 2 male
## 3 Female
## 4 fem.
# 
# coding - converting messy character strings into fixed categories

# 2.4.1 String normalization
# transform a variety of strings into a smaller subset more easily processed
library( stringr )

# removing whitespace
str_trim( "  hello world  " )
str_trim( "  hello world  ", side = "left" )
str_trim( "  hello world  ", side = "right" )

# padding
str_pad( 112, width=6, side="left", pad=0 )

toupper( "hello world" )
tolower( "Hello World" )

# 2.4.2 Approx string matching
#   1) pattern matching
#   2) edit distance

# simple substring pattern matching
gender <- c("M", "male ", "Female", "fem.")
grepl( "m", gender )
grep( "m", gender )

# ignoring case
grepl( "m", gender, ignore.case = TRUE )
grepl( "m", tolower(gender))

# search begining of string
grepl( "^m", gender, ignore.case = TRUE )

# searching for meta-characters
grepl( "^", gender, fixed=TRUE )

?regex

# 
# edit distance - how many basic operations needed to turn one string into
#                 another

# abc -> bbc -> bac = 2
adist( "abc", "bac" )

# compare fuzzy text strings to known codes
codes <- c( "male", "female" )
D <- adist( gender, codes )
colnames(D) <- codes
rownames(D) <- gender
D

# find which code matches the smallest edit distance
# 1: apply to every row
# 2: apply to every col
i <- apply( D, 1, which.min )
data.frame( rawtext=gender, coded=codes[i] )

# agrep  -  uses Levenshtein distance btw pattern and match

# stringdist - allows for character transpositions (common in typos)
library( stringdist )

# abc -> bac
stringdist( "abc", "bac" )


