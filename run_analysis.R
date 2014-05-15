# Set the working directory path
# setwd("/Users/yjin/Dropbox/01.02.Study Notes/datasciencecoursera/getdata/project/")

# download data to the working directory and extract
if (!file.exists("UCI HAR Dataset")) {
	if (!file.exists("UCI HAR Dataset.zip")) {
		# remove method="curl" if you are on windows
		download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI HAR Dataset.zip",method = "curl")
		unzip("UCI HAR Dataset.zip")
	} else {
		unzip("UCI HAR Dataset.zip")
	}
}

# Give the path to data
p_data <- "UCI HAR Dataset"

# read data
## Read train data
X_train <- read.table(paste(p_data,"train", "X_train.txt", sep = "/"))
y_train <- read.table(paste(p_data,"train", "y_train.txt", sep = "/"))
subject_train <- read.table(paste(p_data,"train", "subject_train.txt", sep = "/")) 
### Check the coherence of read data
dim(X_train)
dim(y_train)
dim(subject_train)

## Read test data
X_test <- read.table(paste(p_data,"test", "X_test.txt", sep = "/"))
y_test <- read.table(paste(p_data,"test", "y_test.txt", sep = "/"))
subject_test <- read.table(paste(p_data,"test", "subject_test.txt", sep = "/")) 
### Check the coherence of read data
dim(X_test)
dim(y_test)
dim(subject_test)

# Merge Data
## Merge corresponding train, test data
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
dim(X)
dim(y)
dim(subject)

## Merge X, y, subject 
# --> Step 1: Merges the training and the test sets to create one data set.
colnames(subject) <- "subject"
colnames(y) <- "y"
data_s1 <- cbind(subject, y, X)

# Get the information of features in X
featureNames <- read.table(paste(p_data, "features.txt", sep = "/"))

# --> Step 2:Extracts only the measurements 
# on the mean and standard deviation for each measurement. 
labelValue <- grep("mean|std", featureNames$V2, value = T)
# NB: meanFreq is also captured because meanFreq is defined as
# meanFreq(): Weighted average of the frequency components to obtain a mean frequency 
# It indicates that this value is also a mean value
ind <- grep("mean|std", featureNames$V2) # Get the indication of extracted columns
# Due to the order of cbind
ind <- ind + 2
# Subset demanded columns
data_s2 <- data_s1[ , c(1,2,ind)]

# --> Step 3: Uses descriptive activity names to name the activities in the data set
#  get the meaning of each activity coding
activityName <- read.table(paste(p_data, "activity_labels.txt", sep = "/"))
colnames(activityName) <- c("y", "ActivityName")
data_s3 <- merge(activityName, data_s2, by = "y", all = T)
# remove y
data_s3 <- data_s3[,-1]

# --> Step 4: Appropriately labels the data set with descriptive activity names. 
# try to make feature names human understandable
lableValue2Rename <- strsplit(labelValue, "-")

lableValue2Renamed <- sapply(lableValue2Rename, function(x) {
	# t - time, f - frequency
	x[1] <- gsub("^t", "time",x[1])
	x[1] <- gsub("^f", "freq",x[1])
	# remove "()"
	x[2] <- gsub("\\(\\)","", x[2])
	# Capitalize first letter of function
	substring(x[2], 1, 1) <- toupper(substring(x[2], 1, 1))
	# collapse all texts
	return(paste(x, collapse = ""))
})

data_s4 <- data_s3
colnames(data_s4)[3:ncol(data_s4)] <- lableValue2Renamed

# --> Step 5: Creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject
data_s5 <- aggregate(data_s4[,3:ncol(data_s4)], data_s4[, c("ActivityName","subject")], FUN = mean)
# Verification
table(data_s5[,c(1,2)])

# Output of data 
write.table(data_s5, file = "tidyData.txt")

# # Output of Codebook via `Hmisc::describe`
# # Turn subject into factor
# data_s5[, 2] <- as.factor(data_s5[ , 2])
# # codebook
# codeBook <- describe(data_s5)
# sink("codebook.md");print(codeBook);sink()
# # The modification over markdown codebook

