install.packages('deSolve')

library(deSolve)
library(dplyr)
library(ggplot2)
library(tidyr)

parameters <- c(
  a=-8/3,
  b=-10,
  c=28
)

state <- c(
  X=1,
  Y=1,
  Z=1
)

Lorenz <- function (t, state, parameters) {
  with( as.list( c(state, parameters) ), {
    dX <- a*X + Y*Z
    dY <- b * (Y-Z)
    dZ <- -X*Y + c*Y - Z
    list( c(dX, dY, dZ) )
  }) # end with()
}

Lorenz( 10, state, parameters )

times <- seq( 0, 100, by=0.01)

out <- ode( y=state, times=times, func=Lorenz, parms=parameters )
head( out )

plot(out)

df <- as_data_frame( as.data.frame( out ) )

qplot( time, X, data=df, geom='line')

rdf <- gather( df, state, value, c(X,Y,Z) )

qplot( time, value, data=rdf, color=state, geom='line' )

qplot( state, state, data=rdf, geom='path' )

qplot( X, Z, data=df, geom='path')
qplot( Y, Z, data=df, geom='path')

ggplot( df, aes( X,Z) ) +
geom_path()


diagnostics( out )

# Predator-prey model
parms <- c( c=10, d=0.1, e=0.1, f=0.1)
xstart <- c( P=0.5, C=1.0 )
times <- seq( 0, 200, 0.1)
PCmod <- function (t, x, parms) {
  with( as.list( c(parms, x) ), {
    dP <- c*P - d*C*P
    dC <- e*P*C - f*C
    list( c( dP, dC) )
  })
}

PCmod( 10, xstart, parms )

# fails because of absolute accuracy,
# states can reach very small absolute values
out <- ode( y=xstart, times=times, func=PCmod, parms=parms)

# setting maximum time step to something very small is inefficient
out <- ode( y=xstart, times=times, func=PCmod, parms=parms, hmax=0.02)

# set atol to a very small number
out <- ode( y=xstart, times=times, func=PCmod, parms=parms, atol=0)
plot(out)

out <- ode( y=xstart, times=times, func=PCmod, atol=0,
  parms=c( c=0.1, d=0.1, e=0.1, f=0.1) )
plot(out)

#
# Substrate depletion  model
model <- function(t, state, parameters) {
  with( as.list( c(state, parameters) ), {
    dX <-  k1*S - (k0p + k0*Ep) * X
    dR <- -k2*R + (k0p + k0*Ep) * X
    dEp <- k3*R*(Et-Ep)/(Km1+Et-Ep) - k4*Ep/(Km2+Ep)
    list( c(dX, dR, dEp) )
  }) # end with()
} # end ActInhib()

parms <- c(
  k0p=0.01,
  k0=0.4,
  k1=1,
  k2=1,
  k3=1,
  k4=0.3,
  Km1=0.05,
  Km2=0.05,
  Et=1,
  S=0.25
)
x.init = c(
  X=1e-4,
  R=0.1,
  Ep=0.1
)
model( t, x.init, parms)

times <- seq( 0, 100, 0.1)
rm(out)
plot.new()
out <- ode( y=x.init, times=times, func=model, parms=parms, atol=0)
plot(out)
tail(out)

dout <- apply( out, 1, function(o) model( 0, o, parms) )
dout <- unlist( dout, recursive=FALSE)
dout <- do.call( rbind, dout)
colnames(dout) <- c("dX","dR", "dEp") 
dout <- cbind(out, dout)
dout.df <- as.data.frame( dout )
tail(dout.df)
qplot( X, R, data=dout.df, ylim=c(0,1.5), geom='path')

qplot( Ep, R, data=dout.df, ylim=c(0,1.5), geom='path')

qplot( time, dEp, data=dout.df, ylim=c(-1,1), geom='line')

qplot( time, Ep, data=dout.df, ylim=c(0,1), geom='line')


ggplot( dout.df ) +
geom_line( aes( x=time, y=X ), color='green') +
geom_line( aes( x=time, y=R ), color='blue') +
geom_line( aes( x=time, y=Ep), color='red') +

# pivoted data frame, states and derivs
dout.derivs <- gather( dout.df, state, value, c(dX,dR,dEp) )
dout.states <- gather( dout.df, state, value, c(X,R,Ep) )
dev.set(2)
ggplot( dout.derivs, aes( x=time, y=value, color=state)) + geom_line(size=2)
dev.set(3)
ggplot( dout.states, aes( x=time, y=value, color=state)) + geom_line(size=2)

x11()
dev.new()
dev.set(dev.next())

