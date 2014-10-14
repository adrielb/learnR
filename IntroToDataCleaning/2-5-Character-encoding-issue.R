# 2.5 Character Encoding Issues


# check default encoding
Sys.getlocale("LC_CTYPE")

# 1. specify encoding
# 2. read data
# 3. close file handle
f <- file( "myUTF16file.txt", encoding="UTF-16" )
input  <-  readLines( f )
close(f)

