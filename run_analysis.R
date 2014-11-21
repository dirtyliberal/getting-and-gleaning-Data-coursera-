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

#3. Uses descriptive activity names to name the activities in the data set

#the numbers in the last column of extracted_data are mapped in activity_labels.txt

labels <- read.table("UCI HAR Dataset/activity_labels.txt")
extracted_data$Activity<-labels[extracted_data$Activity,2]


#4 Appropriately labels the data set with descriptive variable names.

#vaiable name was actually already appropriately labeled in part #1 using the below code.
#colnames(combined_data) <- c(as.character(features[,2]),"Subject","Activity")
#by subsetting and transposing the data the colname stayed.

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

independent_tidy_data <- ddply(extracted_data, .(Subject,Activity), numcolwise(mean))

write.table(independent_tidy_data_5, "indep_tidy_data.txt", row.name=FALSE)