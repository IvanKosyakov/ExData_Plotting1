## Download source file and unzip it.
library (downloader)
URL<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(URL, dest="power_consumption.zip", mode="wb")
unzip ("power_consumption.zip")

## Read data from source file removing strings with not defined values "?".
data <- read.table  ("household_power_consumption.txt", 
                     sep = ";", na.strings = "?", header = TRUE, 
                     stringsAsFactors = TRUE)

## Filter data and calculate datetime field.
data <- data [data$Date == "1/2/2007" | data$Date == "2/2/2007",]
data$DateTime <- strptime(paste(data$Date, " ", data$Time), "%d/%m/%Y %H:%M:%S")

## Draw plot 2.
png(filename = "plot2.png", width=480, height=480)
par (mfrow = c (1, 1)) # Define layout for 1 plot in one page.
plot (x = data$DateTime, y = data$Global_active_power, type = "l", 
      xlab = "",
      ylab = "Global Active Power (kilowatts)")

# Release device.
dev.off ()