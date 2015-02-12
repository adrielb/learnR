install.packages('ggvis')

library(ggvis)
library(dplyr)

p <- ggvis(mtcars, x=~wt, y=~mpg)

layer_points(p)

# piping

mtcars %>% 
ggvis( x=~wt, y=~mpg ) %>% 
layer_points()

# dplyr
mtcars %>% 
ggvis( x=~wt, y=~disp ) %>% 
mutate( disp=disp/61.02 ) %>% # convert engine displacement to liters
layer_points()

# other visual properties
mtcars %>% ggvis( ~mpg, ~disp, stroke=~vs) %>% layer_points()

mtcars %>% ggvis( ~mpg, ~disp, fill=~vs) %>% layer_points()

mtcars %>% ggvis( ~mpg, ~disp, size=~vs) %>% layer_points()

mtcars %>% ggvis( ~mpg, ~disp, shape=~factor(cyl)) %>% layer_points()

# make points a fixed color or size
mtcars %>% ggvis( ~wt, ~mpg, fill:="red", stroke:="black") %>% layer_points()

mtcars %>% ggvis( ~wt, ~mpg, size:="300", opacity:=0.4) %>% layer_points()

mtcars %>% ggvis( ~wt, ~mpg, shape:="cross") %>% layer_points()

# interaction point size and opacity
mtcars %>% 
ggvis( ~wt, ~mpg,
			size:=input_slider( 10, 100),
			opacity:=input_slider( 0, 1 )
			) %>% 
layer_points()

mtcars %>% 
ggvis( ~wt ) %>% 
layer_histograms( 
	width=input_slider( 0, 2, step=0.10, label='width' ),
	center=input_slider( 0, 2, step=0.05, label='center' )
	)

keys_s <- left_right( 10, 1000, step=50)
mtcars %>% ggvis( ~wt, ~mpg, size:=keys_s, opacity:=0.5) %>% layer_points()

# Layers
df <- data.frame( x=1:10, y=runif(10) )
df %>% ggvis( ~x, ~y) %>% layer_paths()

t <- seq( 0, 2*pi, length=100)
df <- data.frame( x=sin(t), y=cos(t) )
df %>% ggvis( ~x, ~y ) %>% layer_paths( fill:="red" )

df <- data.frame( x=1:10, y=runif(10) )
df %>% ggvis( ~x, ~y) %>% layer_ribbons()

df %>% ggvis( ~x, ~y+0.1, y2=~y-0.1) %>% layer_ribbons()
