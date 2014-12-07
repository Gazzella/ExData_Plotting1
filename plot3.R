#Plot3

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
ub.df2<- mutate(ub.df2, Sub_metering_1 = as.numeric(as.character(Sub_metering_1)))
ub.df2<- mutate(ub.df2, Sub_metering_2 = as.numeric(as.character(Sub_metering_2)))
ub.df2<- mutate(ub.df2, Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))

png(file =
            "plot3.png", width = 480, height = 480
) 
with(ub.df2, plot(DateTime, Sub_metering_1,  ylab = "Energy sub metering", type="l"))
lines(ub.df2$DateTime, ub.df2$Sub_metering_2, col="red")
lines(ub.df2$DateTime, ub.df2$Sub_metering_3, col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"), cex=0.7, bty="o", lwd=2,
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))


dev.off()
