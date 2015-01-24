# http://blog.rstudio.org/2014/07/22/introducing-tidyr/
# Tidy Data
# 1. Each column is a variable
# 2. Each row is a observation

install.packages("tidyr")

# gather() - gathers cols into key-value pairs
# separate() - split variables clumped in one column
# spread() - make long data widers


library(tidyr)
library(dplyr) 

messy <- data.frame( 
	name=c("Wilbur", "petnuia", "Gregory"),
	a=c(67, 80, 64),
	b=c(56, 90, 50)
) 
print(messy)

messy %>% gather( drug, heartrate, a:b)

stocks <- data.frame( 
	time = as.Date('2015-01-01') + 0:9,
	X = rnorm(10, 0, 1),
	Y = rnorm(10, 0, 2),
	Z = rnorm(10, 0, 4)
)
print(stocks)
#gather(  data,   key, value)
gather( stocks, stock, price, X:Z)

#
# separate() - split variables clumped in one column
set.seed(10)
messy <- data.frame( 
  id=1:4,
	trt=sample( rep( c('control','treatment'), each=2)),
	work.T1 = runif(4),
	home.T1 = runif(4),
	work.T2 = runif(4),
	home.T2 = runif(4)
)
print(messy)

tidier <- messy %>% gather( key, time, -id, -trt)
print(tidier)

tidy <- tidier %>% 
separate( key, into=c("location","time"), sep="\\.")
print(tidy)


