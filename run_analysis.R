if(!require("dplyr")) install.packages("dplyr")
library("dplyr")
if(!require("labelled")) install.packages("labelled")
library("labelled")
if(!require("maditr")) install.packages("maditr")
library("maditr")

#1 Reading in the data and labels, putting x and y data together
FeatureLabels=fread("features.txt",header=FALSE)

ActivityLabels=fread("activity_labels.txt",header=FALSE,col.names=c("ActivityId","ActivityTxt"))
SubjectTest=fread("test/subject_test.txt",header=FALSE,col.names="Subject")
SubjectTrain=fread("train/subject_train.txt",header=FALSE,col.names="Subject")

xTest=fread("test/X_test.txt",header=FALSE,col.names=FeatureLabels$V2)
xTrain=fread("train/X_train.txt",header=FALSE,col.names=FeatureLabels$V2)

yTest=fread("test/y_test.txt",header=FALSE,col.names="ActivityId")
yTrain=fread("train/y_train.txt",header=FALSE,col.names="ActivityId")

#4 Appropriately labels the data set with descriptive variable names. 
sss=(as.character(t(FeatureLabels$V2)))
var_label(xTrain)=sss
var_label(xTest)=sss

#Add Subject
xTest$Subject=SubjectTest$Subject
xTrain$Subject=SubjectTrain$Subject



#3 descriptive activity names to name the activities in the data set
xTest$ActivityId=yTest$ActivityId
xTrain$ActivityId=yTrain$ActivityId
xTrain$ActivityTxt = ActivityLabels$ActivityTxt[match(xTrain$ActivityId,ActivityLabels$ActivityId)]
xTest$ActivityTxt = ActivityLabels$ActivityTxt[match(xTest$ActivityId,ActivityLabels$ActivityId)]

#Identification of the data origin - not needed in the final output
xTrain$Class = "Train"
xTest$Class = "Test"

#1 Merges the 2 data sets without ActivityId
totalData=rbind(xTrain[,-563],xTest[,-563])


#2 - filter out std and mean metrics
std_mean_Labels=rbind(filter(FeatureLabels,grepl("std[\\(\\)][\\)\\)]",V2)),filter(FeatureLabels,grepl("mean[\\(\\)][\\)\\)]",V2)))
TotalswithMeanStd=totalData %>% select(std_mean_Labels$V1)
nMetrics=ncol(totalData)-3
nnewMetrics=ncol(TotalswithMeanStd)
TotalswithMeanStd=cbind(TotalswithMeanStd,totalData[,(nMetrics+1):(nMetrics+3)])

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
metricsIds=colnames(TotalswithMeanStd)[1:(ncol(TotalswithMeanStd)-3)]
MeanStats=dcast(TotalswithMeanStd,ActivityTxt+Subject ~ .,value.var=metricsIds,fun.aggregate=mean)

# Write main outputs to CSV on disk
check = tryCatch({
    fwrite(MeanStats,file="MeanStats_5.txt")
}, warning = function(w){
    print("fwrite failed (Warning)")
}, error = function(e){
    print("fwrite failed (error)")
}, finally = function(f){
    
})

