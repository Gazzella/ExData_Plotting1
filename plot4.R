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

ub.df2<- mutate(ub.df2, Voltage = as.numeric(as.character(Voltage)))
ub.df2<- mutate(ub.df2, Global_reactive_power = as.numeric(as.character(Global_reactive_power)))
ub.df2<- mutate(ub.df2, Sub_metering_1 = as.numeric(as.character(Sub_metering_1)))
ub.df2<- mutate(ub.df2, Sub_metering_2 = as.numeric(as.character(Sub_metering_2)))
ub.df2<- mutate(ub.df2, Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))


png(file =
            "plot4.png", width = 480, height = 480
) 
par(mfrow = c(2,2))
with(ub.df2, {
        plot(DateTime, Global_active_power, ylab ="Global Active Power", type="l", xlab ="" 
        )
        plot(DateTime, Voltage, ylab ="Voltage", xlab ="datetime", type="l"
        )
        plot(DateTime, Sub_metering_1,  ylab = "Energy sub metering", type="l", xlab ="" )
        lines(ub.df2$DateTime, ub.df2$Sub_metering_2, col="red")
        lines(ub.df2$DateTime, ub.df2$Sub_metering_3, col="blue")
        legend("topright", lty=1, col = c("black", "red", "blue"), cex=0.7, bty="o", lwd=2,
        legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
        plot(DateTime, Global_reactive_power, type="l", xlab ="datetime"
        )       
})

dev.off()

