
library(plyr)


# Change to your working directory for the course project
 setwd("C:/Rproject/Emmanuel/R_WD_Coursera/CourseProject3")

# Download dataset for project
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', dest="projectdataset.zip", mode="wb")

# unzip dataset 
# unzip ("projectdataset.zip", exdir = ".")


# Step 1. of the course project
# Merge the training and test sets to create one data set

# Reading training tables:
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
 
# Reading test tables:
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
 
# Create 'x' dataset
  x_data <- rbind(x_train, x_test)

# create 'y' dataset
  y_data <- rbind(y_train, y_test)
 
# create 'subject' dataset
  subject_data <- rbind(subject_train, subject_test)
 
# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
  features <- read.table('./UCI HAR Dataset/features.txt')

# Get only the columns with mean() or std() in their names
  Needed_mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# Subset the desired columns
  x_data <- x_data[, Needed_mean_and_std_features]

# correct the column names
  names(x_data) <- features[Needed_mean_and_std_features, 2]

# Step 3
# Use descriptive activity names to name the activities in the data set
  activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')

# update values with correct activity names
  y_data[, 1] <- activityLabels[y_data[, 1], 2]

  # update column name
  names(y_data) <- "activity"

# Step 4
# Appropriately label the data set with descriptive variable names
# update column name
  names(subject_data) <- "subject"

# bind all the data into a single dataset
  all_dataset <- cbind(x_data, y_data, subject_data)

# Step 5
# Create a second, independent tidy data set with the average of each variable
  tidy_data_avg <- ddply(all_dataset, .(subject, activity), function(x) colMeans(x[, 1:66]))
  write.table(tidy_data_avg, "tidy_data_avg.txt", row.name=FALSE)
