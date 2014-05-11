# reads the data from the unzipped file
# dirty, but works well enough

rows<-60*24*2 # 2 days in seconds
values<-read.table("household_power_consumption.txt",nrows=rows,sep=";",skip=66637)
dates<-as.vector(values[,1])
times<-as.vector(values[,2])
datetimes<-strptime(paste(dates,times),"%d/%m/%Y %H:%M:%S")
header<-read.table("household_power_consumption.txt",header=TRUE,nrows=1,sep=";")
colnames(values)[3:9]<-colnames(header[,3:9])
data<-cbind(datetimes,values[,3:9])
colnames(data)[1]<-"datetime"

attach(data)

# draws plot 3

plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(datetime,Sub_metering_2,col="red")
lines(datetime,Sub_metering_3,col="purple")
legend("topright",legend=colnames(data)[6:8],col=c("black","red","purple"),lwd=1)

# saves plot 3

dev.copy(png,'plot3.png')
dev.off()
