# Getting-and-Cleaning-Data-Course-Project

This project is about getting 2 tidy datasets by using a R script. The source information is : "The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone". As stated in the text of the project.

A R script called "run_analysis.R" was created and this is what the script does:

1   - create folder for data
2   - download zip file
3   - unzip files
4   - load in R the datasets
5   - merge the datasets including subject data, and activity data
6   - set column names of merged datasets
7   - create required sub dataset of means and standard deviations
8   - for this last dataset, change activity numbers and mutate them to activity descriptions
9   - create a third dataset, wiht requierd summarization
10   - export to .csv the second and third datasets
11   - delete all variables
12   - set original folder as default folder