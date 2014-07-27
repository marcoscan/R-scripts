# Sample Code based on example program at:
# http://blog.revolutionanalytics.com/2009/11/charting-time-series-as-calendar-heat-maps-in-r.html

source(file = "calendarHeat-2013.R")
pdf("running-report-heatmap.pdf")
run<- read.csv("log-running.csv", header = TRUE, sep=",")
sum(run$Distance)

date <- c()
miles <- c()

for (i in 1: dim(run)[1]){
    if(run$DistanceUnit[i]== 'Kilometer'){
      miles <- c(miles,run$Distance[i] * 0.62)
    }
    else{
      miles <- c(miles,run$Distance[i])
    } 
}

calendarHeat(run$Date, miles, varname="report")
dev.off()
