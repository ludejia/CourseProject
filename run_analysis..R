# 1.Merges the training and the test sets to create one data set.
       #(1)import column names, training dataset, testdata set and 
        #  subject to different datasets in R
columns <- read.table('./UCI HAR Dataset/features.txt')
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        #add column names
names(x_train) = columns$V2
names(x_test) = columns$V2
        #add an train dataset identifier column and reorder the columns
x_train$datatype="train"
x_train = x_train[,c(562,1:561)]
        #combine y_train, subject_train, x_train by column to a dataframe
        # and rename the columns
tidydata = cbind(y_train,subject_train, x_train)
names(tidydata)[1:2]= c('y','subject')
        #add an test dataset identifier column and reorder the columns
x_test$datatype="test"
x_test = x_test[,c(562,1:561)]
        #combine y_test, subject_test, x_test by column to a dataframe
        # and rename the columns
tidydata2 = cbind(y_test,subject_test, x_test)
names(tidydata2)[1:2]= c('y','subject')
        #combine tidydata and tidydata2 to a new tidydata
tidydata = rbind(tidydata,tidydata2)

# 2. Extracts only the measurements on the mean and standard deviation for each 
# measurement.

tidydata = tidydata[,c(1,2,grep('.mean.|.std.',names(tidydata), ignore.case = T))]

# 3. Uses descriptive activity names to name the activities in the data set
        #get the activity label dataset
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
        # creat a new column called acivity by looking up the activity name 
        # move activity column right beside y column
tidydata$activity = activity[match(tidydata$y,activity$V1),2]
tidydata = tidydata[,c(1,89,2:88)]




tidydata$activity

tidy$activity =activity[test$y,2]
test$activity


a = data.frame(x=c('a','b','c'), y=c(4,5,8))
b = data.frame(x=c('c','b','c','a','c','c'))
b$y = a[match(b$x,a$x),2]
b

x <- c("apple", "banana", "pear")
grep('.Pl.|.ea.',x,ignore.case = T )
?grep


?grep
remove(test)

test= c('A', 'b a d','c','a','d')
grep('A|c',test, ignore.case = T)


names(tidydata)

?contains






unique(tidydata$subject)




        
names(tidydata)[1:2]


remove(Variables)
View(x_train)
View(columns2)
columns2 <- read.table('./UCI HAR Dataset/features.txt',header = F)





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
