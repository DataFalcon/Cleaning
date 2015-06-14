
#CodeBook.md

Reduced Data Set from:
Human Activity Recognition Using Smartphones Dataset (HAR)

The dataset produced by the script in this repository is a condensed form of the HAR data set from the UC Irvine Machine Learning Repository:

https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### The source of the original data is:

Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1. - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2. - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws
++++

More information on the original data set can be found in the UCI repository.  Here we just describe the variables in the reduced data set and how they relate to the original.

The script in this repository, run_analysis.R, produces the following text file with 14,220 observations on 4 variables (first 10 observations shown):

          subject           activity   featurevector meanvalue
       1        1             LAYING tBodyAcc_mean_X 0.2215982
       2        1            SITTING tBodyAcc_mean_X 0.2612376
       3        1           STANDING tBodyAcc_mean_X 0.2789176
       4        1            WALKING tBodyAcc_mean_X 0.2773308
       5        1 WALKING_DOWNSTAIRS tBodyAcc_mean_X 0.2891883
       6        1   WALKING_UPSTAIRS tBodyAcc_mean_X 0.2554617
       7        2             LAYING tBodyAcc_mean_X 0.2813734
       8        2            SITTING tBodyAcc_mean_X 0.2770874
       9        2           STANDING tBodyAcc_mean_X 0.2779115
       10       2            WALKING tBodyAcc_mean_X 0.2764266

A detailed account of how the original data was obtained is attached (Appendix 1) and details on how features were selected from the raw data is also attached (Appendix 2).

In brief there were 30 subjects in the study (numbered 1-30 in the "subject" column of the data file) and each was asked to perform 6 different activities (descriptor in the "activity" column) while wearing a cell phone.  Accelerometer measurements were taken on 3 axes.  These were used to obtain body acceleration and body rotation.  They were taken at a rate fast enough to also detect "jerk".  Each of these measurements produced a time series from which frequency data could be obtained through a fourier transform.  The variables (featurevector) thus take the form:

(t or f)(BodyAcc or BodyGyro)_(mean or std)_(X or Y or Z or Mag)

Where the first parentheses refer to time or frequency domain, the second set of parenthesis refer to either acceleration or rotation, the third prenthesis refers to whether it was the mean of the time series data or it's std deviation and X,Y,Z or Mag refer to the axis or absolute magnitude of the vector.

Thus "tBodyAcc_mean_X" is the mean for the X component of the time domain measurement of body acceleration.

As compared to the original data set, the featurevector names have been cleaned up to include only alpha characters and underscores but are otherwise unaltered ( ".", "()" and "," have been substituted).

The original data set has 813,621 observations on 561 variables and is divided arbitrarily into test and training subsets. (see Appendix for more details).

The reduced data set was obtained by combining test and training subsets and subsetting to only those variables that represented the mean and the standard deviation of time series and their fourier transforms (79 of the 561 original variables).  The data set was further reduced by taking the mean of all observations for a particular subject performing a particular task.  This is what is represented in the "meanvalue" column for each variable in the "featurevector" column.
  
Thus the triplet (subject, activity, featurevector) represents a unique row in the dataset.

The next page lists the complete set of feature vectors provided in the reduced data set (a total of 79 out of the 561 in the original data).














The complete (reduced) set of feature vectors is as follows:
<pre><code>
 [1] tBodyAcc_mean_X               	tBodyAcc_mean_Y              
 [3] tBodyAcc_mean_Z               	tBodyAcc_std_X               
 [5] tBodyAcc_std_Y                	tBodyAcc_std_Z               
 [7] tGravityAcc_mean_X            	tGravityAcc_mean_Y           
 [9] tGravityAcc_mean_Z            	tGravityAcc_std_X            
[11] tGravityAcc_std_Y             	tGravityAcc_std_Z            
[13] tBodyAccJerk_mean_X           	tBodyAccJerk_mean_Y          
[15] tBodyAccJerk_mean_Z           	tBodyAccJerk_std_X           
[17] tBodyAccJerk_std_Y            	tBodyAccJerk_std_Z           
[19] tBodyGyro_mean_X              	tBodyGyro_mean_Y             
[21] tBodyGyro_mean_Z              	tBodyGyro_std_X              
[23] tBodyGyro_std_Y               	tBodyGyro_std_Z              
[25] tBodyGyroJerk_mean_X          	tBodyGyroJerk_mean_Y         
[27] tBodyGyroJerk_mean_Z          	tBodyGyroJerk_std_X          
[29] tBodyGyroJerk_std_Y           	tBodyGyroJerk_std_Z          
[31] tBodyAccMag_mean              	tBodyAccMag_std              
[33] tGravityAccMag_mean           	tGravityAccMag_std           
[35] tBodyAccJerkMag_mean          	tBodyAccJerkMag_std          
[37] tBodyGyroMag_mean             	tBodyGyroMag_std             
[39] tBodyGyroJerkMag_mean         	tBodyGyroJerkMag_std         
[41] fBodyAcc_mean_X               	fBodyAcc_mean_Y              
[43] fBodyAcc_mean_Z               	fBodyAcc_std_X               
[45] fBodyAcc_std_Y                	fBodyAcc_std_Z               
[47] fBodyAcc_meanFreq_X           	fBodyAcc_meanFreq_Y          
[49] fBodyAcc_meanFreq_Z           	fBodyAccJerk_mean_X          
[51] fBodyAccJerk_mean_Y           	fBodyAccJerk_mean_Z          
[53] fBodyAccJerk_std_X            	fBodyAccJerk_std_Y           
[55] fBodyAccJerk_std_Z            	fBodyAccJerk_meanFreq_X      
[57] fBodyAccJerk_meanFreq_Y       	fBodyAccJerk_meanFreq_Z      
[59] fBodyGyro_mean_X              	fBodyGyro_mean_Y             
[61] fBodyGyro_mean_Z              	fBodyGyro_std_X              
[63] fBodyGyro_std_Y               	fBodyGyro_std_Z              
[65] fBodyGyro_meanFreq_X          	fBodyGyro_meanFreq_Y         
[67] fBodyGyro_meanFreq_Z          	fBodyAccMag_mean             
[69] fBodyAccMag_std               	fBodyAccMag_meanFreq         
[71] fBodyBodyAccJerkMag_mean      	fBodyBodyAccJerkMag_std      
[73] fBodyBodyAccJerkMag_meanFreq  	fBodyBodyGyroMag_mean        
[75] fBodyBodyGyroMag_std          	fBodyBodyGyroMag_meanFreq    
[77] fBodyBodyGyroJerkMag_mean     	fBodyBodyGyroJerkMag_std     
[79] fBodyBodyGyroJerkMag_meanFreq
</code></pre>











# Appendix 1
================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.








# Appendix 2 
(from the UCR Machine Learning Repository, see the acknowledgment at the beginning of this file).

## Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag


The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
