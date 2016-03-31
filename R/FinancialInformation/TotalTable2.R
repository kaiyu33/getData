#start
#'TotalTable
#'
#'階段一:將各財報會及於一個CSV檔
#'從"F:/EXdata/FinancialInformation/FIData/TotalTable ' 1.xls ' "
#'可見該表分成三個時期
#'1999Q1-2000Q1-19欄
#'runIDNum:1-5
#'2000Q2-2014Q2-20欄
#'runIDNum:6-62
#'2014Q3-今-23欄
#'runIDNum:63-67
#'Net Income before Tax-3欄位-當季,YoY,Rate

#install.packages("xlsx")
library(xlsx)
library(dplyr)
#disk location
Upath<-paste0("F:/")

#建立處理清單-EX:"2015Q3"
runID<-NULL
for (file_year in 1999:2015) {
  for (file_QNum in 1:4) {
    runID<-cbind(runID,paste0(file_year,"Q",file_QNum))
  }
}
#runIDNum<-1
TotalTable<-NULL

#建立colname 1-25
colname1_25<-NULL
for (j in 1:25) {
  colname1_25<-cbind(colname1_25,j)
}

#大迴圈開始
for (runIDNum in 1:67) {
  print(runID[runIDNum])
  
  #starttime<-proc.time()
  
  #file location
  FI_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/",runID[runIDNum],".csv")
  #read file
  #StockFI<-read.csv(FI_path,encoding="big5",stringsAsFactors = FALSE)#<-big5
  StockFI<-read.csv(FI_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8
  
  head(StockFI)
  
  StockFI<-slice(StockFI,1:2)
  StockFI<-mutate(StockFI,X=runID[runIDNum])
  
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
  
  
  
  colnames(TMP)<-colname1_25
  if(is.null(colnames(TotalTable))!=1){
    colnames(TotalTable)<-colname1_25
  }
  
  
  TotalTable<-rbind(TotalTable,colnames(StockFI),TMP)
  
}

TotalTable_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/TotalTable.csv")
write.csv(TotalTable,file = TotalTable_path,fileEncoding="UTF-8")


