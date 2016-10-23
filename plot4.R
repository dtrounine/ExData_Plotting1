source("plot_common.R")

data <- getData()

png(file = "plot4.png")

par(mfrow = c(2, 2))

# Top-left plot 
plot(data$DateTime, data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Top-right plot
plot(data$DateTime, data$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Bottom-left plot
plot(data$DateTime, data$Sub_metering_1, 
     type = "n",
     ylab = "Energy sub metering",
     xlab = "")

points(data$DateTime, data$Sub_metering_1, 
       type = "l",
       col = "black")
points(data$DateTime, data$Sub_metering_2, 
       type = "l",
       col = "red")
points(data$DateTime, data$Sub_metering_3, 
       type = "l",
       col = "blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), 
       lwd = 1,
       bty = "n")

#Bottom-right plot
plot(data$DateTime, data$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()

