## Coursera / Exploratory Data Analysis / Assignment 1 / Plot 2


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
png(filename="plot2.png", width=480, height=480)
plot(power_consumption$Date,power_consumption$Global_active_power,
     type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()  
