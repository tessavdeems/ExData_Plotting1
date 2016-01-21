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

# Plot 1
par(mfrow = c(1,1))
png(file = "plot1.png")

hist(data_subset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()
