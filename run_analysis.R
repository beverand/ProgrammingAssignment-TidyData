#install.packages("tidyr")
#install.packages("dplyr")

#Data has been downloaded and is stored on local drive in folders named
test_file <- "UCI HAR Dataset/test/X_test.txt"
train_file <- "UCI HAR Dataset/train/X_train.txt"
h_file <- "UCI HAR Dataset/features.txt"
activity_lbl <- "UCI HAR Dataset/activity_labels.txt"


ytest_file <- "UCI HAR Dataset/test/y_test.txt"
ytrain_file <- "UCI HAR Dataset/train/y_train.txt"

subject_test_file <- "UCI HAR Dataset/test/subject_test.txt"
subject_train_file <- "UCI HAR Dataset/train/subject_train.txt"


#read in all files
trainX<- fread(train_file, header=FALSE)
testX<-fread(test_file, header = FALSE)
trainy<- fread(ytrain_file, header=FALSE)
testy<-fread(ytest_file, header = FALSE)
activities <-fread(activity_lbl,header=FALSE, stringsAsFactors = TRUE)
subj_train <- fread(subject_train_file, header = FALSE,colClasses = 'character', stringsAsFactors = TRUE)
subj_test<- fread(subject_test_file, header = FALSE,colClasses = 'character', stringsAsFactors = TRUE)
headers<-fread(h_file)

#manipulate files by adding headers and doing a first level combine on test and train
headers<-rbind(headers, list(562, "activityLabels"))
headers<-rbind(headers, list(563, "subjectLabels"))

colnames(testy)<- "activityLabels"
colnames(trainy)<- "activityLabels"
colnames(activities)<-c("activityLabels", "activity")
colnames(subj_test)<- "subjectLabels"
colnames(subj_train)<- "subjectLabels"
testX <-cbind(testX, testy, subj_test)
trainX <-cbind(trainX, trainy, subj_train)

#get indexes for all mean and standard devation columns
selectedCols <-which(headers[, grepl("mean|std|Labels", headers$V2)], arr.ind = TRUE)

#turn data frame into header list
h<-unlist(select(headers, V2), use.names = FALSE)

#use find the mean, standard devation and label columns then assign them as colname 
h<-subset(h, h %in% grep("mean|std|Labels", h, value = TRUE))

#combine test and training sets
combined<-rbind(testX,trainX)


#select those columns from the combined data set
selectedData<-select(combined, selectedCols)
colnames(selectedData) <- h
#merge(selectedData, activities)


selectedData_final <- merge(selectedData, activities, by.x="activityLabels", by.y="activityLabels")
#remove the activity labels numeric column 
selectedData_final[,activityLabels:=NULL]

#final summary
out_final <-selectedData_final[, lapply(.SD, mean, na.rm=TRUE), by=c('subjectLabels',"activity") ]
write.table(out_final, file = "C:/Users/bever/Documents/R/Rscripts/CleaningData/UCI HAR Dataset/tidyData.txt", sep = ",", row.name=FALSE)