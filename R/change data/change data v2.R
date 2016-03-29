library(dplyr)

a<-dir("F:/000","csv")
length.a<-length(a)


for (m in 1:length.a) {
if(substr(a[m],6,8)=="csv"){
    x1_path<-paste("F:/000/",a[m],sep = "")
  csvv<-read.csv(x1_path,header = FALSE,stringsAsFactors = FALSE)
  colnames(csvv)<-c("date","vol_S","vol_P","P_S","P_H","P_L","P_E","P_D","exc")
    
    B<-mutate(csvv
#1.年月日分開     
              ,"Year"=as.numeric(sapply(strsplit(csvv$date,"/"),"[",1))+1911
              ,"Month"=as.numeric(sapply(strsplit(csvv$date,"/"),"[",2))
              ,"Day"=as.numeric(sapply(strsplit(csvv$date,"/"),"[",3))
#2.年月日在一起       
              ,"date2"=paste(as.numeric(sapply(strsplit(csvv$date,"/"),"[",1))+1911
                            ,as.numeric(sapply(strsplit(csvv$date,"/"),"[",2))
                            ,as.numeric(sapply(strsplit(csvv$date,"/"),"[",3))
                            ,sep = "/")
            )

    new_path<-paste("F:/000/new/",a[m],".CSV",sep = "")
    write.csv(B, file = new_path)
}
}
