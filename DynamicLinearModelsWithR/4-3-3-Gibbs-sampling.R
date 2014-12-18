library( dlm )

a1 <- 2
b1 <- 0.0001
a2 <- 2
b2 <- 0.0001

# starting values
psi1 <- 1
psi2 <- 1
mod_level <- dlmModPoly( 1,
                        dV = 1 / psi1,
                        dW = 1 / psi2 )

mc <- 1500
psi1_save <- numeric( mc )
psi2_save <- numeric( mc )
n <- length( Nile )
sh1 <- a1 + n / 2
sh2 <- a2 + n / 2
set.seed(10)

for( it in 1 : mc )
{
  # FFBS: draw states
  filt <- dlmFilter( Nile, mod_level )
  level <- dlmBSample( filt )
  
}
