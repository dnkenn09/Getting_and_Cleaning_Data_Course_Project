CodeBook

Author: Dereck Kennedy

=====================================================

This code book details the tasks accomplished by the run_analysis.R script to fulfill requirements for the Coursera: Getting and Cleaning Data.
It is separated into two sections.

=====================================================

Section 1: Preparatory Actions

 - The 'tidyr' and 'dplyr' packages were initialized to allow use of required functions.

 - Downloaded and unzipped the .zip file containing relevant data files for the project from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

 - Created data frames for the below text files which contained the relevant experimental data:
    x_train.txt: 7362 observations for 561 experiment variables
    y_train.txt: The activity for each of the 7362 observations in the x_train.txt data
    subject_train.txt: The subject for each of the 7362 observations in the x_train.txt data
    x_test.txt: 2947 observations for the same 561 experiment variables included in the x_train.txt data
    y_test.txt: The activity for each of the 2947 observations in the x_test.txt data
    subject_test.txt: The subject for each of the 2947 observations in the x_test.txt data

  - Created a data frame using the activity_labels.txt file which then provided the number values associated with each activity name.

  - Created a data frame using features.txt which contained the 561 variables included in the x_train.txt and x_test.txt data.

  - Created matching column names for test and training data frames to ensure successful merger in the next step.

=====================================================

Section 2: Project Requirements

The project included five specific requirements. Each was executed via a block of code.

-----------------------------------------------------

Requirement #1: Merges the training and the test sets to create one data set

  - Used the 'cbind' function to combine the subject, y, and x_train data frames.

  - Used the 'cbind' function to combine the subject, y, and x_test data frames. 

  - Used the 'rbind' function to combine the test and training data frames.

-----------------------------------------------------

Requirement #2: Extracts only the measurements on the mean and standard deviation for each measurement

  - Used the 'select' function to only retain the 'subject' and 'activity' columns along with all other columns containing 'mean' or 'std'.

-----------------------------------------------------

Requirement #3: Uses descriptive activity names to name the activities in the data set

  - Assigned the associated activity name from the 'activities' data frame to the corresponding number.

-----------------------------------------------------

Requirement #4: Appropriately labels the data set with descriptive variable names

  - Used descriptions in the 'features_info.txt' file and 'gsub' function to substitute easier to understand descriptions for current column titles.

  - Created a separate data frame to make adjustments to column names. Adjustments made:
      tBody      to  Time_Body
      Acc        to  _Acceleration
      -mean      to  _Mean
      ()         to  *Deleted
      tGravity   to  Time_Gravity
      Gyro       to  _Gyroscope
      Jerk       to  _Jerk
      Mag        to  _Magnitude
      fBody      to  Force_Body
      Freq       to  -Frequency
      BodyBody   to  Body
      angleTime  to  Angle_Time
      -std       to  _Std Deviation
      ,gravity   to  _Gravity_
      angle      to  Angle_

  - Renamed the column names for the 'total_data' data frame with adjusted names data frame.

-----------------------------------------------------

Requirement #5: Create a second, independent tidy data set with the average of each variable for each activity and each subject

  - Created a copy of the 'total data' data frame called 'summ_data'.

  - Created the 'final_results' data frame by grouping 'summ_data' by 'activity' and 'subject' before using the 'summarise_all' function to get the mean for all variables for the groupings.

  - The resulting data frame is a 180 observation by 88 variable data frame. 
