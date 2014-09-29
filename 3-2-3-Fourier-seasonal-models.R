library( dlm )

model1 <- dlmModTrig(
                     s = 12,
                     dV = 5.1118,
                     dW = 0
                     ) + 
          dlmModPoly( 
                     order = 1,
                     dV = 0,
                     dW = 81307e-3)

smooth1 <- dlmSmooth( nottem, model1 )

plot(smooth1$s)

length(smooth1$s)

length( nottem)

tseries <- ts( smooth1$s[2 : 13, c(1,3,5,7,9,11)],
              names = paste("S", 1 : 6, sep = "_"))
plot(tseries,
     oma.multi = c(2,0,1,0),
     pch = 16,
     nc = 1,
     yax.flip = TRUE,
     type = 'o',
     xlab = "",
     main = "" )


model2 <- dlmModTrig(
                     s = 12,
                     q = 2,
                     dV = 5.1420,
                     dW = 0
                     ) + 
            dlmModPoly(
                    order = 1,
                    dV = 0,
                    dW = 81942e-3 
                    )

# MAPE
mean( abs( residuals( dlmFilter( nottem, model1 ),
                     type = "raw",
                     sd = FALSE ) ) / nottem )

mean( abs( residuals( dlmFilter( nottem, model2 ),
                     type = "raw",
                     sd = FALSE ) ) / nottem )

# higher order harmonics are fitting the noise,
# not generalizing well
