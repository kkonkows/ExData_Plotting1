#setwd("/Users/krzysztof/Documents/Stanford/Exploratory-Data-Analysis/workspace/");
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
#    destfile="hh_power_consumption.zip", method="curl");
#unzip("hh_power_consumption.zip");


# Read in data from file - scoped only to a supset containing 2007-02-01 and 2007-02-02 and some more.
# Read in column names, store data frame with assigned column names:
colNames = read.csv("household_power_consumption.txt", sep=";", nrows=1, header=T);
data = read.csv("household_power_consumption.txt", sep=";", skip=65000, nrows=5000, header=F, na.strings='?');
names(data) = names(colNames);
data$Date = as.POSIXlt(strptime(data$Date, format="%d/%m/%Y"));

# Add datetime variable - necessary to form nice weekdays titles for x axis:
datetime = as.POSIXlt(strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"));
data = cbind(data, datetime);

# Constrain memory to only entries between 2007-02-01 and 2007-02-02:
data = data[data$Date == as.POSIXct("2007-02-01") | data$Date == as.POSIXct("2007-02-02"),];

# Make sure no NAs are present:
sum(is.na(data))

# Open PNG Device - to make a smooth plot with nice legend:
png(filename="plot3.png", width=480, height=480);
# Creata a plot with all formatting noticed in the instuctions:
with(data, plot(datetime, Sub_metering_1, ylab="Energy sub metering", xlab="", type="n"));
with(data, points(datetime, Sub_metering_1, type="l", col="black"));
with(data, points(datetime, Sub_metering_2, type="l", col="red"));
with(data, points(datetime, Sub_metering_3, type="l", col="blue"));
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off();