plot3 <- function(){
	#read the data
	df <- read.csv("household_power_consumption.txt",header = TRUE, sep = ";", stringsAsFactors=FALSE)
	#add a col to the data frame to join the date and time
	df$timestamp <- paste(df$Date, df$Time)
	df$timestamp <- strptime(df$timestamp, "%d/%m/%Y %H:%M:%S")
	#prune the data to only contain rows of interest (between 2007-02-01 and 2007-02-02) 
	
	df <- df[df$timestamp >= as.POSIXlt("2007-02-01 00:00:00") & df$timestamp <= as.POSIXlt("2007-02-02 23:59:59"),]

	# coerce the columns of interest to numeric
	df$Sub_metering_1 = as.numeric(df$Sub_metering_1)
	df$Sub_metering_2 = as.numeric(df$Sub_metering_2)
	df$Sub_metering_3 = as.numeric(df$Sub_metering_3)


	
	#first line in default color
	plot(df$timestamp,df$Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab="")
	# add 2 lines
	lines(df$timestamp,df$Sub_metering_2, type="l",col = "red")
	lines(df$timestamp,df$Sub_metering_3, type="l",col = "blue")
	#legend
	legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty = c(1,1), lwd = c(2.5,2.5), col = c("black","red","blue"))
	dev.copy(png, file = "plot3.png")
	dev.off()

}

