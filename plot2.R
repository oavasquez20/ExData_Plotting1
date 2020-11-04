library("dplyr")

setwd("D:/Trabajo/R/Curso4")

#Reads in data from file then subsets data for specified dates
hpc <- read.table("household_power_consumption.txt",skip=1,sep=";")

#Name 9 variables
names(hpc) <- c("Date",
                "Time",
                "Global_active_power",
                "Global_reactive_power",
                "Voltage",
                "Global_intensity",
                "Sub_metering_1",
                "Sub_metering_2",
                "Sub_metering_3")

#Check Structured of data, "Note that in this dataset missing values are coded as?".

str(hpc)

#Global_active_power has missing value "?", by doing as.numeric(as.string(Global_active_power))
#R transforms Global_active_power into numeric variable and "?" is convert to "NA"

hpc <- mutate(hpc,Global_active_power=as.numeric(as.character(Global_active_power)))

#Subset with dates
subhpc <- subset(hpc,hpc$Date=="1/2/2007" | hpc$Date =="2/2/2007" 
                 & is.na(hpc$Global_active_power)== FALSE)

#formatting dates

datetime <- strptime(paste(subhpc$Date, subhpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

#calling hist function

plot(x = datetime, y = subhpc$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Name and size of Histogram

png("plot2.png", width=480, height=480)

#Close histogram

dev.off()
