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

# draws plot 1

title<-"Global Active Power"
label<-paste(title,"(kilowatts)")
hist(Global_active_power,col="red",main=title,xlab=label)

# saves plot 1

dev.copy(png,'plot1.png')
dev.off()
