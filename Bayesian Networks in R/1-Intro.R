install.packages("bnlearn")

library(bnlearn)

data(lizards)

str(lizards) 

dim(lizards)

nrow(lizards)
ncol(lizards)

summary(lizards)

lizards[,"Species"]

levels( lizards[,"Species"] )

table( lizards[,c(3,2,1)] )

diam = numeric(length=nrow(lizards))
narrow = (lizards$Diameter == "narrow")
wide = (lizards$Diameter == "wide")
diam[narrow] = runif( n=252, min=2, max=4 )
diam[wide] = runif( n=157, min=4, max=6 )
new.data = data.frame(
                      Species = lizards[,"Species"],
                      Sim.Diameter = diam
                     )

summary( new.data )

boxplot( Sim.Diameter ~ Species
        , data = new.data 
        , ylab = "Diameter (inches)")
abline( h = 4, lty="dashed" )

# Exercises



