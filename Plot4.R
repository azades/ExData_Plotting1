## Coursera / Exploratory Data Analysis / Assignment 1


## Downloading, unzipping and reading the file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile ="exdata-data-household_power_consumption.zip",
              method = "curl")
household_power_consumption <- read.csv(unzip("exdata-data-household_power_consumption.zip",
                                              "household_power_consumption.txt"),
                                        sep=";", header=TRUE, na.string="?",
                                        colClasses=c("character","character",
                                                     "numeric", "numeric", "numeric", 
                                                     "numeric","numeric","numeric",
                                                     "numeric"))


## Changing the "Date" format from character to Date and subsetting the "2007-02-01" and "2007-02-02" data.
household_power_consumption$Date <- as.Date(household_power_consumption$Date, 
                                            "%d/%m/%Y")
power_consumption <- subset(household_power_consumption, 
                            Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
power_consumption$Date <- strptime(paste(power_consumption$Date,
                                         power_consumption$Time), "%Y-%m-%d %H:%M:%S")


## Creating the plot
png(filename="plot4.png", width=480, height=480)
par(mfcol=c(2,2))

# First plot (1,1)
plot(power_consumption$Date, power_consumption$Global_active_power, type="l",
     xlab="", ylab="Global Active Power")

# Second plot (2,1)
plot(power_consumption$Date, power_consumption$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(power_consumption$Date, power_consumption$Sub_metering_2, col="red")
lines(power_consumption$Date, power_consumption$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", 
                            "Sub_metering_3"),col=c("black", "red", "blue"), 
       lwd=par("lwd"), bty="n")

# Third Plot (1,2)
plot(power_consumption$Date, power_consumption$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# Fourth plot (2,2)
plot(power_consumption$Date, power_consumption$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()