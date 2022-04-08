

library(tidyr)
library(dplyr)


url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "getdata_projectfiles_UCI HAR Dataset.zip"
download.file(url, file)
folder <- unzip(file)

#----Read in and format test and training data----

# Read in training data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read in test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Read in column names from the features text file
features <- read.table("UCI HAR Dataset/features.txt")
colnames(features) <- c("num","attributes")

#Rename x data set columns
colnames(x_train) <- features$attributes
colnames(x_test) <- features$attributes

# Read in Acivity names
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activities) <- c("num","activity")

# Rename y dataset column
colnames(y_train) <- "activity"
colnames(y_test) <- "activity"

#Rename subject data set columns
colnames(subject_train) <- "subject"
colnames(subject_test) <- "subject"

#------------------------------------------------------------------------#
#----REQUIREMENT #1: Read in, format, and merge test and training data----
#------------------------------------------------------------------------#

# Combine datasets
# Bind columns for training and test data
train_data <- cbind(subject_train, y_train, x_train)
test_data <- cbind(subject_test, y_test, x_test)

# Bind rows for training and test data
total_data <- rbind(train_data, test_data)


#-----------------------------------------------------------------------------#
#----REQUIREMENT #2: Extract only mean and standard devieation for measurements 
#-----------------------------------------------------------------------------#

total_data <- total_data %>% select(subject, activity, contains("mean"), contains("std"))


#----------------------------------------------------------------#
#----REQUIREMENT #3: Use descriptive activity names for activities  
#----------------------------------------------------------------#

total_data$activity <- activities[total_data$activity, 2]


#---------------------------------------------------------------------#
#----REQUIREMENT #4: Label the data set with descriptive variable names  
#---------------------------------------------------------------------#

new_colnames <- colnames(total_data) %>% as.data.frame()

new_colnames$. <- gsub("tBody","Time_Body", new_colnames$.) 
new_colnames$. <- gsub("Acc","_Acceleration", new_colnames$.)
new_colnames$. <- gsub("-mean()","_Mean", new_colnames$.)
new_colnames$. <- gsub("[()]","", new_colnames$.)
new_colnames$. <- gsub("tGravity","Time_Gravity", new_colnames$.)
new_colnames$. <- gsub("Gyro","_Gyroscope", new_colnames$.)
new_colnames$. <- gsub("Jerk","_Jerk", new_colnames$.)
new_colnames$. <- gsub("Mag","_Magnitude", new_colnames$.)
new_colnames$. <- gsub("fBody","Force_Body", new_colnames$.)
new_colnames$. <- gsub("Freq","_Frequency", new_colnames$.)
new_colnames$. <- gsub("BodyBody","Body", new_colnames$.)
new_colnames$. <- gsub("angleTime","Angle_Time", new_colnames$.)
new_colnames$. <- gsub("-std","_Std Deviation", new_colnames$.)
new_colnames$. <- gsub(",gravity","_Gravity_", new_colnames$.)
new_colnames$. <- gsub("angle","Angle_", new_colnames$.)

colnames(total_data) <- new_colnames$.


#---------------------------------------------------------------------#
#----REQUIREMENT #5: Create new tidy data set with the average for 
#--------------------each vaiable by activity by subject  
#---------------------------------------------------------------------#

summ_data <- total_data
final_results <- summ_data %>% group_by(activity, subject) %>%
  summarise_all(mean)

write.table(final_results,"Project_Submission_Kennedy.txt", row.names = FALSE)


