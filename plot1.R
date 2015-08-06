olddir <- getwd()
newdir <- "~/Documents/Actuary/Tech Skills/R Statistical Language/Coursera/Exploratory Data Analysis/EDA Project 1"
setwd(newdir)

## READ DATA & SUBSET 2007 DATA
power.allobs <- read.table("./Data/household_power_consumption.txt", 
                           sep=";", 
                           na.strings = "?", 
                           header=TRUE)
dates <- power.allobs$Date
power.allobs$Date <- as.Date(dates, format = "%d/%m/%Y")
power.2007 <- rbind(power.allobs[which(power.allobs$Date == "2007-02-01"), 1:9],
                    power.allobs[which(power.allobs$Date == "2007-02-02"), 1:9])
rm(power.allobs, dates)

## PLOT HISTOGRAM OF GLOBAL ACTIVE POWER
## SAVE PLOT AS plot1.png

setwd("./ExData_Plotting1")
png(filename = "plot1.png")
with(power.2007, hist(Global_active_power, col="red",
                      main = "Global Active Power", 
                      xlab = "Global Active Power (kilowatts)"))
dev.off()

setwd(olddir)
rm(olddir, newdir)
