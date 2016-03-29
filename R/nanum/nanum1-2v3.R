library(dplyr)

csvv<-read.csv("F:/data/new/00/00.csv",header = TRUE,stringsAsFactors = FALSE)
csvv<-select(csvv,-X)
colnames(csvv)<-c("file","date")

A<-cbind(lapply(csvv, "[",1)$date,lapply(csvv, "[",1)$file)

numdata<-sapply(count(csvv),"[",1)
for (a in 2:numdata) {
  B<-ncol(A)
  for (b in 1:B) {
    if(lapply(csvv, "[",a)$date==A[,b]){
      A<-cbind(A[,b],lapply(csvv, "[",a)$file)
    }
  }
  
}