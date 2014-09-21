##
# Runs analysis, takes input for location of files. Assumes that the location will have
# folders test, train with files subject_test.txt, X_test.txt, Y_test.txt and 
# subject_train.txt, X_train.txt, Y_train.txt
##
run_analysis <- function(){
	
	directory <- paste(getwd(),"UCI HAR Dataset",sep="/")	

	#Load activity labels
	activity_labels_path <- paste(directory,"activity_labels.txt",sep="/")
	activity_labels_ds <- read.table(activity_labels_path,header=FALSE, col.names=c("ActivityId","ActivityName"))
	
	# load features.txt
	features_path <- paste(directory,"features.txt",sep="/")
	features_ds <- read.table(features_path, header=FALSE)

	#Lets create a merged dataset for training data, merges data in subject, X and Y text files
	train_path <- paste(directory,"train", sep="/")

	#Load Y_train.txt
	Y_train_path <- paste(train_path, "Y_train.txt", sep="/")
	y_train_ds <- read.table(Y_train_path, header=FALSE, col.names=c("ActivityId"))	
	
	#Merge y_train.txt with activity.txt to generate dataset with activity names
	library(plyr)
	activityds_train <- join(y_train_ds, activity_labels_ds, by=c("ActivityId"))
			

	#Load X_train dataset and filter it to only to mean and standard deviation of the variables based on features.txt
	x_train_path <- paste(train_path, "X_train.txt", sep="/")
	x_train_ds <- read.table(x_train_path, header=FALSE, col.names=features_ds[,2])
	
	#load subject data
	subject_train_path <- paste(train_path, "subject_train.txt", sep="/")
	subject_train_ds <- read.table(subject_train_path, header=FALSE, col.names=c("SubjectId"))	

	#merge x and activiti
	merge1_train_ds <- cbind(subject_train_ds, activityds_train)
	merge2_train_ds <- cbind(merge1_train_ds, x_train_ds)

	#Lets create a merged dataset for test data, merges data in subject, X and Y text files
	test_path <- paste(directory,"test", sep="/")

	#Load Y_test.txt
	Y_test_path <- paste(test_path, "Y_test.txt", sep="/")
	y_test_ds <- read.table(Y_test_path, header=FALSE, col.names=c("ActivityId"))	
	
	#Merge y_test.txt with activity.txt to generate dataset with activity names
	library(plyr)
	activityds_test <- join(y_test_ds, activity_labels_ds, by=c("ActivityId"))
			

	#Load X_test dataset and filter it to only to mean and standard deviation of the variables based on features.txt
	x_test_path <- paste(test_path, "X_test.txt", sep="/")
	x_test_ds <- read.table(x_test_path, header=FALSE, col.names=features_ds[,2])
	
	#load subject data
	subject_test_path <- paste(test_path, "subject_test.txt", sep="/")
	subject_test_ds <- read.table(subject_test_path, header=FALSE, col.names=c("SubjectId"))	

	#merge x and activiti
	merge1_test_ds <- cbind(subject_test_ds, activityds_test)
	merge2_test_ds <- cbind(merge1_test_ds, x_test_ds)

	#Merge both training and testing data
	combined_ds <- rbind(merge2_train_ds,merge2_test_ds)
		
	#Extracts only the measurements on the mean and standard deviation for each measurement. 
	combined_ds <- combined_ds[,c(1,3,4:9,44:49,84:89,124:129,164:169,204:205,217:218,
                                     230:231,243:244,256:257,269:274,348:353,427:432,506:507,
						519:520,532:533,545:546)]

	#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	library(plyr)
	tidy_ds <- ddply(combined_ds,.(SubjectId,ActivityName),numcolwise(mean)) 
	tidy_ds
}
