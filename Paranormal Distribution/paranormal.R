library(ggplot2)
library(gridExtra)

theme_clean <- theme(
  panel.background = element_rect(fill="white"),
  panel.grid.major = element_blank(), 
  panel.grid.minor = element_blank(),
  axis.text.y = element_text(colour=NA), 
  axis.text.x = element_blank(),
  axis.ticks = element_blank(), 
  axis.title.y = element_blank(),
  axis.title.x = element_blank(),
  axis.line = element_line(colour = "black", linetype = "solid", size = 1),
  axis.line.y = element_blank(),
  text = element_text(size=12, family="Droid Sans")
)

p1 <- ggplot(data.frame(x = c(-3, 3)), aes(x)) + stat_function(fun = dnorm) + labs(title = "Distribuzione Normale") + theme_clean
a <- c(-3, -1.5, -0.9, -0.3, 0.6, 1, 1.5, 2, 3)
b <- c(0.004431848, 0.03, 0.0044, 0.03, 0.01, 0.030, 0.0044, 0.015, 0.004431848)
data <- data.frame(a = a, b = b)
c <- c(-0.40, 0.04)
d <- c(0.27, 0.27)
data2 <- data.frame(c = c, d = d)
q <- ggplot(data, aes(x=a, y=b)) + geom_line()
p2 <- q + stat_function(fun = dnorm) + geom_point(data = data2, aes(x=c, y=d), pch=0x30, size=6) + labs(title = "Distribuzione Paranormale") + theme_clean
png(file="paranormald.png", width = 322, height = 555)
grid.arrange(p1, p2, heights=1:2, widths=1:2)
dev.off()
