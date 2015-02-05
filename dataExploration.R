# read in the data from the text file
smallDataFileName<-"household_power_consumption_ROI.txt"
smallFile<-file.exists(smallDataFileName)
library(lubridate)

if(smallFile){
  data<-read.table(smallDataFileName,header=TRUE,sep=";") # read the small version of the file
  data$Date<-ymd(data$Date)
  data$Time<-hms(data$Time)
  #class(data$Date) # check the class of the dates
} else {
  data = read.table("household_power_consumption.txt",header=TRUE,sep=";")  # read the full text datafile
  
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
  data$Time<-hms(data$Time)
}


