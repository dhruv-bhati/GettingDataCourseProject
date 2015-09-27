## Code to merge the training data into a single data frame.
d1 <- read.table("train/subject_train.txt")
d2 <- read.table("train/X_train.txt")
d3 <- read.table("train/y_train.txt")
train <- cbind(d1,d2,d3)


## Code to merge the testing data into a single data frame.
d4 <- read.table("test/subject_test.txt")
d5 <- read.table("test/X_test.txt")
d6 <- read.table("test/y_test.txt")
test <- cbind(d4,d5,d6)


## Code to merge training and testing data into a single file.
mergedData <- rbind(train,test)


## Code to extract only measurements on mean and standard deviation
## for each measurement.This code also adds columns names to the 
## mergedData data frame.
library(dplyr)
featureNames <- read.table("features.txt")
colnames(featureNames) <- c("SNo","FeatureName")
featureNames <- select(featureNames, FeatureName)
library(stringi)

colnames(mergedData)[1] <- "SubjectID"
for(i in seq_len(561)) {
    colnames(mergedData)[i+1] <- as.character(featureNames[i,1])
}
colnames(mergedData)[563] <- "ActivityName"

mergedDataNew <- data.frame(mergedData$SubjectID)
colnames(mergedDataNew)[1] <- "SubjectID"
j <- 1
for(i in seq_len(561)) {
    if(stri_detect_fixed(colnames(mergedData)[i+1], "mean") == TRUE | stri_detect_fixed(colnames(mergedData)[i+1], "std") == TRUE | stri_detect_fixed(colnames(mergedData)[i+1], "meanFreq") == TRUE | stri_detect_fixed(colnames(mergedData)[i+1], "Mean") == TRUE) {
        mergedDataNew <- cbind(mergedDataNew, mergedData[,i+1])
        j <- j + 1
        colnames(mergedDataNew)[j] <- colnames(mergedData)[i+1]
    }
}
mergedDataNew <- cbind(mergedDataNew, mergedData$ActivityName)
colnames(mergedDataNew)[88] <- "ActivityName"


## Code to replace activity numbers by their corresponding descriptive names.
activityNames <- read.table("activity_labels.txt")
for(i in seq_len(dim(mergedDataNew)[1])) {
    j <- mergedDataNew[i,"ActivityName"]
    mergedDataNew[i,"ActivityName"] <- as.character(activityNames[j,2])
}


## Code to group data by ActivityName and SubjectID
groupedData1 <- group_by(mergedDataNew, SubjectID)
groupedData2 <- group_by(groupedData1, ActivityName, add = TRUE)


## Code to generate average of each variable of groupedData2
resultData <- summarise_each(groupedData2 ,funs(mean))


## Code to write resultData to a txt file
write.table(resultData, file = "Result.txt", row.names = FALSE)
