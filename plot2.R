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
## Reading the original dataset, setting names to the columns, subsetting
## the desired dataset, and removing incomplete cases (if any). 
##
df <- read.table("household_power_consumption.txt",sep=";",skip=1,na.strings="?")
names(df) <- c("date","time","activePower","reactivePower","voltage","intensity","sm1","sm2","sm3")
df$date <- as.Date(df$date,format="%d/%m/%Y")
data <- subset(df,date >= as.Date("2007-02-01") & date <= as.Date("2007-02-02"))
data <- data[complete.cases(data),]
##
## Merging the fist two columns of data set "data".
##
data$zeit <- strptime(paste(data$date,data$time,sep=" "),format = "%Y-%m-%d %H:%M:%S")
data <- cbind(data[10],data[3:9])
##
## Making the plot. 
##
png(filename="plot2.png",width=480,height=480,units="px")
plot(data$zeit,data$activePower,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
##