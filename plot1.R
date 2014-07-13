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

# Constrain memory to only entries between 2007-02-01 and 2007-02-02:
data = data[data$Date == as.POSIXct("2007-02-01") | data$Date == as.POSIXct("2007-02-02"),];

# Make sure no NAs are present:
sum(is.na(df))

# Creata a histogram with all formatting noticed in the instuctions:
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main = "Global Active Power");

# Copy histogram to a PNG device with 480x480 dimensions and close the file:
dev.copy(png, file="plot1.png", width=480, height=480);
dev.off();