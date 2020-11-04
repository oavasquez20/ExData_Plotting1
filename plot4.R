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

#Check Structured of data, "Note that in this dataset missing values are coded as '?'".

str(hpc)

#Global_active_power has missing value "?", by doing as.numeric(as.string(Global_active_power))
#R transforms Global_active_power into numeric variable and "?" is convert to "NA"

hpc <- mutate(hpc,Global_active_power=as.numeric(as.character(Global_active_power))
                 ,Global_reactive_power=as.numeric(as.character(Global_reactive_power))
                 ,Voltage=as.numeric(as.character(Voltage))
                 ,Sub_metering_1=as.numeric(as.character(Sub_metering_1))
                 ,Sub_metering_2=as.numeric(as.character(Sub_metering_2))
                 ,Sub_metering_3=as.numeric(as.character(Sub_metering_3)))

#Check new structure

str(hpc)

#Subset with dates
subhpc <- subset(hpc,hpc$Date=="1/2/2007" | hpc$Date =="2/2/2007" 
                     & is.na(hpc$Global_active_power)== FALSE)

#formatting dates

datetime <- strptime(paste(subhpc$Date, subhpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S")


#frame for 4 plots

par(mfrow=c(2,2))

#Plot1 Global Active Power

plot(x = datetime, y = subhpc$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power")

#plot2 Voltage

plot(x = datetime,y= subhpc$Voltage, type="l", xlab="datetime", ylab="Voltage")

#plot3 Energy Sub metering

plot(x = datetime, y = subhpc$Sub_metering_1, 
     type="l", xlab="", ylab="Energy Sub metering")
lines(x = datetime, y = subhpc$Sub_metering_2,type="l",col="red")
lines(x = datetime, y = subhpc$Sub_metering_3,type="l",col="blue")
legend("top", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
                 ,col=c("black", "red", "blue"), lty=1, lwd=1,bty="n"
                 ,text.width = 2, cex = 0.4, title.adj = 1)

#plot4 Global_Reactive_Power

plot(x = datetime, y = subhpc$Global_reactive_power, type="l"
     , xlab="datetime", ylab="Global_reactive_power")

#Save Plot

png("plot4.png", width=480, height=480)

#Close Plot

dev.off()

