# 1.Merges the training and the test sets to create one data set.
       #(1)import column names, training dataset, testdata set to 
        #  subject to different datasets in R
columns <- read.table('./UCI HAR Dataset/features.txt', header=FALSE)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")



View





?read.table

my_data <- read.delim('./UCI HAR Dataset/train/X_train.txt')

View(my_data)

#test
columns <- read.table('./UCI HAR Dataset/features.txt', header=FALSE)
View(features)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
View(x_train)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
View(y_train)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
View(subject_train)
unique(subject_train)
