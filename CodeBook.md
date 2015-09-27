Step 1 : Extract the training data from the files subject_train.txt, X_train.txt and Y_train.txt into separate data frames(d1,d2&d3).
Step 2 : Merge the data frames created in Step 1 into a single data frame(train).
Step 3 : Repeat Step 1 and Step 2 for testing data (test).
Step 4 : Merge the data frames created in Step 2 and Step 3 into single data frame (mergedData).
Step 5 : Extract out the columns corresponding to measurements on mean and standard deviation only and store the result in a new data frame(mergedData).
Step 6 : Replace the activity numbers in data set by their corresponding descriptive names provided in activity_labels.txt and store the result in a new data frame(mergedDataNew).
Step 7 : Group the data in mergedData data frame by Subject and Activity and store the result in a new data frame(groupedData2).
Step 8 : Calculate the average of all columns of groupedData2 and store the result in a new data frame(resultData).
Step 9 : Write the data frame, resultData, to a txt file 'Result.txt'.
