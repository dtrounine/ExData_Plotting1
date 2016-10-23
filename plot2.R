source("plot_common.R")

data <- getData()

png(file = "plot2.png")

par(mfrow = c(1, 1))

plot(data$DateTime, data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()
