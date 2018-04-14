These are the comments associated with coding:

## there will be two working directory, one for train and one for test

## reading tables                

## changing working directory

##reading tables

## merging test and taining files
## summary(total_x)
## str(total_x)

## changing working directoty one more time

## creating column names using given variables
## formating as character

## creating one column object
## assigning column names

## removing columns that do not have 'mean' or 'std'
## !!! I assume that measuremnets containing 'Mean Frequency' should be excluded



## assigning activity types


## applying activity names to the shorted table

## incorporating subject's info

##c reating tidy data set






Variables:

Reading tables variables                

traindatax<-read.table("X_train.txt")
traindatay<-read.table("y_train.txt")
subject_train<-read.table("subject_train.txt")
testdatax<-read.table("X_test.txt")
testdatay<-read.table("y_test.txt")
subject_test<-read.table("subject_test.txt")
columnnames<-read.table("features.txt")
labels<-read.table("activity_labels.txt")


Merging and Formating Data 

total_x<-rbind(traindatax,testdatax)
tidy_data<-cbind(total_subject,apply_name_activitities)
tidy_data_agg4<-aggregate(tidy_data[6:71], by = list(tidy_data$Subject,tidy_data$Activity),FUN = mean)
tidy_data_final<-data.frame(tidy_data_agg4$Activity,tidy_data_agg4$Subject,tidy_data_agg4[,3:68])
colnames(total_x)<-activity
shorttable1<-total_x[ , !grepl( "meanF", names(total_x) ) ] 
shorttable2<-shorttable1[ , grepl( "mean|std", names(shorttable1) ) ] 
total_y<-rbind(traindatay,testdatay)
total_y$id<-1:nrow(total_y)
name_activities<-merge(total_y,labels, by = "V1", sort = FALSE)
ordered <- name_activities[order(name_activities$id), ]
apply_name_activitities<-cbind(name_activities, shorttable2)
total_subject<-rbind(subject_train,subject_test)
total_subject$id<-1:nrow(total_subject)
columnnames$V2<-as.character(columnnames$V2)
activity<-columnnames$V2
