library(dplyr)

a<-dir("D:/data/new","csv")
length.a<-length(a)

B<-NULL

for (m in 1:length.a) {
  
  checknum<-0
  for(n in 1:4){
    if(substr(a[m],n,n)<=9&&substr(a[m],n,n)>=0){checknum<-checknum+1}
  }
  if(checknum==4&&substr(a[m],6,8)=="csv"){
    x1_path<-paste("D:/data/new/",a[m],sep = "")
    csvv<-read.csv(x1_path,header = TRUE,stringsAsFactors = FALSE)
    #  colnames(csvv)<-c("Year","Month" ,"Day","vol_S","vol_P","P_S" ,"P_H","P_L","P_E","P_D2","exc","NP_D2D")
    csvv<-select(csvv,-X)
    numdata<-sapply(count(csvv),"[",1)
    na0num<-0
    na__num<-0
    nanum<-0
    na2num<-0
    for (o in 1:numdata) {
      na0num<-na0num+sum(sapply(csvv,"[",o)==0,na.rm = TRUE)#有
      na__num<-na__num+sum(sapply(csvv,"[",o)=="--",na.rm = TRUE)#有
         nanum<-nanum+sum(is.na(sapply(csvv,"[",o)))#有90051
        na2num<-na2num+sum(sapply(csvv,"[",o)=="",na.rm = TRUE)#有0
    }
    A<-c(a[m],na0num,na__num,nanum,na2num)
    B<-rbind(B,A)
    new_path<-paste("D:/data/new/000.csv",sep = "")
  }
}
write.csv(B, file = new_path)
