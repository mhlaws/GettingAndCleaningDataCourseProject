# get feature names and activity names
featureLabels <- read.table("./data/UCI HAR Dataset/features.txt")[,2]
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)[,2]

# make sure feature labels will make valid column headers
featureLabels <- gsub("[(),]", "", featureLabels, perl=TRUE)
featureLabels <- gsub("-", "", featureLabels, perl=TRUE)

# reduce 561 columns to only the 12 that deal with the mean or standard deviation of measurements
# this should be the xyz data from the accelerometer and the gyroscope -- everything else is computed.
# does not include meanFreq which is a different measurement
# only includes measurements made in the time domain (not computed frequency domain)
featureIndices <- grep("^(tBodyAcc|tBodyGyro)(?!Jerk)(?!Mag).*([Mm]ean(?!freq)|std)", featureLabels, perl=TRUE, value=FALSE)

# the following lines are only to help me create the code book and are commented out
#reducedFeatureLabels <- featureLabels[featureIndices]
#k <- 0; for(i in seq_along(featureIndices)){ print(cat(k<- k + 1,' ',reducedFeatureLabels[i]))}

# getting test and train data
activityTestData <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = 'Activity')
activityTrainData <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = 'Activity')

# replace activity codes with their names for both test and train data sets
for(i in seq_along(activityLabels)){
  activityTestData[activityTestData$Activity == i,1] <- activityLabels[i]
  activityTrainData[activityTrainData$Activity == i,1] <- activityLabels[i]
}

subjectsTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = 'Subject')
subjectsTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = 'Subject')

sensorTestData <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = featureLabels)
sensorTrainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = featureLabels)

# subset feature data similarly to the columns from featureIndices
sensorTestData <- sensorTestData[,featureIndices]
sensorTrainData <- sensorTrainData[,featureIndices]

# put test together
dataTest <- cbind(subjectsTest, activityTestData, sensorTestData)
# put train together
dataTrain <- cbind(subjectsTrain, activityTrainData, sensorTrainData)

# combine into one data set
allData <- rbind(dataTest, dataTrain)

# clean up some of the temporary variables that are no longer needed
rm(activityTestData, activityTrainData, sensorTestData, sensorTrainData, subjectsTest, subjectsTrain, activityLabels, featureIndices, featureLabels, i, dataTest, dataTrain)


# step 5: creating an independent tidy data set with 
#         the averages for each activity and each subject
library(dplyr)
library(reshape2)

dataMelt <- melt(allData, id=c("Subject", "Activity"))
tidyData <- dcast(dataMelt, Subject + Activity ~ variable, mean)

# clean up
rm(allData, dataMelt)

# generate output file
write.table(tidyData, file = "./data/tidyData.txt", row.names = FALSE)
