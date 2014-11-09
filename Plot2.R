#Download the data
if (!file.exists("./data")){
        dir.create("./data")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./data/household_power_consumption.zip", 
              method = "curl")
#Unzip the file
unzip("./data/household_power_consumption.zip", exdir = "./data")

#Load the data into R
household_power_consumption <- read.table("./data/household_power_consumption.txt", 
                                          header = TRUE, 
                                          sep = ";", 
                                          colClasses = c("character", "character", 
                                                         rep("numeric", 7)),
                                          na = "?")
dim(household_power_consumption)
head(household_power_consumption)

#Subset the data
power_consumption <- subset(household_power_consumption, 
                            Date == "1/2/2007" | Date == "2/2/2007")

#Adding columns to data frame
power_consumption$dates <- as.Date(power_consumption$Date, "%d/%m/%Y")         
power_consumption$DateTime <- strptime(paste(power_consumption$Date, 
                                             power_consumption$Time), 
                                       "%d/%m/%Y %H:%M:%S")
dim(power_consumption)
head(power_consumption)

#create the plot
png("./data/plot2.png", width = 480, height = 480)
with(power_consumption, plot(DateTime, Global_active_power, 
                             type = "l", xlab = "", 
                             ylab = "Global Active Power (kilowats)"))
dev.off()