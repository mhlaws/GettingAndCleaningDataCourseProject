# get feature names and activity names
featureLabels <- read.table("./data/UCI HAR Dataset/features.txt")[,2]
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)[,2]

# reduce 561 columns to only the 86 that deal with Mean or standard deviation
featureIndices <- grep("[Mm]ean|std", featureLabels, perl=TRUE, value=FALSE)

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


