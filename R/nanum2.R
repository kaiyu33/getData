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
    
    Year<-0
    Month<-0
    Day<-0
    vol_S<-0
    vol_P<-0
    
    P_S<-0
    P_H<-0
    P_L<-0
    P_E<-0
    
    P_D2<-0
    exc<-0
    
    NP_D2D<-0
    
    #  nanum<-0
     # na2num<-0
      for (o in 1:numdata) {
        Year<-Year+sum(is.na(lapply(csvv,"[",o)$Year))#有
        Month<-Month+sum(is.na(lapply(csvv,"[",o)$Month))#有
        Day<-Day+sum(is.na(lapply(csvv,"[",o)$Day))#有
        
        vol_S<-vol_S+sum(is.na(lapply(csvv,"[",o)$vol_S<=0))#有
        vol_P<-vol_P+sum(is.na(lapply(csvv,"[",o)$vol_P<=0))#有
        
        P_S<-P_S+sum(lapply(csvv,"[",o)$P_S=="--",na.rm = TRUE)#有20408
        P_H<-P_H+sum(lapply(csvv,"[",o)$P_H=="--",na.rm = TRUE)#有20408
        P_L<-P_L+sum(lapply(csvv,"[",o)$P_L=="--",na.rm = TRUE)#有20408
        P_E<-P_E+sum(lapply(csvv,"[",o)$P_E=="--",na.rm = TRUE)#有16366
        
        P_D2<-P_D2+sum(is.na(lapply(csvv,"[",o)$P_D2))#有38909
        exc<-exc+sum(lapply(csvv,"[",o)$exc==0,na.rm = TRUE)#有44277
        NP_D2D<-NP_D2D+sum(is.na(lapply(csvv,"[",o)$NP_D2D))#有51142
        
     #   nanum<-nanum+sum(is.na(sapply(csvv,"[",o)))
      #  na2num<-na2num+sum(sapply(csvv,"[",o)=="",na.rm = TRUE)
      }
      A<-c(a[m],Year,Month,Day,vol_S,vol_P,P_S,P_H,P_L,P_E,P_D2,exc,NP_D2D)
      B<-rbind(B,A)
      colnames(B)<-c("FILENAME","Year","Month" ,"Day","vol_S","vol_P","P_S" ,"P_H","P_L","P_E","P_D2","exc","NP_D2D")
      new_path<-paste("D:/data/new/0000.csv",sep = "")
  }
}
write.csv(B, file = new_path)

