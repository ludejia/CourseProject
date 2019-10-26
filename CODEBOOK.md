# 1.Variable Explanation:

***

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.


- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

#### Feature Selection

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

+ tBodyAcc-XYZ
+ tGravityAcc-XYZ
+ tBodyAccJerk-XYZ
+ tBodyGyro-XYZ
+ tBodyGyroJerk-XYZ
+ tBodyAccMag
+ tGravityAccMag
+ tBodyAccJerkMag
+ tBodyGyroMag
+ tBodyGyroJerkMag
+ fBodyAcc-XYZ
+ fBodyAccJerk-XYZ
+ fBodyGyro-XYZ
+ fBodyAccMag
+ fBodyAccJerkMag
+ fBodyGyroMag
+ fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

+ mean(): Mean value
+ std(): Standard deviation
+ mad(): Median absolute deviation 
+ max(): Largest value in array
+ min(): Smallest value in array
+ sma(): Signal magnitude area
+ energy(): Energy measure. Sum of the squares divided by the number of values. 
+ iqr(): Interquartile range 
+ entropy(): Signal entropy
+ arCoeff(): Autorregresion coefficients with Burg order equal to 4
+ correlation(): correlation coefficient between two signals
+ maxInds(): index of the frequency component with largest magnitude
+ meanFreq(): Weighted average of the frequency components to obtain a mean frequency
+ skewness(): skewness of the frequency domain signal 
+ kurtosis(): kurtosis of the frequency domain signal 
+ bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
+ angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

+ gravityMean
+ tBodyAccMean
+ tBodyAccJerkMean
+ tBodyGyroMean
+ tBodyGyroJerkMean

# 2.Data Cleaning and Analysis Code

***

### 1.Merges the training and the test sets to create one data set.
###   (1) Import column names, training dataset, testdata set and subject to different datasets in R

columns <- read.table('./UCI HAR Dataset/features.txt')

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

####  add column names

names(x_train) = columns$V2

names(x_test) = columns$V2

#### add a training dataset identifier column and re-order the columns

x_train$datatype="train"

x_train = x_train[,c(562,1:561)]

#### combine y_train, subject_train, x_train by column to a dataframe and rename the columns

tidydata = cbind(y_train,subject_train, x_train)

names(tidydata)[1:2]= c('y','subject')

#### add an test dataset identifier column and reorder the columns

x_test$datatype="test"

x_test = x_test[,c(562,1:561)]

#### combine y_test, subject_test, x_test by column to a dataframe called tidydata2 and rename the columns

tidydata2 = cbind(y_test,subject_test, x_test)

names(tidydata2)[1:2]= c('y','subject')

#### combine tidydata and tidydata2 to a new tidydata

tidydata = rbind(tidydata,tidydata2)


### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

tidydata = tidydata[,c(1,2,grep('.mean.|.std.',names(tidydata), ignore.case = T))]

### 3. Uses descriptive activity names to name the activities in the data set get the activity label dataset

activity <- read.table("UCI HAR Dataset/activity_labels.txt")

#### creat a new column called acivity by looking up the activity number move activity column right beside y column

tidydata$activity = activity[match(tidydata$y,activity$V1),2]

tidydata = tidydata[,c(1,89,2:88)]


### 4.Appropriately labels the data set with descriptive variable names 

#### replace 't' with 'Time' ; replace 'f' with Frequency, remove'()'

names(tidydata)= gsub('^t','Time',names(tidydata))

names(tidydata)= gsub('^f','Frequency',names(tidydata))

names(tidydata)= gsub('[()]','',names(tidydata))

### 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

groupmean = tidydata %>%
        group_by(subject, activity) %>%
        summarise_all(mean)
        
#### export the data to a file

write.table(groupmean, "Data.txt", row.name=FALSE)



