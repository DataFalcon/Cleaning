# Run_analysis

library(dplyr)

# First some more intuitive ways to see the URL's where the various files are read from
dataURL <- "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset"
trainURL <- paste(dataURL, "train", sep = "/")
testURL <- paste(dataURL, "test", sep = "/")

# In the testURL there are 3 files of interest, the first is the data,
# and the third is the activity.  The same is true of trainURL
TestFile <- c("X_test.txt", "subject_test.txt", "y_test.txt")
TrainFile <- c("X_train.txt", "subject_train.txt", "y_train.txt")

# The features are in a file of the same name in the main directory dataURL
Features <- "features.txt"

# The names from features will eventually become our column names after some cleanup
ColNames <- read.table(paste(dataURL, Features, sep = "/"))

# ColNames needs to be cleaned up even before first used because of reserved characters
# gsub will not work on the () without the \\ literal symbol in the quotes
# the cleaned up column names have no more parentheses and substitue underscore for dash
# I prefer this multi-line view so any single substitution can be seen and changed quickly
ColNames[,2] <- gsub("-","_", ColNames[,2])
ColNames[,2] <- gsub("\\()", "", ColNames[,2])
ColNames[,2] <- gsub("\\(", "_", ColNames[,2])
ColNames[,2] <- gsub("\\)", "_", ColNames[,2])
ColNames[,2] <- gsub("\\.", "_", ColNames[,2])
ColNames[,2] <- gsub("\\,", "_", ColNames[,2])

# First we read the data into two separate data frames (Xtest and Xtrain)
# We must add the column names at this point because we will be adding columns and the dimensions will no longer match
# before we combine test and train we must add the subject and activity columns to each

Xtestdf <- read.table(paste(testURL, TestFile[1], sep = "/"), col.names = ColNames[,2])
subjectTest <- read.table(paste(testURL, TestFile[2], sep = "/"))
activityTest <- read.table(paste(testURL, TestFile[3], sep = "/"))

# Here's where we add the subject and activity columns 
# We also need to add an "index" column to maintain the original order and so that test and train combine without confusion
# (at this point, activity is a number later we'll change it to the descriptive name)
lentest <- (dim(subjectTest))[1]
index <- c(1:lentest)
Xtestdf <- cbind(index, subjectTest, activityTest, Xtestdf)



# Do the same as above for the training data
Xtraindf <- read.table(paste(trainURL, TrainFile[1], sep = "/"), col.names = ColNames[,2])
subjectTrain <- read.table(paste(trainURL, TrainFile[2], sep = "/"))
activityTrain <- read.table(paste(trainURL, TrainFile[3], sep = "/"))

lentrain <- (dim(subjectTrain))[1]
index <- c((lentest + 1):(lentest + lentrain))
Xtraindf <- cbind(index, subjectTrain, activityTrain, Xtraindf)


# Now we're ready to combine the two data frames, row.names needed to be unique
Xalldf <- rbind(Xtestdf, Xtraindf)

# A little bookkeeping for column names
names(Xalldf)[2] <- "subject"
names(Xalldf)[3] <- "activity"

# The final combined dataframe has all test and training data plus subject, activity and an index of original order
# This dataframe has 10,299 observations on 564 variables
# **********  This is the result requested in point 1 ***************************

# Now we need to extract a subset of the columns... the ones that refer to mean or std
# using table(grepl(...)) we find that there are 46 instances of "mean" and 33 instances of "std"

cmean <- grep("mean", names(Xalldf))
cstd <- grep("std", names(Xalldf))
rcol <- sort(c(cmean, cstd))
Xmeanstd <- select(Xalldf, index, subject, activity, rcol)

# Xmeanstd is our new reduced data frame with columns reordered and including only data columns with "mean" or "std"
# *************** This is the result requested in point 2 *************************

# Now we need to convert the activity column from numbers to descriptions
# The translation from number to activity is found in the "activity_labels.txt" data file
activities <- read.table(paste(dataURL, "activity_labels.txt", sep = "/"))

