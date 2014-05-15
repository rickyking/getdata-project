# Project Assignment of getdata-003

## What is in the repo?
Due to heavy size of original data, the dataset is not included in the repo, but the code run_analysis.R contains the command to download the file.

In this repo, we have:

- run_analysis.R: The script does all the reading, merging, transforming and summarying to create a `tidy dataset` stated in the project requirement.
- codebook.md: the markdown file contains all the explanation and summary of the tidy dataset.
- tidyData.txt: is the `tidy dataseet` requested in the project requirement.
- README.md: this file.

## How does this work?
If you want to replicate the working, you could download the `run_analysis.R` in your local folders and run the script line by line. The script is commented in every step. It will:

- download the data .zip and unzip the file,
- read the text files (`X`, `y`, `subject`) from `/train` and `/test` directory,
- merge these files to construct a merged data frame,
- get the variable names from `features.txt` and extract `mean` and `standard deviation` variable,
- get the activity names and replace the original numerica format from `activity_labels.txt`,
- rename the variable names to a more understandable names, see `codebook.md` for details,
- take mean by aggregating on `subject` and `activity`,
- export the data to `tidyData.txt`,
- create a summary of variables by `Hmisc::describe` (optional).

## Project requirement

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 
1. a tidy data set as described below,
2. a link to a Github repository with your script for performing the analysis
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

You should create one R script called run_analysis.R that does the following. 

 - Merges the training and the test sets to create one data set. 
 - Extracts only the measurements on the mean and standard deviation for each measurement.
 - Uses descriptive activity names to name the activities in the data set 
 - Appropriately labels the data set with descriptive activity names.
 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

