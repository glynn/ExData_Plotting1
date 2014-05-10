## Exploratory plot with four line graphs

# Note: Script should be run with the unzipped file 
#   household_power_consumption.txt
# in the current working directory.

# Subset larger file for exploration, to only the days 1-2-Feb-2007
system("grep ^[12]/2/2007 household_power_consumption.txt > powersubset.txt")

# Read and prep data
power <- read.table("powersubset.txt", sep=";", stringsAsFactors=FALSE)
system("rm powersubset.txt")
names(power) <- c("pdate", "ptime", "active.power", "reactive.power", "voltage",
                  "intensity", "sub1", "sub2", "sub3")
power$timestamp <- strptime(paste(power$pdate, power$ptime), 
                            format="%d/%m/%Y %H:%M:%S")
power <- power[,c("timestamp", "active.power", "reactive.power", 
                  "sub1", "sub2", "sub3", "voltage")]

# Produce 4 line graphs
png(file = "plot4.png")

par(mfrow=c(2,2))

plot(power$timestamp, power$active.power, type="l",
     xlab="", ylab="Global Active Power")

plot(power$timestamp, power$voltage, type="l",
     xlab="datetime", ylab="Voltage")

plot(power$timestamp, power$sub1, type="l", 
     xlab="", ylab="Energy sub metering")
with(power, lines(timestamp, sub2, col="red"))
with(power, lines(timestamp, sub3, col="blue"))
legend("topright", lty=1, bty="n", col=c("black", "red", "blue"),  
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(power$timestamp, power$reactive.power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()