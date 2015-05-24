install.packages('RSQLite')

library(DBI)

con <- dbConnect( RSQLite::SQLite(), ":memory:")

dbListTables(con)

dbWriteTable(con, "mtcars", mtcars)

dbListFields( con, "mtcars")

dbReadTable( con, "mtcars")

res <- dbSendQuery( con, "SELECT * FROM mtcars WHERE cyl = 4")
dbFetch( res)
dbClearResult(res)

res <- dbSendQuery( con, "SELECT * FROM mtcars WHERE cyl = 4")
while( !dbHasCompleted(res) ) {
  chunk <- dbFetch( res, n=5)
  print( nrow(chunk))
}
dbClearResult(res)


dbDisconnect(con)
