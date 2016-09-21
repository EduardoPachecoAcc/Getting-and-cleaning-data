# Getting-and-cleaning-data
Project
The script works as follows
1. download the zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. unzip it (if step 1 or step 2 was already done, the script starts from step 3)
3. create vectors with features and activity labels
4. read all the tables and load them into variables
5. data frames variables columns are set using data in step 4.
6. train and test files are merged using cbind
7. everything is added into one variable
8. Find only colnames with mean std activityid and subjectid
9. merge only columns find in step 8 with the activity labels
10. new data set is created averaging by subjectid plus activitid
11. new data set is orderder by subjecteid then by activityid
12. new data set is loaded into flat file: TidyData.txt
