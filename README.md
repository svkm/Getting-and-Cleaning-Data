Getting-and-Cleaning-Data
=========================

Course Project - Getting and Cleaning Data

Execute this code (run_analysis.R) in the folder which contains the Samsung data

The script

1. Reads all files
2. Reads column labels from features.txt
3. Remove special characters: -,(,) and comma from the variable names
4. Convert Activity labels in y_train.txt and y_test.txt to meaningful names like WALKING, SITING, STANDING, etc
5. Appends Activity labels and Subject numbers (columns) to train and test data
6. Merges train and test data
7. Extracts data with mean() and std() in the variable names
8. Computes col averages and groups by Subject and Activity (dropping rows without data)
9. Writes a text file (XCleanAvg) - Coursera does not permit csv uploads
