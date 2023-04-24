README.md

This is the implementation of the project "Peer-graded Assignment: Getting and Cleaning Data Course Project"

Here are the data for the project:

 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

Importing of the data as per task descriptionis outside the project. The files are retrieved and unzipped prior to executing the R script.

Task is the following:

You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This respository contains the following files:

- README.md - this file
- Assignment_script.R - the script ingesting the files, processing them as per task description and writin the result to file MeanStats_5.txt
	-This script is full implementation of the project, there are no dependencies to other files. Inclusion of the required libraries are included in the script. References in the comments are made to the steps in the task description (above).
- MeanStats_5.txt - the resulting text file
- CodeBook.md - description of the data in the MeanStats_5.txt
