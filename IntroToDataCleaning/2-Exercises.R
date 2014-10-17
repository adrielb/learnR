# 2 - Exercises

# 2.1 Type Conversions
# 2.1.a
str( warpbreaks )

# 2.1.b
warpbreaks$breaks <- as.integer( warpbreaks$breaks )

# 2.1.c
mean[1]

typeof( mean )

# 2.2
v <- factor( c("2", "3", "5", "7", "11") )
# 2.2.a
as.character( v )
# 2.2.b
as.numeric( v )
# 2.2.c
as.integer( v )


# 2.3
txt <- readLines( "example.txt" )

c <- grepl( "^//", txt )

txtcomments <- txt[c]
txtdata <- txt[!c]

library( lubridate )

txtdate <- dmy( txtcomments[1] )

txtfields <- strsplit( txtdata, ";" )

maxfields <- max( sapply( txtfields, length) )

mypad <- function(x) {
    if( length(x) < maxfields )
        c(x, NA)
    else
        x
}

txtfieldspad = lapply( txtfields,  mypad)

M <- matrix( unlist( txtfieldspad )
            , ncol = maxfields
            , byrow = TRUE )

library(stringr)

colnames(M) <- str_match( txtcomments[2:4], "// Field .*: (.*)" )[,2]

# 2.4 Coerce the data
# 2.4.a
df <- as.data.frame( M, stringsAsFactors=FALSE )
str(df)

# 2.4.b
gender <- df$Gender
codes <- c("male", "female")
dist <- adist( gender, codes )
idx <- apply( D, 1, which.min )
df$Gender <- as.factor( codes[idx] )
str(df)

# 2.4.c
df$"Age (in years)"  <- as.integer( df$"Age (in years)" )
str(df)

# 2.4.d
w <- gsub( ",", ".", df$"Weight (in kg)" )
w <- as.numeric( w )
df$"Weight (in kg)" <- w 
str(df)

