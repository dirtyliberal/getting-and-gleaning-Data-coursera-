setwd("C:/Users/End User OEM/Documents/Rprogramming/Getting and Cleaning Data/Getting and Clearning Data")



#1. Merges the training and the test sets to create one data set.

# The training data set

train_x    <- read.table("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
train_y    <- read.table("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
train_subj <- read.table("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# The test data set

test_x    <- read.table("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test_y    <- read.table("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test_subj <- read.table("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)


# create one data set of the training then test then merge them together


train <- cbind(train_x,train_subj,train_y)
test  <- cbind(test_x,test_subj,test_y)

# dim(train) and dim(test) resutls in train[2947x563] and test[2947x563]
# to create one data set will use rbind

combined_data <- rbind(train,test)

## Assign colomn names
features <- read.table("UCI HAR Dataset/features.txt")
colnames(combined_data) <- c(as.character(features[,2]),"Subject","Activity")


#2. Extracts only the measurements on the mean and standard deviation for each measurement

#find in features (also transposed onto colomns of combined_data) 

meanStd <- grepl("(mean|std)",features[,2])
extracted_data <- combined_data[,meanStd]

#Column names don't copy over. 
names(extracted_data) <- names(combined_data[,meanStd])

#3. Uses descriptive activity names to name the activities in the data set

#the numbers in the last column of extracted_data are mapped in activity_labels.txt

labels <- read.table("UCI HAR Dataset/activity_labels.txt")
extracted_data$Activity<-labels[extracted_data$Activity,2]


#4 Appropriately labels the data set with descriptive variable names. 

features2<- names(extracted_data)


# Took these names from the features_into.text document. 
features2 <- gsub('\\(|\\)',"",features2) # goodbye to the ()
features2 <- gsub("mean"," Mean value",features2,ignore.case=T)
features2 <- gsub("std"," Standard deviation",features2,ignore.case=T)
features2 <- gsub("mad"," Median absolute deviation",features2,ignore.case=T)
features2 <- gsub("max"," Largest value in array",features2,ignore.case=T)
features2 <- gsub("energy","Energy measure. Sum of the squares divided by the number of values",features2,ignore.case=T)
features2 <- gsub("iqr"," Interquartile range",features2,ignore.case=T)
features2 <- gsub("entropy"," Signal entropy",features2,ignore.case=T)
features2 <- gsub("arCoeff"," Autorregresion coefficients with Burg order equal to 4",features2,ignore.case=T)
features2 <- gsub("correlation"," correlation coefficient between two signals",features2,ignore.case=T)
features2 <- gsub("maxInds"," index of the frequency component with largest magnitude",features2,ignore.case=T)
features2 <- gsub("meanFreq"," Weighted average of the frequency components to obtain a mean frequency",features2,ignore.case=T)
features2 <- gsub("skewness"," skewness of the frequency domain signal",features2,ignore.case=T)
features2 <- gsub("kurtosis"," kurtosis of the frequency domain signal ",features2,ignore.case=T)
features2 <- gsub("bandsEnergy"," Energy of a frequency interval within the 64 bins of the FFT of each window",features2,ignore.case=T)
features2 <- gsub("angle"," Angle between to vectors",features2,ignore.case=T)

names(extracted_data)  <- features2

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr)
independent_tidy_data2 <- ddply(extracted_data, .(Subject,Activity), numcolwise(mean))

write.table(independent_tidy_data, "indep_tidy_data.txt", row.name=FALSE)