# The following is a manual "sub" function made with a for loop,  
# ("sub" doesn't work very well in this case, I'm very disappoited in it because it does a very simple thing and can't really do it right!)
# The for loop looks at the character in the activity column and replaces it with the corresponding
# activity in the "activities" look up table
lenall <- dim(Xmeanstd)[1]
for(i in 1:lenall){
    num <- as.integer(Xmeanstd$activity[i])
    replacement <- as.character(activities[num,2])
    Xmeanstd$activity[i] <- replacement
}
        
# ***************  The simple code above satisfies point 3 *****************************  
# We have replaced a numeric code with the corresponding descriptor using the table below
# > activities
# V1                 V2
# 1  1            WALKING
# 2  2   WALKING_UPSTAIRS
# 3  3 WALKING_DOWNSTAIRS
# 4  4            SITTING
# 5  5           STANDING
# 6  6             LAYING


# Now use the melt function to make Xmeanstd from a wide into a long skinny data frame

varnames <- names(Xmeanstd)

# All of the variables are "measure" variables except the first 3 (index, subject, activity)

measureVars <- varnames[4:length(varnames)]

library(reshape2)
Xmelt <- melt(Xmeanstd, id=c("index", "subject", "activity"), measure.vars = measureVars)

# the originators of the data called these "feature vectors" and so there is no good reason to depart from this
names(Xmelt)[4] <- "featurevector"

# Here's the first 10 rows (and ALL columns) of the tidy data set
# Note that the variable names are now in a column of their own and the measured data is in a single column
# Althought this data frame looks more compact it has 813,261 observations of 5 variables (so holds the same amount of
# data in a  much, much longer file)

#      index subject activity   featurevector     value
#   1      1       2 STANDING tBodyAcc_mean_X 0.2571778
#   2      2       2 STANDING tBodyAcc_mean_X 0.2860267
#   3      3       2 STANDING tBodyAcc_mean_X 0.2754848
#   4      4       2 STANDING tBodyAcc_mean_X 0.2702982
#   5      5       2 STANDING tBodyAcc_mean_X 0.2748330
#   6      6       2 STANDING tBodyAcc_mean_X 0.2792199
#   7      7       2 STANDING tBodyAcc_mean_X 0.2797459
#   8      8       2 STANDING tBodyAcc_mean_X 0.2746005
#   9      9       2 STANDING tBodyAcc_mean_X 0.2725287
#   10    10       2 STANDING tBodyAcc_mean_X 0.2757457

# The variable names were cleaned up by replacing () , and periods with underscore "_"
# ************************  This satisfies point 4 of the assignment ***********************************************


# For the final piece it is convenient to use the dcast function

BothMean <- dcast(Xmelt, subject + activity ~ featurevector, mean)

# This makes a wide data frame but gives an average for each subject and each activity 30*6
# We should again use melt to make it long and skinny and put all variables in a column and have values in only one column

ActSubjAvg <- melt(BothMean, id=c("subject", "activity"), measure.vars = measureVars)

# because we know the value column represents an average (mean) we can make the name more descriptive (less misleading)
# also the originators of the data called these "feature vectors" and so there is no good reason to depart from this

names(ActSubjAvg)[4] <- "meanvalue"
names(ActSubjAvg)[3] <- "featurevector"


# The first few lines of this data frame look very similar to the previous one, however the size has been reduced from 813,621 rows
# to only 14,220 rows because of averaging.  It is essential that the value column be labled differently from the data frame in 4
# to reflect this additional processing
#> head(ActSubjAvg, 10)
#          subject           activity   featurevector meanvalue
#       1        1             LAYING tBodyAcc_mean_X 0.2215982
#       2        1            SITTING tBodyAcc_mean_X 0.2612376
#       3        1           STANDING tBodyAcc_mean_X 0.2789176
#       4        1            WALKING tBodyAcc_mean_X 0.2773308
#       5        1 WALKING_DOWNSTAIRS tBodyAcc_mean_X 0.2891883
#       6        1   WALKING_UPSTAIRS tBodyAcc_mean_X 0.2554617
#       7        2             LAYING tBodyAcc_mean_X 0.2813734
#       8        2            SITTING tBodyAcc_mean_X 0.2770874
#       9        2           STANDING tBodyAcc_mean_X 0.2779115
#       10       2            WALKING tBodyAcc_mean_X 0.2764266


