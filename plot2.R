## Exploratory plot of houshold global active power over 2 day's time

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

# Produce line plot
png(file = "plot2.png")
plot(power$timestamp, power$active.power, type="l",
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
