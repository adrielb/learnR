install.packages('quantmod')

library(quantmod)

getSymbols( "YHOO" )

barChart(YHOO)

Cl(YHOO)

plot(Ad(YHOO))

seriesHi(YHOO)

plot( OpCl(YHOO) )

plot( HiCl(YHOO))

tail(Lag(Cl(YHOO)))
tail(Cl(YHOO))

head(Delt( Ad(YHOO), Ad(YHOO), k=1:3))

head(YHOO['2010'])
head(YHOO['2010','YHOO.Open'])

last(YHOO)

last(YHOO,9)

last(YHOO, '3 weeks')

periodicity(YHOO)

unclass(periodicity( YHOO))

plot(to.weekly( YHOO ))

plot(to.monthly( YHOO ))

ndays(YHOO)
nweeks(YHOO)
nyears(YHOO)

endpoints(YHOO)

barChart(apply.monthly( YHOO, FUN=function(x) {max(Cl(x))} ))

period.apply( YHOO, endpoints( YHOO, on='weeks'), FUN=function(x) {max(Cl(x))} )

as.numeric( period.max( Cl( YHOO), endpoints( YHOO, on='weeks')))

barChart( monthlyReturn(YHOO))

head(allReturns(YHOO))









