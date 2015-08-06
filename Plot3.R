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

## PLOT LINES OF SUB METERING OVER TIME
## SAVE PLOT AS plot3.png

setwd("./ExData_Plotting1")
png(filename = "plot3.png")
with(power.2007, 
     plot(Time, Sub_metering_1, type="n",
          main = "", xlab = "",
          ylab = "Energy sub metering"))
with(power.2007, lines(Time, Sub_metering_1))
with(power.2007, lines(Time, Sub_metering_2, col="red"))
with(power.2007, lines(Time, Sub_metering_3, col="blue"))
legend("topright", lwd = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

setwd(olddir)
rm(olddir, newdir)
