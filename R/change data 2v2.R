library(dplyr)
#'需修改:
#'path有3個

a<-dir("D:/data","csv")
length.a<-length(a)


for (m in 1:length.a) {
  
  #運算是否為數字
  checknum<-0
  for(n in 1:4){
    if(substr(a[m],n,n)<=9&&substr(a[m],n,n)>=0){checknum<-checknum+1}
    }
    
   #讀取該檔案並轉存到"D:/data/new/"
  if(checknum==4&&substr(a[m],6,8)=="csv"){
      x1_path<-paste("D:/data/",a[m],sep = "")
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
  
      new_path<-paste("D:/data/new/",a[m],".CSV",sep = "")
      write.csv(B, file = new_path)
  }
}

