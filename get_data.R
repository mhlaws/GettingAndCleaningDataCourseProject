# description of the data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

if(!file.exists("./data")) dir.create("./data")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/data.zip", method = "curl")
unzip("./data/data.zip", exdir = "./data")
dateDownloaded <- date()