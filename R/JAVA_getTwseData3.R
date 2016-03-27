#disk location
Upath<-paste0("F:/")

#file location with complete data
x1_path<-paste0(Upath,"JAVA_getTwseData3/94YearCoupon.txt")
#確認顯示" "
CheckSymbol<-sapply(strsplit(readLines(x1_path,encoding="UTF-8")[2],";"),"[",17)

for (k in 94:104) {
  #file location with complete data
  x1_path<-paste0(Upath,"JAVA_getTwseData3/",k,"YearCoupon.txt")
  #read file
  csvv<-readLines(x1_path,encoding="UTF-8")
  csvv[1]
  strsplit(csvv[1],";")
  
  A<-NULL
  for (i in 1:600) {
    if (is.na(csvv[i])) {
    }else{
      B<-NULL
      for (j in 1:24) {
        if(CheckSymbol==sapply(strsplit(csvv[i],";"),"[",j)){
          D<-""
        }else{
          D<-sapply(strsplit(csvv[i],";"),"[",j)
        }
        B<-cbind(B,D)
      }
      A<-rbind(A,B)
    }
  }
  head(A)
  colnames(A)<-c(1:ncol(A))
  new_path00<-paste0(Upath,"JAVA_getTwseData3/",k,"YearCoupon.csv")
  write.csv(A,file = new_path00)
  #colnames(A)<-c("ID","name","C_Year","C_BaseDate","C_Stock_Earnings","C_Stock_Other","C_Stock_ExchangeDate",""
  #""
}

