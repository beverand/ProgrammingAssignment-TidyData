---
title: "Readme"
author: "Beverly Andrews"
date: "September 5, 2016"
output: html_document
---

The files for this project are as follows:
Readme.md : this document
codebook.Rmd: the detailed explaination of the code
tidy_project_code.r: the code for the project itself
Drawing1.jpg: the image for the codebook

*This data is tidy because there is one row per observation for each subject and each activity.*

The process for the analysis was to first install the tidyr and dplyr packages.
Then I downloaded the data and stored it on my local drive in 
"C:/Users/bever/Documents/R/Rscripts/CleaningData/UCI HAR Dataset"
There were 8 files and they are detailed in the codebook.
I read in all files and then manipulated them by adding headers and doing a first level combine on test and train separately. Next, I get indexes for all mean and standard devation columns and turn data frame into a header list that is later used in find the mean, standard devation and label columns to assign them as column names.

I combine test and training sets and them select those columns from the combined data set. The next step I took was to merge the selectedData with the activites data so that I have a column of named activities (WALKING, SITTING, etc.).

Removing the activity labels numeric column was minor, but makes for clean data because it reduces the redundancy.

The final tidy dataset consists of the means of all observational columns by subject and activity type. 
