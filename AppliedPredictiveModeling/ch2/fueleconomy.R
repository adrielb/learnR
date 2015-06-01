library(ggplot2)
library(dplyr)

raw <- read.csv("./vehicles.csv")

names(raw) %>% sort()

head(raw,1)

df <- raw %>% 
  select( displ, UHighway, year ) %>% 
    filter( year == 2010 | year == 2011 ) %>% 
      mutate( GPM=1/UHighway )

ggplot( data=df, aes(x=displ, y=UHighway)) +
  facet_wrap( ~year ) +
  geom_jitter( size=5,alpha=0.3,position=position_jitter()) +
  xlim(0,10) +
  ylim(10,70) +
  xlab( "Engine Displacement" ) +
  ylab( "Fuel Efficiency (MPG)" ) +
  ggtitle( "Model Year" )

ggplot( data=df, aes(x=displ, y=GPM)) +
  facet_wrap( ~year ) +
  geom_jitter( size=5,alpha=0.3,position=position_jitter()) +
  xlab( "Engine Displacement" ) +
  ylab( "Fuel Efficiency (GPM)" ) +
  ggtitle( "Model Year" )

qplot( x=GPM, y=UHighway, data=df, color=GPM, geom="point")

df %>% filter( year == 2010 ) %>% nrow()

df %>% filter( year == 2011 ) %>% nrow()

# Fig 2.2: quality of fit with linear regression# {{{
ggplot( data=df, aes(x=displ, y=UHighway)) +
  geom_jitter( size=5,alpha=0.3,position=position_jitter()) +
  geom_smooth(method='lm') +
  xlim(0,10) +
  ylim(10,70) +
  xlab( "Engine Displacement" ) +
  ylab( "Fuel Efficiency (MPG)" ) +
  ggtitle( "Linear regression" )

equ <- lm( UHighway ~ displ, df, df['year']==2010 )

summary( equ )

df <- df %>% mutate( y_hat = predict(equ, df['displ'] ) )

names(df)

# Fig 2.2: Observed vs Predicted
ggplot( data=filter(df, year==2011), aes(x=UHighway, y=y_hat)) +
  geom_point( size=5, alpha=0.3) +
  geom_abline( intercept=0, slope=1, size=2, color='red') +
  xlim(10,70) +
  ylim(10,70) +
  xlab( "Observered" ) +
  ylab( "Predicted" )
# }}}

# Fig 2.3: quadratic regression model# {{{
ggplot( data=df, aes(x=displ, y=UHighway)) +
  geom_jitter( size=5,alpha=0.3,position=position_jitter()) +
  geom_smooth(method='lm', formula=y~x+I(x^2), se=FALSE, size=1) +
  xlim(0,10) +
  ylim(10,70) +
  xlab( "Engine Displacement" ) +
  ylab( "Fuel Efficiency (MPG)" ) +
  ggtitle( "Linear regression" )

equ <- lm( UHighway ~ displ + I(displ^2), df, df['year']==2010 )

summary( equ )

df <- df %>% mutate( y_hat = predict(equ, df['displ'] ) )

names(df)

# Fig 2.3: Observed vs Predicted
ggplot( data=filter(df, year==2011), aes(x=UHighway, y=y_hat)) +
  geom_point( size=5, alpha=0.3) +
  geom_abline( intercept=0, slope=1, size=2, color='red') +
  xlim(10,70) +
  ylim(10,70) +
  xlab( "Observered" ) +
  ylab( "Predicted" )
# }}}






