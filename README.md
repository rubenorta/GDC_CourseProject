# Getting and Cleaning Data Course Project 

We only need a script to transform the data. The script is called run_analysis.R. This script execute the cleaning of the data in 5 steps:

- Read all necessary files
- Merge the data included in all the files
- Extract only the columns that include values for the mean and the standard deviation
- Add the subject and activity labels data
- Create a new dataset with the mean of all columns group by subject and activity

The script writes the resulting dataset to the file data_summary.txt.
All the data files are stored at the directory ./UCI HAR DatasetThe transformation is composed with 
