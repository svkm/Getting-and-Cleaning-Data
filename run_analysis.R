# setwd() to directory containing extracted files
require(plyr)

# Read all files
activity_labels <- read.table("activity_labels.txt", as.is=TRUE)

activity_num_train <- read.table("train/y_train.txt", as.is=TRUE)
activity_num_test  <- read.table("test/y_test.txt", as.is=TRUE)

Xtrain <- read.table("train/X_train.txt",as.is=TRUE)
Xtest  <- read.table("test/X_test.txt", as.is=TRUE)

XSubjectTrain <- read.table("train//subject_train.txt", as.is=TRUE)
XSubjectTest  <- read.table("test//subject_test.txt", as.is=TRUE)

# Now read in the column labels from features.txt
#XColNames <- read.table("features.txt", as.is=TRUE)
features <- read.table("features.txt", as.is=TRUE)
# Git rid of (,),- and comma. Replace with .
# These are the "meaningful" col names. It wouldn't make sense to provide
# long names as they will be extremely long varibale names in programs

XColNames <- gsub("[-(),]", ".", features[,2])

# Convert activity numbers given in 
#       activity_num_train (y_train.txt) & 
#       activity_num_test (y_test.txt) to 
# activity names given in activity_labels
# activity_train and activity_test will contain activity names
# like WLAKING, SITTING, STNDING, etc
activity_train <- merge(activity_labels, activity_num_train)[,2]
activity_test  <- merge(activity_labels, activity_num_test)[,2]

# Add activity names and subject cols to train and test data
Xtrain <- cbind(Xtrain, XSubjectTrain, activity_train)
Xtest  <- cbind(Xtest, XSubjectTest,  activity_test) 

# Add provided col names to Xtrain and Xtest. 
# Also add Subject and activity col names at the end
# We will now have a merged data set.
# The col names are meaningful as they have been stripped off special characters
# not acceptable to R. Also, most publicly datasets appear to observe this convention

colnames(Xtrain) <- c(XColNames, "Subject", "Activity")
colnames(Xtest) <- c(XColNames, "Subject", "Activity")

# Next, we will merge the training and test sets per requirement 1
X <- rbind(Xtrain, Xtest)  # Training and Test data sets merged

# Note: X is also clean data. However, it contains all columns in the dataset

# XClean below will now be clean data with meaningful names 
# (just the measurements with mean and standard deviations)
XClean <- X[,c(1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 
               215, 227, 228, 240, 241, 253, 254, 266:271, 345:350, 
               424:429, 503, 504, 516, 517, 529, 530, 542, 543, 562, 563)] 
# Note we added two cols 562=Subject and 563=Activity Name at the end

# Uncomment next line if you want check out the above file
# write.csv(XClean, file="XClean.csv", row.names=FALSE)

# Step 5 - Create a second independent set ....
# We could use X (with all cols) or XClean. Since it is not clear which data set to use,
# I am using XClean - the cocenpt is the same

# Also dropping variables which has no values (.drop = FALSE is the default for ddply)
XCleanAvg <- ddply(XClean, .(Subject, Activity), colwise(mean))
Coursera does not like csv files!
#write.csv(XCleanAvg, file="XCleanAvg.csv", row.names=FALSE)
write.table(XCleanAvg, file="XCleanAvg.txt", row.names=FALSE)