# Notice however that this data frame does NOT meet the requirements of tidy data
# the featurevector column has 4 variables in it, not just one
# these variables are: domain(t or f, time or frequency), moment(mean or std), axis(X,Y,Z or MAG)
# and the root measurement (e.g. "BodyAcc")

# we now need to parse this inot its constituent variables

domain <- as.character(ActSubjAvg$featurevector)
len <- length(domain)
for(i in 1:len){
    if(grepl("^t", domain[i])){
        domain[i] <- "time"
    }
    else if(grepl("^f", domain[i])){
        domain[i] <- "frequency"
    }
    else {domain[i] <- "NA"}
}

axis <- as.character(ActSubjAvg$featurevector)
len <- length(axis)
for(i in 1:len){
    if(grepl("_X", axis[i])){
        axis[i] <- "x"
    }
    else if(grepl("_Y", axis[i])){
        axis[i] <- "y"
    }
    else if(grepl("_Z", axis[i])){
        axis[i] <- "z"
    }
    else if(grepl("Mag_", axis[i])){
        axis[i] <- "mag"
    }
    else {axis[i] <- "NA"}
}

moment <- as.character(ActSubjAvg$featurevector)
len <- length(moment)
for(i in 1:len){
    if(grepl("_meanFreq", moment[i])){
        moment[i] <- "meanfreq"
    }
    else if(grepl("_mean", moment[i])){
        moment[i] <- "mean"
    }
    else if(grepl("_std", moment[i])){
        moment[i] <- "std"
    }
    else {momentis[i] <- "NA"}
}

rootVar <- c("BodyGyro", "BodyAcc", "GravityAcc",  "BodyGyroJerk", "BodyAccJerk" )

rootVector <- as.character(ActSubjAvg$featurevector)
len <- length(rootVector)
for(i in 1:len){
    foundmatch <- FALSE
    for(j in 1:5){
        if(grepl(rootVar[j], ActSubjAvg$featurevector[i])){
            rootVector[i] <- rootVar[j]
            foundmatch <- TRUE
        }
        if(!foundmatch){rootVector[i] <- "NA"}
    }
}


SmartPhonedf <- cbind(ActSubjAvg, domain, axis, moment, rootVector)
SmartPhonedf <- select(SmartPhonedf, subject, activity, domain, rootVector, axis, moment, meanvalue)

writeURL <- "getdata-projectfiles-UCI HAR Dataset/SmartPhone2.txt"
write.table(SmartPhonedf, file = writeURL, row.name = FALSE, append = FALSE, eol = "\r\n")

# Now the data frame looks like this:
#   subject           activity domain rootVector axis moment meanvalue
#1        1             LAYING   time    BodyAcc    x   mean 0.2215982
#2        1            SITTING   time    BodyAcc    x   mean 0.2612376
#3        1           STANDING   time    BodyAcc    x   mean 0.2789176
#4        1            WALKING   time    BodyAcc    x   mean 0.2773308
#5        1 WALKING_DOWNSTAIRS   time    BodyAcc    x   mean 0.2891883
#6        1   WALKING_UPSTAIRS   time    BodyAcc    x   mean 0.2554617
#7        2             LAYING   time    BodyAcc    x   mean 0.2813734
#8        2            SITTING   time    BodyAcc    x   mean 0.2770874
#9        2           STANDING   time    BodyAcc    x   mean 0.2779115
#10       2            WALKING   time    BodyAcc    x   mean 0.2764266

# ************************  This satisfies point 5 of the assignment ***********************************************