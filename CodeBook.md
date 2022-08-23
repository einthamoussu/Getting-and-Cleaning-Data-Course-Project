CodeBook

Here are described the different variables used and how they work.


MISCELANEOUS VARIABLES
"original_directory" -> to store the original working directory
"fileurl" -> to store the url of the downladable zip file


VARIABLES USED TO LOAD DATA FROM FILES
"y_train" -> to load file "./UCI HAR Dataset/train/y_train.txt"
"x_train" -> to load file "./UCI HAR Dataset/train/x_train.txt"
"subject_train" -> to load file "./UCI HAR Dataset/train/subject_train.txt"

"y_test" -> to load file "./UCI HAR Dataset/test/y_test.txt"
"x_test" -> to load file "./UCI HAR Dataset/test/x_test.txt"
"subject_test" -> to load file "./UCI HAR Dataset/test/subject_test.txt"

"features_list" -> to load file "./UCI HAR Dataset/features.txt"

"activity_labels" -> to load file "./UCI HAR Dataset/activity_labels.txt"


# PART 1
# merge all in one big table
This is done in 2 steps:
- first step create a table binding columns from  "y_train", "x_train" and "subject_train"
- second step create a second table binding columns from "y_test", "x_test" and "subject_test"
- third step, bind rows from first table, and second table, and save the result on first table called "complete_dataset"

# PART 4
By using "features.txt" file, change column names in "complete_dataset".


# PART 2
By Using "features.txt" file loaded previosuly, and by using grep, search for "mean()" and "std()", and get the column IDs of matches.
With those column IDs, using plyr and dplyr, select columns and store all in a new data.frame called "dataset_mean_std"

dataset_mean_std -> dataset of means and standard deviations required by the Project instructions.


#PART 3
Instead of habing activity number, convert them into activity descriptions, as requested by the instructions.
In order to accomplish this, the content of "activity_labels.txt" was loaded into "activity_labels" variable.
And after that the names of "activity_labels" were changed in order to be able to make a "join" later.

With the join an extra column is created with the activity descriptions, and the next step was to delete the column wiht activity number.


# PART 5
Calculate the summarization and store it in a new data frame, with the average of each variable for each activity and each subject.

In order to accomplish this, "dataset_mean_std" was gruoped by activity description and subject, and then a summarization was done, calculating the mean for the remaining columns. The result was stored into "gropued_dataset_mean_std"


"gropued_dataset_mean_std"-> dataset with summarization of "dataset_mean_std" as required by the Project instructions.

# FINALLY
Both datasets were stored into .csv files in order to share the results of the assingment.

And all variables where cleaned out and working directory was set to its original value.


Thank you very much!




