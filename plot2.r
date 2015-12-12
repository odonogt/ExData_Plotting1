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
# Plot 2

# Output graph to Screen First
plot(powerData$datetime, powerData$Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)")

# Now output graph to png file
png(file="plot2.png",width=480,height=480)
plot(powerData$datetime, powerData$Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)")
dev.off()