library("dplyr")
library("lubridate")
Sys.setlocale('LC_TIME', 'C')



setwd("~/datasciencecoursera/exploratory data")
data <- read.table("household_power_consumption.txt", header=T, sep=";")

##Use of package lubridate to convert dates
data$Date <- dmy(data$Date) 
class(data$Date)
ub.df = subset(data, as.Date(Date) >= '2007-02-01' & 
                       as.Date(Date) <= '2007-02-02'
)
ub.df$Date <-(paste(ub.df$Date, ub.df$Time))

##Use of package lubridate to convert dates and time
ub.df2<- mutate(ub.df, DateTime = ymd_hms(Date))
png(file =
            "plot2.png", width = 480, height = 480 
) 
with(ub.df2, plot(DateTime, Global_active_power, type="l", ylab = "Global Active Power (kilowatts)"))

dev.off()
