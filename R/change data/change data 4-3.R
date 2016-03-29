library(dplyr)

a<-dir("F:/000","csv")
length.a<-length(a)
  
for (m in 1:length.a) {
  x1_path<-paste("F:/000/",a[m],sep = "")
  csvv<-read.csv(x1_path,header = FALSE,stringsAsFactors = FALSE)
  colnames(csvv)<-c("date","vol_S","vol_P","P_S","P_H","P_L","P_E","P_D","exc")
  numdata<-sapply(count(csvv),"[",1)
  finddata<-colnames(csvv) == "date"
  if(sum(finddata)==1){
    
    for (n in 1:numdata) {
      b<-sapply(csvv[finddata],"[", n)
      bb<-strsplit(b, "/")
      c<-as.numeric(sapply(bb,"[",1))+1911
      date<-c(date,paste(c,sapply(bb,"[",2),sapply(bb,"[",3),sep = "/"))
      
    }
  #    for (n in 1:numdata) {
   # date2<-as.data.frame(date)
    #}
    date2<-as.matrix(date)
    
 write.csv(date2, file = "F:/000/tmp.CSV")
 Xdate<-read.csv("F:/000/tmp.CSV",stringsAsFactors = FALSE)
 A<-select(Xdate,2)
 numdate2<-sapply(count(A),"[",1)
 B<-slice(A,3:numdate2)
      
 fincsvv<-cbind(B,csvv)
    new_path<-paste("F:/000/newnew",a[m],".CSV",sep = "")
    write.csv(fincsvv, file = new_path)
    date<-NULL
  }
}



