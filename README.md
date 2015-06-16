

The script file "run_analysis.R" provided in this repo takes the "Human Activity Recognition Using Smartphones" Data Set and reduces it to include only mean values of key feature vectors.  The means are taken over subject (one of 30 volunteers ages 19-48), and activity (one of six simple activities: walking, walking upstairs, walking downstairs, sitting, standing or lying down (called "laying" in the data set).

## Description of the starting data

Data in the original training data set "X_test.txt" is stripped of column names and associations with subject and activity.  Column names are included in one data file "features.txt".  Subjects are included in a second text file "subject_test.txt" and activities are included in a third file "y_test.txt". "y_test.txt" includes only numeric codes for the activities which can then be decoded with "activity_labels.txt" 

The three column files "X_test", "subject_test" and "y_test" each has a counterpart in the training data set: "X_train", "subject_train" and "y_train".

Note that test and training data sets are of different length.

## Description of the R script

The script does the following to the 6 column files and column name file:

1. Clean up the "features.txt" names to remove special characters such as "()", "." and "," and replace them with underscores, "_"

2. Create data frames of train (Xtraindf) and test (Xtestdf) data with the clean column names ("features.txt") restored to each.

3. Bind (cbind) the corresponding subject and activity columns to the test and train data frames.

4. Bind (rbind) the two data frames into a single data frame with all of the data (Xalldf)

5. Find all columns that refer to a mean or a standard deviation (std) using grep.

6. Use the subset of columns along with subject and activity to select to a reduced data frame that includes only these columns (Xmeanstd).

7. Replace the numeric code for the activity with the activity descriptor from the "activity_labels.txt" file in the data directory.

8. Use the "melt" function in R to create a vertical table where all feature vector columns are combined into a single column of data and a second column of feature vector names.

9. Use the "dcast" function in R to average (using mean) the data values over subject and activity producing a vertical data frame called "ActSubjAvg" with 30*6 = 180 rows for each featurevector.

10. Parse the featurevector column into its 4 constituent variables and cbind the new columns "domain", "rootVector", "axis" and "moment" to the ActSubjAvg data frame.

11. Select the columns in the final order (leaving out the old featurevector) and write the resulting data frame (SmartPhonedf) to a txt file: SmartPhone2.txt

More detailed documentation is provided in the R script.