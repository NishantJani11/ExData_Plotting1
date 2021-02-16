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

# Convert the Voltage column from character to numeric
df$Voltage <- as.numeric(df$Voltage)

# Convert the Global reactive power column from character to numeric
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)

# PLOT 4
# A culmination of 4 plots together Global active power v Time, Voltage v Time, Energy sub metering(1,2,3) v Time and Global reactive power v Time using the par() function.
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(df$Time, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(df$Time, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(df$Time, df$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(df$Time, df$Sub_metering_1, col = "black")
lines(df$Time, df$Sub_metering_2, col = "red")
lines(df$Time, df$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(df$Time, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")