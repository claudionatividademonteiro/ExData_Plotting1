# Reading file
t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Formatting date to Type Date
t$Date <- as.Date(t$Date, "%d/%m/%Y")

# Filtering from Feb-1-2007 until Feb-2-2007
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Removing incomplete cases
t <- t[complete.cases(t),]

# Combining Date and Time column
dateTime <- paste(t$Date, t$Time)

# Re-naming the vector
dateTime <- setNames(dateTime, "DateTime")

# Removing useless columns
t <- t[ ,!(names(t) %in% c("Date","Time"))]

# Adding DateTime column
t <- cbind(dateTime, t)

# Formating DateTime Column
t$dateTime <- as.POSIXct(dateTime)

# Plotting and saving
with(t, {
        plot(Sub_metering_1~dateTime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()