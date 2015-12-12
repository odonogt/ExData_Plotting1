library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./power_consumption.zip")
unzip("power_consumption.zip")

# Load Entire Data Set
allPowerData <-  data.table(read.csv("household_power_consumption.txt", sep = ";", header=T))

# Use only two days worth
powerData <- allPowerData[allPowerData$Date=="1/2/2007" | allPowerData$Date=="2/2/2007", ]

# Combine date and time
powerData$datetime <-as.POSIXct(paste(powerData$Date, powerData$Time), format="%d/%m/%Y %H:%M:%S")

# read numeric data correctly
powerData$Global_active_power <- as.numeric(as.character(powerData$Global_active_power))
powerData$Global_reactive_power <- as.numeric(as.character(powerData$Global_reactive_power))
powerData$Sub_metering_1 <- as.numeric(as.character(powerData$Sub_metering_1))
powerData$Sub_metering_2 <- as.numeric(as.character(powerData$Sub_metering_2))
powerData$Sub_metering_3 <- as.numeric(as.character(powerData$Sub_metering_3))


################################################################################
# Output graphs to PNG file
png(file="plot4.png",width=480,height=480)
par(mfcol=c(2,2))

# Plot 1,1
plot(powerData$datetime, powerData$Global_active_power, type="l", xlab="", ylab = "Global Active Power")

# Plot 2,1 
with(powerData, plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(powerData, lines(datetime, Sub_metering_2, col="red"))
with(powerData, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty="solid", col = c("black", "red","blue"))

# Plot 1,2
with(powerData, plot(datetime, Voltage, type="l"))

# Plot 2,2
with(powerData, plot(datetime, Global_reactive_power, type="l"))

dev.off()