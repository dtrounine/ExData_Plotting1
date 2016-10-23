source("plot_common.R")

data <- getData()

png(file = "plot1.png")

par(mfrow = c(1, 1))

hist(data$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()
