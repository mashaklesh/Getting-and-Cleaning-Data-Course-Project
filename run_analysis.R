library("data.table")
activity_test <- read.table("test/Y_test.txt")
time_and_freq_test <- read.table("test/X_test.txt")
subject_test <- read.table("test/subject_test.txt")

test_data <- cbind(subject_test, activity_test, time_and_freq_test)

activity_train <- read.table("train/Y_train.txt")
time_and_freq_train <- read.table("train/X_train.txt")
subject_train <- read.table("train/subject_train.txt")

train_data <- cbind(subject_train, activity_train, time_and_freq_train)

all_data <- rbind(test_data, train_data)

features <- read.table('features.txt')
names(all_data) <- c('subject', 'activity', as.character(features[,2]))

mean_std_col_names <- names(all_data[1:2])
for(name in names(all_data)) {
        if(grepl('mean()', name, fixed=T) == T) {
                mean_std_col_names <- c(mean_std_col_names, name)
        } else if(grepl('std()', name, fixed=T) == T) {
                mean_std_col_names <- c(mean_std_col_names, name)
        }
}

index_mean_std_col_names <- match(mean_std_col_names, names(all_data))

mean_std_data <- all_data[,index_mean_std_col_names]

library(plyr)

mean_std_data$activity <- mapvalues(mean_std_data$activity, c(1,2,3,4,5,6), c('WALKING',
                'WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING'))

library(dplyr)
mean_each_var_data <- c()
for(subject in unique(mean_std_data$subject)) {
        for(activity in unique(mean_std_data$activity)) {
                data_small <- filter(mean_std_data, mean_std_data$subject == subject &
                                                      mean_std_data$activity == activity)
                col_means <- colMeans(data_small[,3:68])
                mean_each_var_data <- rbind(mean_each_var_data, c(subject, 
                                                        activity, as.vector(col_means)))
        }
}

mean_each_var_data <- as.data.frame(mean_each_var_data)
names(mean_each_var_data) <- as.vector(names(mean_std_data))

write.table(mean_each_var_data, file="UCI_HAR_tidy.txt", row.name=F)



