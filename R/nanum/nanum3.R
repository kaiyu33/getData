library(dplyr)
#path有四個

a<-dir("D:/data/new","csv")
length.a<-length(a)

B<-NULL
D<-NULL

for (m in 1:length.a) {
#for (m in 1:8) {
  
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
    
    B<-NULL
    C<-NULL
    #  nanum<-0
    # na2num<-0
    if(TRUE){
      for (o in 1:numdata) {
        
        #調整回傳值需修改者為TRUE
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
        
        #此為判對式
        if (Year==""&Month==""&Day==""&vol_S==""&vol_P==""&P_S==""&P_H==""&P_L==""&P_E==""&P_D2==""&exc==""&NP_D2D=="") {
        }else{
          C<-c(c(a[m],o,Year,Month,Day,vol_S,vol_P,P_S,P_H,P_L,P_E,P_D2,exc,NP_D2D))
          #A<-c(a[m],Year,Month,Day,vol_S,vol_P,P_S,P_H,P_L,P_E,P_D2,exc,NP_D2D)
          B<-rbind(B,C)
        }
      }# for (o in 1:numdata) {
      
      #將資料完整(即if (Year==""&Month==""&Day==""&vol_S==""&vol_P==""&P_S==""&P_H==""&P_L==""&P_E==""&P_D2==""&exc==""&NP_D2D=="")為TRUE)的資料
      #存到一個檔案@"D:/data/new/00/00.csv"
      if (is.null(B)&ifelse(is.null(D),TRUE,D[nrow(D),]!=a[m])) {
        D<-rbind(D,a[m])
      } 
      
      #將資料不完整的該筆數與欄位各自存到相對應的檔案@"D:/data/new/00/",a[m]
      if(is.null(B)==0){
       # new_path<-paste("F:/data/new/00/",a[m],sep = "")
        new_path<-paste("D:/data/new/00/",a[m],sep = "")
        write.csv(B, file = new_path)
      }
    }# if(TRUE){
  }#if(checknum==4&&substr(a[m],6,8)=="csv"){
}
write.csv(D, file = "D:/data/new/00/00.csv")
