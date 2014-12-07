#Plot1
Sys.setlocale('LC_TIME', 'C')

library("dplyr")
library("lubridate")


setwd("~/datasciencecoursera/exploratory data")
data <- read.table("household_power_consumption.txt", header=T, sep=";")

##Use of package lubridate to convert dates
data$Date <- dmy(data$Date) 
class(data$Date)
ub.df = subset(data, as.Date(Date) >= '2007-02-01' & 
                       as.Date(Date) <= '2007-02-02'
                      )
ub.df$Date <-(paste(ub.df$Date, ub.df$Time))

class(ub.df$Global_active_power)
###Use dplyr packages to convert factor into numeric
ub.df1<- mutate(ub.df, Global_active_power = as.numeric(as.character(Global_active_power)))
png(file =
            "plot1.png", width = 480, height = 480
) 

with(ub.df1, hist(Global_active_power, col = "red", 
                  xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main="Global Active Power"))

dev.off()
