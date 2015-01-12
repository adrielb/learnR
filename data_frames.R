library(dplyr)

# http://cran.r-project.org/web/packages/dplyr/vignettes/data_frames.html
df1 <- data.frame( x=letters )
sapply( df1, class )

df2 <- data_frame( x=letters )
sapply( df2, class )

df2 %>% sapply( class )

str(df1)
str(df2)

data.frame( x=1:3, y=list(1:4, 1:10, 1:30) )
data_frame( x=1:3, y=list(1:4, 1:10, 1:30) )

data.frame( 'crazy name' = 1 ) %>% names()
data_frame( 'crazy name' = 1 ) %>% names()

data_frame( x=1:500, y=x^2 )

data_frame( x=1:5, y=x^2 ) %>% class()

# 
# benchmarking as_data_frame
l2 <- replicate( 26, sample(100), simplify=FALSE )
names(l2) <- letters
str(l2)

microbenchmark::microbenchmark(
  as.data.frame( l2 ),
  as_data_frame( l2 )
)

ls("package:dplyr")

library( help="dplyr" )

lsf.str( "package:dplyr" )

#
# Memory
location( iris )

iris2 <- iris
location( iris )

changes( iris2, iris )

iris2$Sepal.Length <- iris2$Sepal.Length*2
changes(iris, iris2)

iris3 <- mutate( iris, Sepal.Length=Sepal.Length*2 )
changes(iris, iris3)

summarize( iris3 )

#
# Window functions
library(Lahman)

str(Batting)

batting <- select( tbl_df(Batting), playerID, yearID, teamID, G, AB:H )
batting <- arrange( batting, playerID, yearID, teamID )
players <- group_by( batting, playerID )

x <- c(1,5,2,NA)
min_rank( x )

desc(10:1)

filter(players, min_rank(desc(H)) <= 2 & H > 0)
mutate( players, G_rank=min_rank(G) )

filter( players, G > lag(G) )

mutate( players, g_change=(G-lag(G))/(yearID-lag(yearID)) )

filter( players, G > mean(G) )

mutate( players, G_z = (G-mean(G)) / sd(G) )

# window functions
#   non-aggregating
#     ranking - min_rank / ...
#     offsets - lead / lag
#   aggregating
#     cumulatives
#     rolling
#     recycled

x <- c(1, 1, 2, 2, 2)
row_number(x)
min_rank(x)
dense_rank(x)
cume_dist(x)
percent_rank(x)

filter( players, min_rank( desc(G) ) < 2 )

filter(players, cume_dist(desc(G)) < 0.1 )

by_team_player <- group_by( batting, teamID, playerID )
by_team <- summarise( by_team_player, G=sum(G) )
by_team_quartile <- group_by( by_team, quartile=ntile(G,4) )

by_team_quartile %>% print( n=30 )

summarize(by_team_quartile, mean(G))

# lead / lag
x <- 1:8
lead(x)
lag(x)

mutate( players, G_delta=G-lag(G) )

filter(players, teamID != lag(teamID) & playerID == 'aaronha01')

filter(players,  playerID == 'aaronha01')

df <- data.frame( year = 2000:2005, value=(0:5)^2 )
scrambled <- df[sample(nrow(df)),]

wrong <- mutate( scrambled, running=cumsum(value) )
arrange( wrong, year )

right <- mutate( scrambled, running=order_by( year, cumsum(value) ) )
arrange( right, year )

#
# Introduction to dplyr
library(nycflights13)

dim(flights)
head(flights)
str(flights)

options(dplyr.print_min=50) 

filter( flights, month==1, day==1 )

flights[ flights$month==1 & flights$day == 1, ]

filter( flights, month==1 | month==2 ) %>% sample_n( 10 )

slice( flights, 1:10 )

arrange( flights, year, month, day )
arrange( flights, day, month, year )

arrange( flights, desc(arr_delay) )

flights[ order( desc(flights$arr_delay) ), ]

flights %>% select( year, month, day )
flights %>% select( year:day )

flights %>% select( -(year:day) )

select( flights, tail_num=tailnum )

rename( flights, tail_num=tailnum )

distinct( select( flights, tailnum ) )

flights %>% select( origin, dest ) %>% distinct()

flights %>% select( origin, dest ) %>% arrange( origin, dest ) %>% distinct()

mutate( flights, 
  gain = arr_delay - dep_delay,
  speed = distance / air_time * 60
)

mutate( flights, 
  gain = arr_delay - dep_delay,
  gain_per_hour = gain / (air_time/60)
)

transform( flights, 
          gain = arr_delay - dep_delay,
          gain_per_hour = gain / (air_time/60))


transmute( flights, 
  gain = arr_delay - dep_delay,
  gain_per_hour = gain / (air_time/60)
)

summarize( flights, delay=mean(dep_delay, na.rm=TRUE) )

hist( flights$dep_delay, xlim=c(-5,30) )

sample_n( flights, 10 )

sample_n( flights, 10, replace=TRUE )

sample_frac( flights, 0.01 )

carriers <- group_by(flights, carrier)
summarise(carriers, n())
mutate(carriers, n = n())
filter(carriers, n() < 100)


by_tailnum <- group_by( flights, tailnum )
delay <- summarize(
  by_tailnum,
  count=n(),
  dist=mean(distance, na.rm=TRUE),
  delay=mean(arr_delay, na.rm=TRUE)
)
delay <- filter( delay, count > 20, dist < 2000 )

library(ggplot2)

ggplot( delay, aes(dist,delay) ) +
  geom_point( aes( size=count ), alpha=1/2 ) +
  geom_smooth() +
  scale_size_area()

destinations <- group_by( flights, dest )
summarize( destinations,
  planes=n_distinct(tailnum),
  flights=n()
)

filter( flights, dest == 'ANC' ) %>% select( tailnum ) %>% arrange( tailnum ) %>% distinct()

daily <- group_by( flights, year, month, day )
per_day <- summarize( daily, flights=n() )
per_month <- summarize( per_day, flights=sum(flights) )
per_year <- summarize( per_month, flights=sum(flights) )

