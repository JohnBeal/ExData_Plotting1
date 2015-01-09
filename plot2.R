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



## Plot time series line graph of Global active power to png graphics device
png("plot2.png")                                                                    ##Initialize png graphics device
with(powerconsumption_subset, plot(x = Time, y = Global_active_power,               ##Initialize plot and labels
                                   type = "n", xlab = "",           
                                   ylab ="Global Active Power (kilowatts)", ))
with(powerconsumption_subset, lines(x = Time, y = Global_active_power))             ##Plot line for Global Active Power
dev.off()                                                                           ##Close grahics device