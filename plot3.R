##
## Setting the working directory.
##
setwd("~/Teaching-and-Learning/Learning/Data-Science-Specialization/")
setwd("Data-Science-01-The-Data-Scientists-Toolbox/R/datasciencecoursera/")
if(!file.exists("ExploratoryDataAnalysis")) dir.create("ExploratoryDataAnalysis")
setwd("ExploratoryDataAnalysis")
##
## Downloading the ".zip" data file and unzipping it.
##
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(url,destfile='zipfile.zip')
dateDownloaded <- date()
unzip("zipfile.zip")
##
## Reading the dataset, setting names to the columns, subsetting
## the desired dataset, and removing incomplete cases (if any). 
##
df <- read.table("household_power_consumption.txt",sep=";",skip=1,na.strings="?")
names(df) <- c("date","time","activePower","reactivePower","voltage","intensity","sm1","sm2","sm3")
df$date <- as.Date(df$date,format="%d/%m/%Y")
data <- subset(df,date >= as.Date("2007-02-01") & date <= as.Date("2007-02-02"))
data <- data[complete.cases(data),]
##
## Merging the fist two columns of "data" and changing it class
## (from character to POSIXlt POSIXt).
##
data$zeit <- strptime(paste(data$date,data$time,sep=" "),format = "%Y-%m-%d %H:%M:%S")
data <- cbind(data[10],data[3:9])
##
## Making the plot. 
##
png(filename="plot3.png",width=480,height=480,units="px")
with(data, plot(zeit,sm1,xlab="",ylab="Energy sub metering",type="l",col="black"))
lines(data$zeit,data$sm2,col="red")
lines(data$zeit,data$sm3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,cex=0.95)
dev.off()
##