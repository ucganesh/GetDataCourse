Getting and Cleaning Data Project Assignment
============================================
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set.


DATASET
==============================================
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data used for the project is in the folder UCI HAR Dataset in this repository. To know about the dataset read file "README.txt" available in the dataset folder


DETAILS
=============================================
The code has a file run_analysis.R in the main directory that can be run as long as the Samsung data is in the working directory. The output would be a tidy data set.

NOTE: Manually modified features.txt to rename the features to a standardised format.

Tidying process:
===============================================
1. Generated dataset by merging data in y_train.txt (Activity done by subjects in subject_train.txt) with the activity names
2. Loaded the measurements in x_train.txt, and also associated the variables names obtained from features.txt to the measurements.
3. Combined Subject data, Activity data and Measurements into a single merged dataset.
4. Repeated steps 1, 2 and 3 for test data and obtained a combined dataset with Subject, Activity and Measurements information
5. Merged training and testing data 
6. Created a subset dataset with only required columns to get just the mean and standard deviation of all the measurements, identified by subject and activity.
7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.






