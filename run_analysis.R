

#create folder
original_directory <- getwd()
if(!dir.exists("FinalTask")){
  dir.create("FinalTask")
}
setwd("./FinalTask")

#download file
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "FUCI_GAR_Datase.zip")

#unzip compressd file
unzip("FUCI_GAR_Datase.zip")


#load in R the datasets
y_train <- read.csv("./UCI HAR Dataset/train/y_train.txt",header = FALSE)
names(y_train) <- "activity_label"

#use sep="" because there are fields separated by 1 space or by 2 spaces
x_train <- read.csv("./UCI HAR Dataset/train/x_train.txt",header = FALSE, sep = "")

subject_train <- read.csv("./UCI HAR Dataset/train/subject_train.txt",header = FALSE)
names(subject_train) <- "subject"



y_test <- read.csv("./UCI HAR Dataset/test/y_test.txt",header = FALSE)
names(y_test) <- "activity_label"

x_test <- read.csv("./UCI HAR Dataset/test/x_test.txt",header = FALSE, sep = "")

subject_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)
names(subject_test) <- "subject"


# PART 1
# merge all in one big table

#"train" section
# append activity data to full data
# append subject data to full data
complete_dataset <- cbind(x_train,subject_train,y_train)


#"test" section
# append activity data to full data
# append subject data to full data
aux_test_dataset <- cbind(x_test,subject_test,y_test)

# merge "train" full data with "test" full data
complete_dataset <- rbind(complete_dataset,aux_test_dataset)




# PART 4
# by using feature file , change column names in the data set
features_list <- read.csv("./UCI HAR Dataset/features.txt",header = FALSE, sep = "")
names(complete_dataset)[1:(ncol(complete_dataset)-2)]  <- features_list[,2]



# PART 2
#Load into R features file and with grep, search for "mean" and "std" getting the column IDs of matches

#with column IDs, using plyr and dplyr, select columns and store all in a new data.frame
library(plyr)
library(dplyr)

dataset_mean_std <- select(complete_dataset,ncol(complete_dataset),ncol(complete_dataset)-1,grep("std\\(\\)|mean\\(\\)",features_list[,2]))



#PART 3
# load in R, the activity labels
activity_labels <-read.csv("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ")
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
write.csv(dataset_mean_std,"dataset_with_means_and_std.csv")
write.csv(gropued_dataset_mean_std,"dataset_with_means_and_std_average_calculated.csv")

setwd(original_directory)
rm(list = ls())