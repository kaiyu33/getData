#start
#'
#'2014Q3

#install.packages("xlsx")
library(xlsx)
library(dplyr)
#disk location
Upath<-paste0("F:/")

runID<-NULL
for (file_year in 1999:2015) {
  for (file_QNum in 1:4) {
    runID<-cbind(runID,paste0(file_year,"Q",file_QNum))
  }
}
runIDNum<-1
TotalTable<-NULL
for (runIDNum in 1:5) {
  print(runID[runIDNum])
  
  #starttime<-proc.time()
  
  #file location
  FI_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/",runID[runIDNum],".csv")
  #read file
  #StockFI<-read.csv(FI_path,encoding="big5",stringsAsFactors = FALSE)#<-big5
  StockFI<-read.csv(FI_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8
  
  head(StockFI)
  
  StockFI<-slice(StockFI,1:2)
  
  #取得欄位總數
  RowNum<-NROW(colnames(StockFI))
  
  #colnames(StockFI)<-NULL
  #colnames(TotalTable)<-NULL
  
  TMP<-StockFI
  if (RowNum<25) {
    AddRowNum<-25-RowNum
    for (i in 1:AddRowNum) {
      TMP<-cbind(TMP,i)
    }
  }
  
  NCOL(TMP)
  #colnames(TMP)<-colnames(TotalTable)
  TotalTable<-rbind(TotalTable,TMP)
  
}
  