library(plyr)
library(dplyr)

setwd('/home/ruben/coursera_ds/GeetingCleaningData/UCI HAR Dataset')

# Read data column names
col_names <- read.table('features.txt', sep = "")

# Read activity names
activity_labels <- read.table('activity_labels.txt',sep="")

# Read Subject data
subject_test = read.table('test/subject_test.txt')
subject_train = read.table('train/subject_train.txt')

# Read data
x_test <- read.table('test/X_test.txt',sep = "")
y_test <- read.table('test/y_test.txt', sep = "")
x_train <- read.table('train/X_train.txt',sep = "")
y_train <- read.table('train/y_train.txt', sep = "")

# Mergin datasets
names(x_test) <- col_names$V2
test_data <- cbind(y_test, x_test)
names(x_train) <- col_names$V2
train_data <- cbind(y_train, x_train)
data <- rbind(test_data, train_data)

# Extract only columns for mean and std deviation
cols_to_keep <- grep("mean\\(|std\\(", names(data))
cols_to_keep <- c(1, cols_to_keep)
mean_and_std <- data[,cols_to_keep]

# Add Activity label
tidy_data <- join(activity_labels, mean_and_std, 'V1')
tidy_data <- tidy_data[-1]
tidy_data <- rename(tidy_data, Activity = V2)

# Merge Subject Info
subject_data = rbind(subject_test,subject_train)
tidy_data = cbind(subject_data,tidy_data)
tidy_data <- rename(tidy_data, Subject = V1)

# Create new tidy data frame
splited <- group_by(tidy_data,Subject,Activity)
data_summary <- summarise_each(splited,funs(mean))

write.table(data_summary,file="../data_summary.txt",row.names=FALSE)
