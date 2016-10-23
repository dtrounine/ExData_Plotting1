source("plot_common.R")

data <- getData()

png(file = "plot3.png")

par(mfrow = c(1, 1))

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
       lwd = 1)

dev.off()
