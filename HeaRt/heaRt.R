# based on http://mathworld.wolfram.com/HeartCurve.html

library(ggplot2)

theme_heart <- function (base_size = 12, base_family = "") {
    theme_bw(base_size = base_size, base_family = base_family) %+replace% 
        theme(
            axis.text = element_blank(),
            axis.title = element_blank(),
            axis.ticks = element_blank(),
            panel.border = element_blank(),
            panel.background = element_blank(),            
            panel.grid.major = element_line(colour = "lightgrey"),
            plot.background = element_rect(fill="white")
    )   
}

data<- data.frame(t=seq(0, 2*pi, by=10^-3) )
xfun <- function(t) 16*sin(t)^3
yfun <- function(t) 13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t)
data$y=yfun(data$t)
data$x=xfun(data$t)

p <- ggplot(data=data, aes(x = x, y = y))
p + geom_path(color = "red2") + theme_heart()
