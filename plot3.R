# read in the data from the text file
smallDataFileName<-"household_power_consumption_ROI.txt"
smallFile<-file.exists(smallDataFileName)
library(lubridate)

if(smallFile){
  data<-read.table(smallDataFileName,header=TRUE,sep=";", na.strings="?") # read the small version of the file
  data$Date<-ymd(data$Date)
  #class(data$Date) # check the class of the dates
} else {
  data = read.table("household_power_consumption.txt",header=TRUE,sep=";", na.strings="?")  # read the full text datafile
  
  # select dates of interest
  data1<-data
  data1$Date<-dmy(data$Date)
  
  # select dates of interest
  dateStart<-ymd("2007-02-01")
  dateEnd<-ymd("2007-02-02")
  dataROI<- (data1$Date >= dateStart) & (data1$Date <= dateEnd)
  
  # limit the data set
  dataOI<-data1[dataROI,]
  
  # write selected data to table
  write.table(dataOI, file = "household_power_consumption_ROI.txt", sep = ";")
  data<-dataOI
  
}

# convert time column to Time class
#data$Time<-strptime(data$Time, format = "%H:%M:%S")

# add a timestamp column
data$timestamp<-ymd_hms(paste(data$Date,data$Time))

# plot 3
png("plot3.png",height=480, width=480)
par(mfrow = c(1,1))
with(data,plot(timestamp,Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
with(data,lines(timestamp,Sub_metering_1,col="black"))
with(data,lines(timestamp,Sub_metering_2,col="red"))
with(data,lines(timestamp,Sub_metering_3,col="blue"))
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#dev.copy(png,file="plot3.png")
dev.off()

