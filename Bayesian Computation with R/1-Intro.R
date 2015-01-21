install.packages( "LearnBayes" )

library(LearnBayes)

data(studentdata)

str(studentdata)

studentdata[1,]

attach( studentdata )

table( Drink )

barplot( table(Drink), xlab="Drink", ylab="Count" )

plot( ToSleep )

hours.of.sleep = WakeUp - ToSleep

plot( hours.of.sleep )

summary( hours.of.sleep )

hist( hours.of.sleep )

boxplot( hours.of.sleep ~ Gender, ylab="Hours of sleep" )

Gender=="female"

female.Haircut = Haircut[ Gender=="female" ]
male.Haircut = Haircut[ Gender=="male" ]

summary( female.Haircut )
summary( male.Haircut )

plot( ToSleep, hours.of.sleep )

plot( jitter(ToSleep), jitter(hours.of.sleep), pch=20 )

plot( jitter(ToSleep,amount=0), jitter(hours.of.sleep,amount=0), pch=20 )

fit=lm( hours.of.sleep ~ ToSleep )
str(fit)

abline( fit, lwd=8, col=2 )
