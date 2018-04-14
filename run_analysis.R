## there will be two working directory, one for train and one for test
setwd("~/R/Data Cleaning Project/UCI HAR Dataset/train")

##reading tables                
traindatax<-read.table("X_train.txt")
traindatay<-read.table("y_train.txt")
subject_train<-read.table("subject_train.txt")


# changing working directory
setwd("~/R/Data Cleaning Project/UCI HAR Dataset/test")

##reading tables
testdatax<-read.table("X_test.txt")
testdatay<-read.table("y_test.txt")
subject_test<-read.table("subject_test.txt")

# merging test and taining files
total_x<-rbind(traindatax,testdatax)
##summary(total_x)
##str(total_x)

## changing working directoty one more time
setwd("~/R/Data Cleaning Project/UCI HAR Dataset")

##creating column names using given variables
columnnames<-read.table("features.txt")
#formating as character
columnnames$V2<-as.character(columnnames$V2)

##creating one column object
activity<-columnnames$V2
## assigning column names
colnames(total_x)<-activity

## removing columns that do not have 'mean' or 'std'
## !!! I assume that measuremnets containing 'Mean Frequency' should be excluded
shorttable1<-total_x[ , !grepl( "meanF", names(total_x) ) ] 
shorttable2<-shorttable1[ , grepl( "mean|std", names(shorttable1) ) ] 



##assigning activity types
total_y<-rbind(traindatay,testdatay)
total_y$id<-1:nrow(total_y)

setwd("~/R/Data Cleaning Project/UCI HAR Dataset")
labels<-read.table("activity_labels.txt")
name_activities<-merge(total_y,labels, by = "V1", sort = FALSE)
ordered <- name_activities[order(name_activities$id), ]

##applying activity names to the shorted table
apply_name_activitities<-cbind(name_activities, shorttable2)

##incorporating subject's info
total_subject<-rbind(subject_train,subject_test)
total_subject$id<-1:nrow(total_subject)

##creating tidy data set
tidy_data<-cbind(total_subject,apply_name_activitities)
names(tidy_data)[1]<-"Subject"
names(tidy_data)[3]<-"Ac-ty Code"
names(tidy_data)[5]<-"Activity"

tidy_data[1:50,1:8]

tidy_data_agg4<-aggregate(tidy_data[6:71], by = list(tidy_data$Subject,tidy_data$Activity),FUN = mean)
names(tidy_data_agg4)[1]<-"Subject"
names(tidy_data_agg4)[2]<-"Activity"
tidy_data_agg4[1:50,1:5]

tidy_data_final<-data.frame(tidy_data_agg4$Activity,tidy_data_agg4$Subject,tidy_data_agg4[,3:68])
names(tidy_data_final)[1]<-"Activity"
names(tidy_data_final)[2]<-"Subject"
tidy_data_final[1:35,1:4]
write.csv(tidy_data_final,"tidy_data.csv")
write.table(tidy_data_final,"tidy_data.txt",row.names = FALSE)
