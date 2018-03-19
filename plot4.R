#Using dplyr package for subsetting and readr for reading data.
library(dplyr)
library(readr)

# This line reads the data. The file must be in workspace.
power_data <- read_delim("household_power_consumption.txt",delim = ";",col_types = "ccnnnnnnn")
power_data <- mutate(power_data, Date_Time = as.POSIXct(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))

#Subsetting in date range.
power_data <- filter(power_data, between(Date_Time, as.POSIXct("2007-02-01 00:00:00"),as.POSIXct("2007-02-02 23:59:59")))

#Generating png file.
png("plot4.png")
par(mfrow = c(2,2))
with(power_data, plot(Date_Time,Global_active_power,type = "l", xlab = "", ylab = "Global Active Power"))

with(power_data, plot(Date_Time,Voltage, type = "l", xlab="datetime",ylab = "Voltage"))

with(power_data,{plot(Sub_metering_1~Date_Time,type = "l", xlab = "", ylab = "Energy sub metering")
  lines(Sub_metering_2~Date_Time, col = "red")
  lines(Sub_metering_3~Date_Time, col = "blue")
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lwd = 1, bty = "n")
})

with(power_data, plot(Date_Time,Global_reactive_power,type = "l", xlab = "datetime"))

dev.off()