plot2 <- function(){
	#read the data
	df <- read.csv("household_power_consumption.txt",header = TRUE, sep = ";", stringsAsFactors=FALSE)
	#add a col to the data frame to join the date and time
	df$timestamp <- paste(df$Date, df$Time)
	df$timestamp <- strptime(df$timestamp, "%d/%m/%Y %H:%M:%S")
	#prune the data to only contain rows of interest (between 2007-02-01 and 2007-02-02) 
	
	df <- df[df$timestamp >= as.POSIXlt("2007-02-01 00:00:00") & df$timestamp <= as.POSIXlt("2007-02-02 23:59:59"),]

	# #coerce the column of interest to numeric
	df$Global_active_power  <- as.numeric(df$Global_active_power)
	
	plot(df$timestamp,df$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)",xlab="")
	dev.copy(png, file = "plot2.png")
	dev.off()

}

