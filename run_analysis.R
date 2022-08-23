
###### Getting and Cleaning Data Course Project #####
# This scripts has the following parts:
#   - load in R the datasets
#   - merge the datasets including subject data, and activity data
#   - set column names of merged dataset
#   - create required sub dataset of means and standard deviations
#   - for this last dataset, change activity numbers to activity descriptions
#   - create a third dataset, wiht requierd summarization
#   - export to .txt the grouped datasets required in part 5 of project
#   - delete all variables





#load in R the datasets
y_train <- read.csv("./UCI HAR Dataset/train/y_train.txt",header = FALSE)
#change name to activity label field
names(y_train) <- "activity_label"

#use sep="" because there are fields separated by 1 space or by 2 spaces
x_train <- read.csv("./UCI HAR Dataset/train/x_train.txt",header = FALSE, sep = "")

subject_train <- read.csv("./UCI HAR Dataset/train/subject_train.txt",header = FALSE)
#change name to subject field
names(subject_train) <- "subject"



y_test <- read.csv("./UCI HAR Dataset/test/y_test.txt",header = FALSE)
#change name to activity label field
names(y_test) <- "activity_label"

x_test <- read.csv("./UCI HAR Dataset/test/x_test.txt",header = FALSE, sep = "")

subject_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)
#change name to subject field
names(subject_test) <- "subject"


# PART 1
# merge all in one big table

#"train" section
# append activity data to big table 1 (complete_dataset)
# append subject data to big table 1 (complete_dataset)
complete_dataset <- cbind(x_train,subject_train,y_train)


#"test" section
# append activity data to big table 2 (aux_test_dataset)
# append subject data to big table 2 (aux_test_dataset)
aux_test_dataset <- cbind(x_test,subject_test,y_test)

# merge "complete_dataset" and "aux_test_dataset" into "complete_dataset"
complete_dataset <- rbind(complete_dataset,aux_test_dataset)




# PART 4
# by using "features.txt" file, change column names in "complete_dataset"
features_list <- read.csv("./UCI HAR Dataset/features.txt",header = FALSE, sep = "")
names(complete_dataset)[1:(ncol(complete_dataset)-2)]  <- features_list[,2]



# PART 2
#Using "features.txt" file loaded previosuly, and by using grep, search for "mean()" and "std()", and get the column IDs of matches

#with column IDs, using plyr and dplyr, select columns and store all in a new data.frame called "dataset_mean_std"
library(plyr)
library(dplyr)

dataset_mean_std <- select(complete_dataset,ncol(complete_dataset),ncol(complete_dataset)-1,grep("std\\(\\)|mean\\(\\)",features_list[,2]))



#PART 3
# load in R, the activity labels
activity_labels <-read.csv("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ")
# change names to activity_labels in order to join tables smoothly
names(activity_labels)[1] <- "activity_label"
names(activity_labels)[2] <- "activity_desc"

# join to append column with activity description
dataset_mean_std <- join(activity_labels,dataset_mean_std)

# remove activity label, leaving only activity description
dataset_mean_std <- dataset_mean_std[,2:ncol(dataset_mean_std)]



# PART 5
# calculate the summarization and store it in a new data frame.
gropued_dataset_mean_std <- dataset_mean_std %>% group_by(activity_desc,subject) %>% summarize(across(everything(), list(mean)))


# DATA DELIVERY AND CHANGE WORKING DIRECTORY
write.table(gropued_dataset_mean_std,"dataset_with_means_and_std_average_calculated.txt", row.names = FALSE)

rm(list = ls())

