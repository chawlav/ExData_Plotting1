plot4 <- function(){
	#read the data
	df <- read.csv("household_power_consumption.txt",header = TRUE, sep = ";", stringsAsFactors=FALSE)
	#add a col to the data frame to join the date and time
	df$timestamp <- paste(df$Date, df$Time)
	df$timestamp <- strptime(df$timestamp, "%d/%m/%Y %H:%M:%S")
	#prune the data to only contain rows of interest (between 2007-02-01 and 2007-02-02) 
	
	df <- df[df$timestamp >= as.POSIXlt("2007-02-01 00:00:00") & df$timestamp <= as.POSIXlt("2007-02-02 23:59:59"),]

	# coerce the columns of interest to numeric
	df$Sub_metering_1  <- as.numeric(df$Sub_metering_1)
	df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
	df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
	df$Voltage <- as.numeric(df$Voltage)
	df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
	df$Global_active_power <- as.numeric(df$Global_active_power)



	#global preferences
	par(mfrow = c(2,2))

	#first plot x=Global_active_power y = timestamp
	plot(df$timestamp,df$Global_active_power, type = "l", ylab = "Global Active Power",xlab="")

	#second plot x = Voltage, y = timestamp
	plot(df$timestamp,df$Voltage, type = "l", ylab = "Voltage",xlab="datetime")	
	
	#third plot x = sub_metering 1, 2 or 3, y = timestamp
	#first line in default color
	plot(df$timestamp,df$Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab="")
	# add 2 lines
	lines(df$timestamp,df$Sub_metering_2, type="l",col = "red")
	lines(df$timestamp,df$Sub_metering_3, type="l",col = "blue")
	#legend
	legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty = c(1,1), lwd = c(2.5,2.5), col = c("black","red","blue"))
	

	# fourth plot x = Global Reactive power y = timestamp
	plot(df$timestamp,df$Global_reactive_power, type = "l", ylab = "Global Reactive Power",xlab="datetime")

	dev.copy(png, file = "plot4.png")
	dev.off()

}

