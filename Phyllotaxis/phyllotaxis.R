# pi_phyllotaxis.R
# 2017-03-22 by Marcoscan http://www.marcoscan.com
# generates a phyllotactic pattern on a disk, with colors based on pi digits
# reference "The Algorithmic Beauty of Plants" - "Chapter 4"
# http://algorithmicbotany.org/papers/
# http://www.mathrecreation.com/2015/08/simple-fun-with-r.html
# http://www.mathrecreation.com/2008/09/phyllotaxis-spirals.html

library(ggplot2)
library("RColorBrewer")

theme_new <- function(base_size = 10){
  theme_void(base_size = base_size) +
    theme(aspect.ratio=1,
          panel.background = element_rect(fill = "black", colour = "black"),
          plot.background = element_rect(fill = "black", colour = "black"),
          plot.margin = unit(c(0, -30, 1, -30), "cm"),
          plot.title = element_text(family="AvantGarde", colour = "white", size = 30, margin = margin(40, 0, 0, 0)),
          plot.subtitle = element_text(family="AvantGarde", colour = "#969696", size = 20,# face = "italic",
                                       margin = margin(15, 0, 10, 0)),
          legend.background =  element_rect(fill = "black", colour = NA),
          legend.direction = 'horizontal',
          legend.position = 'bottom',
          legend.box.margin = unit(c(-0.8, 0, -0.4, 0), "cm"),
          legend.key.size = unit(2.2, 'lines'),
          legend.text = element_text(family="AvantGarde", colour = "white", size = 13))
}

pidigits <- scan("pi_3001.csv", sep=",")
golden_angle <- (3 - sqrt(5))*pi
digits_seq <- 1:length(pidigits)
digits_num <- length(digits_seq)
c <- 1
x <- rep(0,digits_num)
y <- rep(0,digits_num)
for (n in 1:digits_num) {
  r=c*sqrt(n)
  theta=golden_angle*(n)
  x[n] <- r*cos(theta)
  y[n] <- r*sin(theta)
}

df <- data.frame(x,y,pidigits,digits_seq)

index <- 0:9
color_codes <- c("0" ="#A6CEE3", "1" = "#1F78B4", "2" = "#B2DF8A", "3" = "#33A02C", "4" = "#FB9A99",
                 "5" = "#E31A1C", "6" = "#FDBF6F", "7" = "#FF7F00", "8" = "#CAB2D6", "9" = "#6A3D9A")

df$pidigits <- factor(df$pidigits)
  
plot.title = 'Phyllotaxis of the first 3001 digits of π'
plot.subtitle = ''
  
p <- ggplot(df, aes(x, y)) + theme_new() +
  geom_point(size = 2.2, shape = 20, aes(color = pidigits)) + coord_fixed(ratio=1) +
  scale_color_manual(values = color_codes, drop=FALSE,
                     labels = c("0    ", "1    ", "2    ", "3    ", "4    ",
                                "5    ","6    ", "7    ", "8    ", "9    "))  +
  scale_x_continuous(limits = c(-56, 56)) + scale_y_continuous(limits = c(-56, 56)) + 
  guides(colour = guide_legend(override.aes = list(size=4))) +
  labs(title = plot.title,subtitle = plot.subtitle)

ggsave(filename=paste("phyllotaxis_pi.png", sep=""), plot=p, dpi = 72, width = 9.4, height = 9.4)

