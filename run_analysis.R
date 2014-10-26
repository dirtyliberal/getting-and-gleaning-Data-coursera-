setwd("C:/Users/End User OEM/Documents/Rprogramming/Getting and Cleaning Data/Getting and Clearning Data")

#upload the training data set in place them in there own apely names variable names 

# first for the training data set

train = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
train[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
train[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# now the test data set

test = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

# Now merge the 2 data sets together

Combined_Data <- rbind(train, test)

f1 = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)

datarequired <- grep(".*mean.*|.*std.*", f1[,2])
f1 <- f1[datarequired,]

datarequired <- c(datarequired, 562, 563)

Combined_Data  <- Combined_Data[,datarequired]

colnames(Combined_Data) <- c(f1$V2, "Activity", "Subject")
colnames(Combined_Data) <- tolower(colnames(Combined_Data))


############

act = 1
for (currentActivityLabel in activityLabels$V2) {
  Combined_Data$activity <- gsub(active, currentActivityLabel, Combined_Data$activity)
  act <- act + 1
}
Combined_Data$activity <- as.factor(Combined_Data$activity)
Combined_Data$subject <- as.factor(Combined_Data$subject)
tidy = aggregate(Combined_Data, by=list(activity = Combined_Data$activity, subject=Combined_Data$subject), mean)


tidy[,90] = NULL
tidy[,89] = NULL
write.table(tidy, "tidy.txt", sep="\t")
