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
powerData$Sub_metering_1 <- as.numeric(as.character(powerData$Sub_metering_1))
powerData$Sub_metering_2 <- as.numeric(as.character(powerData$Sub_metering_2))
powerData$Sub_metering_3 <- as.numeric(as.character(powerData$Sub_metering_3))

################################################################################
# Plot 3

# Output graph to Screen First
with(powerData,  plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(powerData, lines(datetime, Sub_metering_2, col="red"))
with(powerData, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty="solid", col = c("black", "red","blue"))

# Now output graph to png file
png(file="plot3.png",width=480,height=480)
with(powerData,  plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(powerData, lines(datetime, Sub_metering_2, col="red"))
with(powerData, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty="solid", col = c("black", "red","blue"))
dev.off()