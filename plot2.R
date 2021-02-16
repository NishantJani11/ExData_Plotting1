# I downloaded the file directly instead of using R to download the zip file.
# Read the text document into a data frame by read.table() function.
power_consumption <- read.table("./household_power_consumption.txt", sep = ";" ) 

# Subset the data frame to get the data frame down to 1/2/2007 and 2/2/2007 dates only.
df <- subset(power_consumption, power_consumption$Date == "1/2/2007" | power_consumption$Date == "2/2/2007")

# See the summary of the data frame df
str(df)

# Convert the Date column to 'date' class
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# Convert the Time column to 'datetime' class
df$Time <- strptime(df$Time, "%H:%M:%S")
df[1:1440, "Time"] <- format(df[1:1440, "Time"], "2007-02-01 %H:%M:%S")
df[1441:2880, "Time"] <- format(df[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

# Convert the Global active power column from character to numeric
df$Global_active_power <- as.numeric(df$Global_active_power)

# PLOT 2
# It is a line plot with x-axis as "Time" column and y axis being "Global_active_power" column with the label Global Active Power (kilowatts).
plot(df$Time, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
