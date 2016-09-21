file <- "getdata_dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(file)){
  download.file(fileURL, file, method = "libcurl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(file) 
}
#extracting column names.
features <- read.table('./UCI HAR Dataset/features.txt')
activitylabels = read.table('./UCI HAR Dataset/activity_labels.txt')

#reading and loading data from flat files.
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
strain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
stest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#setting colnames to tables
colnames(xtrain) <- features[,2] 
colnames(ytrain) <-"activityId"
colnames(strain) <- "subjectId"
colnames(xtest) <- features[,2] 
colnames(ytest) <- "activityId"
colnames(stest) <- "subjectId"
colnames(activitylabels) <- c('activityId','activityType')

#merging...
mrg_train <- cbind(ytrain, subjecttrain, xtrain)
mrg_test <- cbind(ytest, subjecttest, xtest)
#merging everything...
everything <- rbind(mrg_train, mrg_test)
colNames <- colnames(everything)

#Find colnames with activityid, subjectid, mean and/or std name
meanandstd <- ( 
                  grepl("mean.." , colNames) | 
                  grepl("std.." , colNames) |
                  grepl("activityId" , colNames) | 
                  grepl("subjectId" , colNames)
)

# taking onlye mean and std fields
setMeanStd <- everything[ , meanandstd == TRUE]
# joining resultset and activitylabels
setWithLabels <- merge(setMeanStd, activityLabels,by='activityId',all.x=TRUE)
# averaging by subjectid and activityid
TidySet <- aggregate(. ~subjectId + activityId, setWithLabels, mean)
# creating the second data set
TidySet <- TidySet[order(TidySet$subjectId, TidySet$activityId),]
# creating flat file
write.table(TidySet, "TidyData.txt", row.name=FALSE)
