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

## Draw plot 4.
png(filename = "plot4.png", width=480, height=480)
par (mfrow = c (2, 2)) # Define layout for 4 plots in one page.
with (data, {
  ## Plot 4.1
  plot (x = DateTime, y = Global_active_power, type = "l", 
        xlab = "",
        ylab = "Global Active Power")
  
  ## Plot 4.2
  plot (x = DateTime, y = Voltage, type = "l", 
        xlab = "datetime")
  
  ## Plot 4.3
  plot (x = DateTime, y = Sub_metering_1, type = "l", 
        xlab = "",
        ylab = "Energy sub metering")
  lines (x = DateTime, y = Sub_metering_2, col = "red")
  lines (x = DateTime, y = Sub_metering_3, col = "blue")
  legend ("topright", col = c ("black", "red", "blue"), 
          legend = c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
          lty = c (1, 1, 1),          # Lines in the legend
          lwd = c (2.5, 2.5, 2.5),    # Lines with correct width
          bty = "n")                  # Hide border in the legend
  
  ## Plot 4.4
  plot (x = DateTime, y = Global_reactive_power, type = "l", 
        xlab = "datetime")
})

# Release device.
dev.off ()