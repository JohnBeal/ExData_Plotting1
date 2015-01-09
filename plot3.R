## Load requred libraries
library(lubridate); library(dplyr)

##Read data from the Household Power Consumption dataset and subset to date range 01/02/2007-02/02/2007
class_list<-c(rep("character", times = 2), rep("numeric", times = 7 ))
powerconsumption<-read.table("household_power_consumption.txt", header = TRUE, sep =";", 
                             na.strings = "?", colClasses = class_list)
powerconsumption_subset<-filter(powerconsumption, dmy(Date)>=ymd(20070201), dmy(Date)<=ymd(20070202))

##Create amalgamated date and time column and transform Date to Date format and Time to POSIXlt format  
powerconsumption_subset<-transform(powerconsumption_subset, 
                                   Date = dmy(Date),
                                   Time = strptime(paste(as.character(Date), as.character(Time)), format = "%d/%m/%Y %H:%M:%S"))



## Plot time series line graph of energy submetering to png graphics device
png("plot3.png")                                                                        ##Initialize png graphic device
with(powerconsumption_subset, plot(x = Time, y = Sub_metering_1, type = "n", xlab = "", 
                                   ylab ="Energy sub metering", ))                      ##Initialize graph and labels

with(powerconsumption_subset, lines(x = Time, y = Sub_metering_1, col ="black"))        ##Sequentially plot line graphs
with(powerconsumption_subset, lines(x = Time, y = Sub_metering_2, col ="red"))          ## for Sub_metering_1 - 3 
with(powerconsumption_subset, lines(x = Time, y = Sub_metering_3, col ="blue"))
legend("topright", lty = c(1,1,1), col=c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))                ##Add legend to graph
dev.off()                                                                               ##Close grahics device