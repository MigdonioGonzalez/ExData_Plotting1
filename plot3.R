#Using dplyr package for subsetting and readr for reading data.
library(dplyr)
library(readr)

# This line reads the data. The file must be in workspace.
power_data <- read_delim("household_power_consumption.txt",delim = ";",col_types = "ccnnnnnnn")
power_data <- mutate(power_data, Date_Time = as.POSIXct(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))

#Subsetting in date range.
power_data <- filter(power_data, between(Date_Time, as.POSIXct("2007-02-01 00:00:00"),as.POSIXct("2007-02-02 23:59:59")))

#Generating png file.
png("plot3.png")
with(power_data,{plot(Sub_metering_1~Date_Time,type = "l", xlab = "", ylab = "Energy sub metering")
    lines(Sub_metering_2~Date_Time, col = "red")
    lines(Sub_metering_3~Date_Time, col = "blue")
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lwd = 1)
  })
dev.off()