library(dplyr)

a<-dir("D:/data","csv")
length.a<-length(a)

B<-NULL

for (m in 1:length.a) {
  
  checknum<-0
  for(n in 1:4){
    if(substr(a[m],n,n)<=9&&substr(a[m],n,n)>=0){checknum<-checknum+1}
  }
  if(checknum==4&&substr(a[m],6,8)=="csv"){
    x1_path<-paste("D:/data/",a[m],sep = "")
    csvv<-read.csv(x1_path,header = FALSE,stringsAsFactors = FALSE)
    colnames(csvv)<-c("date","vol_S","vol_P","P_S","P_H","P_L","P_E","P_D","exc")
    numdata<-sapply(count(csvv),"[",1)
      nanum<-0
      na2num<-0
      for (o in 1:numdata) {
         nanum<-nanum+sum(is.na(sapply(csvv,"[",o)))
         na2num<-na2num+sum(sapply(csvv,"[",o)=="",na.rm = TRUE)
      }
      A<-c(a[m],nanum,na2num)
      B<-rbind(B,A)
      new_path<-paste("D:/data/new/0000.csv",sep = "")
  }
}
write.csv(B, file = new_path)

