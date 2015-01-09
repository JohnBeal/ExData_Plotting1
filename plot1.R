## Load requred libraries
library(lubridate); library(dplyr)

##Read data from the Household Power Consumption dataset and subset to date range 01/02/2007-02/02/2007
class_list<-c(rep("character", times = 2), rep("numeric", times = 7 ))
powerconsumption<-read.table("household_power_consumption.txt", header = TRUE, sep =";", 
                             na.strings = "?", colClasses = class_list)
powerconsumption_subset<-filter(powerconsumption, dmy(Date)>=ymd(20070201), dmy(Date)<=ymd(20070202))
powerconsumption_subset<-transform(powerconsumption_subset, Date = dmy(Date), Time = hms(Time))

## Plot histogram of Global active power to png graphics device
png("plot1.png")
with(powerconsumption_subset, hist(Global_active_power, main = "Global Active Power", 
                                    xlab = "Global Active Power (kilowatts)", col = "red"))
dev.off()