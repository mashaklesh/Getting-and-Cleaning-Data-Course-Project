# README

This describes the code run_analysis.R, which creates a tidy data set out of data obtained from 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

First, all data is loaded into R data frames. The test data are merged to create one data set using cbind; similarly for the train data set. Next, the test and the train data set is combined together to get just one data set containing all the data, in the data frame all_data. 

The column names are obtained from the text file 'features.txt', and assigned to the columns of all_data. 

In order to obtain only the columns with the means and standard deviations of the variables, the function grepl is used to select only the column names that contain 'mean()' or 'std()'. Thus the indices of the correct columns are obtained and are used to select appropriate data. 

Next, the mapvalues function from the dplyr package is used to reassign the activity names from 1,2,3, etc to 'walking', 'laying', etc. 

Finally, for each unique subject and each unique activity, the mean of each variable is obtained through a for loop. The mean of each variable is written to a new tidy data set, which is exported into the file "UCI_HaR_tidy.txt". 