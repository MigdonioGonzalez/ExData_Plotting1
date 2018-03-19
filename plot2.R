#Using dplyr package for subsetting and readr for reading data.
library(dplyr)
library(readr)

# This line reads the data. The file must be in workspace.
power_data <- read_delim("household_power_consumption.txt",delim = ";",col_types = "ccnnnnnnn")
power_data <- mutate(power_data, Date_Time = as.POSIXct(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))

#Subsetting in date range.
power_data <- filter(power_data, between(Date_Time, as.POSIXct("2007-02-01 00:00:00"),as.POSIXct("2007-02-02 23:59:59")))

#Generating the png file.
png("plot2.png")
with(power_data, plot(Date_Time,Global_active_power,type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()