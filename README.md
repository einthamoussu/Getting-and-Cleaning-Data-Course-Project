# Getting-and-Cleaning-Data-Course-Project

This project is about getting 2 tidy datasets by using a R script. The source information is : "The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone". As stated in the text of the project.

A R script called "run_analysis.R" was created and this is what the script does:


1   - load in R the datasets
2   - merge the datasets including subject data, and activity data
3   - set column names of merged datasets
4   - create required sub dataset of means and standard deviations
5   - for this last dataset, change activity numbers and mutate them to activity descriptions
6   - create a third dataset, wiht requierd summarization
7   - export to .txt the grouped datasets required in part 5 of project
8   - delete all variables


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