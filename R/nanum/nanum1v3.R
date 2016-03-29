library(dplyr)

a<-dir("F:/data/new","csv")
length.a<-length(a)

B<-NULL
D<-NULL

#for (m in 1:length.a) {
for (m in 1:3) {
  
  checknum<-0
  for(n in 1:4){
    if(substr(a[m],n,n)<=9&&substr(a[m],n,n)>=0){checknum<-checknum+1}
  }
  if(checknum==4&&substr(a[m],6,8)=="csv"){
    x1_path<-paste("F:/data/new/",a[m],sep = "")
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
    
   # B<-NULL
    C<-NULL
    #  nanum<-0
    # na2num<-0
      for (o in 1:numdata) {
        Year<-ifelse(is.na(lapply(csvv,"[",o)$Year),"TRUE","")#有
        Month<-ifelse(is.na(lapply(csvv,"[",o)$Month),"TRUE","")#有
        Day<-ifelse(is.na(lapply(csvv,"[",o)$Day),"TRUE","")#有
        vol_S<-ifelse(is.na(lapply(csvv,"[",o)$vol_S<=0),"TRUE","")#有
        vol_P<-ifelse(is.na(lapply(csvv,"[",o)$vol_P<=0),"TRUE","")#有
        
        P_S<-ifelse(lapply(csvv,"[",o)$P_S=="--","TRUE","")#有
        P_H<-ifelse(lapply(csvv,"[",o)$P_H=="--","TRUE","")#有
        P_L<-ifelse(lapply(csvv,"[",o)$P_L=="--","TRUE","")#有20408
        P_E<-ifelse((lapply(csvv,"[",o)$P_E)=="--","TRUE","")#有20408
        
        P_D2<-ifelse(is.na(lapply(csvv,"[",o)$P_D2),"TRUE","")#有38909
        exc<-ifelse(lapply(csvv,"[",o)$exc==0,"TRUE","")#有44277
        NP_D2D<-ifelse(is.na(lapply(csvv,"[",o)$NP_D2D),"TRUE","")#有
  
        
        #   nanum<-nanum+sum(is.na(sapply(csvv,"[",o)))
        #  na2num<-na2num+sum(sapply(csvv,"[",o)=="",na.rm = TRUE)
        if (P_S=="TRUE"&P_H=="TRUE"&P_L=="TRUE"&P_E=="TRUE"&P_D2=="TRUE"&exc=="TRUE"&NP_D2D=="TRUE") {
          Year<-lapply(csvv,"[",o)$Year
          Month<-ifelse(lapply(csvv,"[",o)$Month<10,paste0("0",lapply(csvv,"[",o)$Month),lapply(csvv,"[",o)$Month)
          Day<-ifelse(lapply(csvv,"[",o)$Day<10,paste0("0",lapply(csvv,"[",o)$Day),lapply(csvv,"[",o)$Day)
          C<-c(c(a[m],paste0(Year,Month,Day)))
          #A<-c(a[m],Year,Month,Day,vol_S,vol_P,P_S,P_H,P_L,P_E,P_D2,exc,NP_D2D)
          B<-rbind(B,C)
        }
        
      }# for (o in 1:numdata) {
  }#if(checknum==4&&substr(a[m],6,8)=="csv"){
}
write.csv(B, file = "F:/data/new/00/00.csv")
