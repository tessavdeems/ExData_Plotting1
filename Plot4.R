#-------------------------------------------------------#
#                   LOADING THE DATA                    #
#-------------------------------------------------------#

# Read data
data <- read.table("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep = ";")

# Convert data to local dataframe (with dplyr)
library(dplyr)
data <- tbl_df(data)

# Filter data on Date and mutate Date/Time to proper formats
data_subset <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")
data_subset$Date <- as.Date(data_subset$Date, format = "%d/%m/%Y")
data_subset <- mutate(data_subset, DateTime = as.POSIXct(strptime(paste(data_subset$Date,data_subset$Time),
                                                                  format = "%Y-%m-%d %H:%M:%S")))

# Convert characters to numbers, thereby, removing "?"
data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)
data_subset$Global_reactive_power <- as.numeric(data_subset$Global_reactive_power)
data_subset$Voltage <- as.numeric(data_subset$Voltage)
data_subset$Global_intensity <- as.numeric(data_subset$Global_intensity)
data_subset$Sub_metering_1 <- as.numeric(data_subset$Sub_metering_1)
data_subset$Sub_metering_2 <- as.numeric(data_subset$Sub_metering_2)
data_subset$Sub_metering_3 <- as.numeric(data_subset$Sub_metering_3)

#-------------------------------------------------------#
#                   MAKING PLOTS                        #
#-------------------------------------------------------#

# Plot 4
par(mfrow = c(2,2))
png(file = "plot4.png")

#1
with(data_subset,plot(DateTime, Global_active_power, ylab = "Global Active Power", xlab = "", type = "l"))

#2
with(data_subset,plot(DateTime, Voltage, xlab = "datetime", type = "l"))

#3
plot(data_subset$DateTime, data_subset$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
points(data_subset$DateTime, data_subset$Sub_metering_2, type = "l", col = "red")
points(data_subset$DateTime, data_subset$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lwd = 1, bty = "n")

#4
with(data_subset,plot(DateTime, Global_reactive_power, xlab = "datetime", type = "l"))

dev.off()