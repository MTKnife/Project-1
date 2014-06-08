# Load the graphics package.
library("graphics")

# Initialize variables.
energyData <- data.frame()
targetData <- data.frame()

setwd("C:/text/Data Science/Exploratory Analysis/Project 1")

# Read the entire data set.  I've chosen to read the whole thing, because
# read.table is easier to use here than readLines.
energyData <- read.table("household_power_consumption.txt", header = TRUE,
  sep = ";", na.strings = "?")

# Convert the dates into R date objects, subset the records for the appropriate
# dates, and then convert the times into POSIXlt objects.  There are,
# incidentally, no missing values in the targe range, which means we don't have
# to worry about that problem.
energyData$RDate <- as.Date(energyData$Date, "%d/%m/%Y")
targetData <- energyData[energyData$RDate >= as.Date("2007-02-01") &
  energyData$RDate <= as.Date("2007-02-02"), ]
targetData$RTime <- strptime(paste(targetData$RDate, targetData$Time), format = "%Y-%m-%d %H:%M:%S")

# Draw Plot 4 and save it to file to "plot1.png".
png(file = "plot4.png")

par(mfrow = c(2, 2))

with(targetData, (plot(RTime, Global_active_power, type = "l", xlab = "",
  ylab = "Global Active Power (kilowatts)")))
  
with(targetData, (plot(RTime, Voltage, type = "l", xlab = "datetime")))

with(targetData, (plot(RTime, Sub_metering_1, type = "l", col = "black",
  xlab = "", ylab ="Energy sub metering")))
with(targetData, (lines(RTime, Sub_metering_2, col = "red")))
with(targetData, (lines(RTime, Sub_metering_3, col = "blue")))
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"),
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))	
  
with(targetData, (plot(RTime, Global_reactive_power, type = "l", xlab = "datetime")))

dev.off()