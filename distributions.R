# Multinomial Distribution {{{
rmultinom( 9, 2, rep(1,6) )

dmultinom( c(1,0,0,0,0,1), prob=rep(1,6) )

rbinom( 100, 1, 0.5)

rbinom( 1, 10, 0.5)
# }}}

# Beta distribution {{{

x <- rbeta( 10000, 0.1, 0.1)
hist(x) 


# }}}

# Dirichlet distribution {{{
library(MCMCpack)
library(ggplot2)

alpha <- .1
draws <- 15
dimen <- 10
x <- rdirichlet(draws, rep(alpha, dimen))
dat <- data.frame(item=factor(rep(1:10,15)), 
                  draw=factor(rep(1:15,each=10)), 
                  value=as.vector(t(x)))
ggplot(dat,aes(x=item,y=value,ymin=0,ymax=value)) + 
               geom_point(colour=I("blue"))       + 
               geom_linerange(colour=I("blue"))   + 
               facet_wrap(~draw,ncol=5)           + 
               scale_y_continuous(lim=c(0,1))     

d <- 3
n <- 10 
pre.x <- matrix(rexp(n*d),n)
x <- pre.x / rowSums(pre.x)
x 
# }}}
