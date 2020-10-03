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
## Reading the original dataset, setting names to the columns, and subsetting
## the desired dataset. 
##
df <- read.table("household_power_consumption.txt",sep=";",skip=1,na.strings="?")
names(df) <- c("date","time","activePower","reactivePower","voltage","intensity","sm1","sm2","sm3")
df$date <- as.Date(df$date,format="%d/%m/%Y")
data <- subset(df,date >= as.Date("2007-02-01") & date <= as.Date("2007-02-02"))
data <- data[complete.cases(data),]
##
## Making the plot. 
##
png(filename="plot1.png",width=480,height=480,units="px")
hist(data$activePower,xlab="Global Active Power (kilowatts)",main="Global Active Power",col="red")
dev.off()
##