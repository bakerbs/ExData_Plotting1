olddir <- getwd()
newdir <- "~/Documents/Actuary/Tech Skills/R Statistical Language/Coursera/Exploratory Data Analysis/EDA Project 1"
setwd(newdir)

## READ DATA & SUBSET 2007 DATA (If Necessary)
if(exists("power.2007") == FALSE){
        power.allobs <- read.table("./Data/household_power_consumption.txt", 
                                   sep=";", 
                                   na.strings = "?", 
                                   header=TRUE)
        dates <- power.allobs$Date
        power.allobs$Date <- as.Date(dates, format = "%d/%m/%Y")
        times <- as.POSIXct(paste(power.allobs$Date, power.allobs$Time), 
                            format="%Y-%m-%d %H:%M:%S")
        power.allobs$Time <- times
        power.2007 <- rbind(power.allobs[which(power.allobs$Date == "2007-02-01"), 1:9],
                            power.allobs[which(power.allobs$Date == "2007-02-02"), 1:9])
        rm(power.allobs, dates, times)
}

## PLOT 4 CHARTS IN ONE PANE
## SAVE PLOT AS plot4.png

setwd("./ExData_Plotting1")
png(filename = "plot4.png")

par(mfcol = c(2, 2))

with(power.2007, 
     plot(Time, Global_active_power, type="n",
          main = "", xlab = "",
          ylab = "Global Active Power"))
with(power.2007, lines(Time, Global_active_power))

with(power.2007, {
        plot(Time, Sub_metering_1, type="n",
             main = "", xlab = "",
             ylab = "Energy sub metering")
lines(Time, Sub_metering_1)
lines(Time, Sub_metering_2, col="red")
lines(Time, Sub_metering_3, col="blue")
legend("topright", lwd=1, bty = "n",
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

with(power.2007, {
        plot(Time, Voltage, type="n",
          main = "", xlab = "datetime",
          ylab = "Voltage")
        lines(Time, Voltage)
})

with(power.2007, {
        plot(Time, Global_reactive_power, type="n",
             main = "", xlab = "datetime",
             ylab = "Global_reactive_power")
        lines(Time, Global_reactive_power)
})

dev.off()

setwd(olddir)
rm(olddir, newdir)
