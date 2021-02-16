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

# Convert the sub metering columns (1, 2, 3) from character to numeric
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

# PLOT 3
# This a line plot with all the sub metering columns (1, 2, 3) color coded with x axis being the "Time" column.
plot(df$Time, df$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(df$Time, df$Sub_metering_1, col = "black")
lines(df$Time, df$Sub_metering_2, col = "red")
lines(df$Time, df$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))