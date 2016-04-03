#start
#'StockFI
#'
#'繼承自:TotalTable
#'階段一:將各財報會及於一個CSV檔 僅收納前兩筆及欄位名
#'從"F:/EXdata/FinancialInformation/FIData/TotalTable ' 1.xls ' "
#'可見該表分成三個時期
#'1999Q1-2000Q1-19欄
#'runIDNum:1-5
#'2000Q2-2014Q2-20欄
#'runIDNum:6-62
#'2014Q3-今-23欄
#'runIDNum:63-67
#'Net Income before Tax-3欄位-當季,YoY,Rate
#'
#'繼承自:本檔:StockFI
#'階段二:將各財報會及於一個CSV檔

#儲存及改變環境設定
old.options=options()
options(stringsAsFactors = FALSE)

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
#runIDNum<-6
#runIDNum<-63

#body1<-data.frame(stringsAsFactors = FALSE)
#有沒有輸出都一樣

body1<-NULL
body2<-NULL
for (runIDNum in 1:67) {
  print(runID[runIDNum])
  
  #starttime<-proc.time()
  
  #file location
  FI_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/",runID[runIDNum],"_Company.csv")
  #read file
  #StockFI<-read.csv(FI_path,encoding="big5",stringsAsFactors = FALSE)#<-big5
  StockFI<-read.csv(FI_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8
  
  #StockFI<-mutate(StockFI,"X"=runID[runIDNum])#須較colnames先執行
  #後面一起做即可
  
  #'runIDNum:1-5 6-62
  head(StockFI)
  
  if (runIDNum<=5) {
    colnames(StockFI)<-c("X","ID_NAME","OR","OR_YoY","OR_Rate",
                         "Income","Income_YoY","nO_Income","nO_Income_YoY","N_Income","N_Income_YoY",
                         "N_Income_Rate","Shared","N_Income_Shared","N_Income_Shared_YoY",
                         "NetPrice_Shared","NetPrice_totalAsset","FlowRate","QuickRate" )#19欄位
    
    StockFI$"ID_NAME"<-gsub(" ",replacement="",StockFI$"ID_NAME")#取代-全部
    #sub(" ",replacement="",sub(" ",replacement="",sub(" ",replacement="",StockFI$"ID_NAME")))#取代-一次,一部分-三次還是有可能有空白
    
    Id<-substr(StockFI$"ID_NAME", 1, 4)
    Name<-substr(StockFI$"ID_NAME", 5,8)
    #H_StockFI<-head(cbind(Id,Name,Time=runID[runIDNum],select(StockFI,-1:-2,-20)))
    #準備匯出資料
    StockFI<-cbind(Id,Name,Time=runID[runIDNum],select(StockFI,-1:-2,-20,-30))
    #刪除 X ID_NAME NA
    #並建立 Id Name Time  
    body1<-rbind(body1,StockFI)
  }else if (runIDNum<=62) {
    #無效欄位名:1 是為了DEBUG runIDNum=30 兩個NA
    if (NROW(colnames(StockFI))<=20) {
      colnames(StockFI)<-c("X","Id","Name","OR","OR_YoY","OR_Rate",
                           "Income","Income_YoY","nO_Income","nO_Income_YoY","N_Income","N_Income_YoY",
                           "N_Income_Rate","Shared","N_Income_Shared","N_Income_Shared_YoY",
                           "NetPrice_Shared","NetPrice_totalAsset","FlowRate","QuickRate")#20欄位
    }else if (NROW(colnames(StockFI))>=21) {
      colnames(StockFI)<-c("X","Id","Name","OR","OR_YoY","OR_Rate",
                           "Income","Income_YoY","nO_Income","nO_Income_YoY","N_Income","N_Income_YoY",
                           "N_Income_Rate","Shared","N_Income_Shared","N_Income_Shared_YoY",
                           "NetPrice_Shared","NetPrice_totalAsset","FlowRate","QuickRate","1")#20欄位 1為無效欄位名
    }
   
    #準備匯出資料
    #select(StockFI,2,4:20)
    StockFI<-cbind(select(StockFI,2,3),Time=runID[runIDNum],select(StockFI,-1:-3,-21:-30))
    body1<-rbind(body1,StockFI)
  }else if (runIDNum>=63) {
    colnames(StockFI)<-c("X","Id","Name","OR","OR_YoY","OR_Rate",
                         "Income","Income_YoY","nO_Income","nO_Income_YoY","N_Income","N_Income_YoY",
                         "N_Income_Rate","Shared","N_Income_Shared","N_Income_Shared_YoY",
                         "NetPrice_Shared","NetPrice_totalAsset","FlowRate","QuickRate","NetIncome_bTax",
                         "NetIncome_bTax_YoY","NetIncome_bTax_Rate")#23欄位
    #準備匯出資料
    StockFI2<-cbind(select(StockFI,2,3),Time=runID[runIDNum],select(StockFI,-1:-3,-24)) 
    StockFI<-cbind(select(StockFI,2,3),Time=runID[runIDNum],select(StockFI,-1:-3,-21:-23)) 
    
    body2<-rbind(body2,StockFI2)
    body1<-rbind(body1,StockFI)
  }
  #NROW(colnames(StockFI))
  #匯出20欄位 如下
  #'[1] "Id"                  "Name"            "Time"                "OR"                  "OR_YoY"            "OR_Rate"      
  #'[7] "Income"              "Income_YoY"      "nO_Income"           "nO_Income_YoY"       "N_Income"          "N_Income_YoY"
  #'[13] "N_Income_Rate"       "Shared"          "N_Income_Shared"     "N_Income_Shared_YoY" "NetPrice_Shared"   "NetPrice_totalAsset"
  #'[19] "FlowRate"            "QuickRate" 
  
}

#輸出 小數點後僅兩位
body1<-mutate(body1
              #'加上 body1<- 較為嚴謹 比較不會有位知情況發生
              #'EX:部分欄位未改成 小數點後僅兩位
              ,"OR_Rate"=round(as.numeric(OR_Rate),2) 
              ,"N_Income_Rate"=round(as.numeric(N_Income_Rate),2) 
              ,"N_Income_Shared"=round(as.numeric(N_Income_Shared),2) 
              ,"N_Income_Shared_YoY"=round(as.numeric(N_Income_Shared_YoY),2) 
              ,"NetPrice_Shared"=round(as.numeric(NetPrice_Shared),2) 
              ,"NetPrice_totalAsset"=round(as.numeric(NetPrice_totalAsset),2) 
              ,"FlowRate"=round(as.numeric(FlowRate),2) 
              ,"QuickRate"=round(as.numeric(QuickRate),2) 
)
#write.csv file location
body_path1<-paste0(Upath,"EXdata/FinancialInformation/FIData/StockFI.csv")
#write.csv file
write.csv(body1,file = body_path1,fileEncoding="UTF-8")

if (runIDNum>=63) {
  body2<-mutate(body2
                #'加上 body2<- 較為嚴謹 比較不會有位知情況發生
                #'EX:部分欄位未改成 小數點後僅兩位
                ,"OR_Rate"=round(as.numeric(OR_Rate),2) 
                ,"N_Income_Rate"=round(as.numeric(N_Income_Rate),2) 
                ,"N_Income_Shared"=round(as.numeric(N_Income_Shared),2) 
                ,"N_Income_Shared_YoY"=round(as.numeric(N_Income_Shared_YoY),2) 
                ,"NetPrice_Shared"=round(as.numeric(NetPrice_Shared),2) 
                ,"NetPrice_totalAsset"=round(as.numeric(NetPrice_totalAsset),2) 
                ,"FlowRate"=round(as.numeric(FlowRate),2) 
                ,"QuickRate"=round(as.numeric(QuickRate),2) 
                ,"NetIncome_bTax_Rate"=round(as.numeric(NetIncome_bTax_Rate),2) 
  )
  
  #write.csv file location
  body_path2<-paste0(Upath,"EXdata/FinancialInformation/FIData/StockFI2.csv")
  #write.csv file
  write.csv(body2,file = body_path2,fileEncoding="UTF-8")
}

#還原原先環境設定
options(old.options)

  #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
if (FALSE) {  註解
  A<-paste0("OR")
  B<-paste0("OR")
  C<-paste0("OR_Rate")
  D<-paste0("Income")
  E<-paste0("Income")
  
  G<-paste0("nO_Income")
  H<-paste0("nO_Income")
  I<-paste0("N_Income")
  J<-paste0("N_Income")
  K<-paste0("N_Income_Rate")
  
  L<-paste0("Shared")
  M<-paste0("N_Income_Shared")
  N<-paste0("N_Income_Shared")
  P<-paste0("NetPrice_Shared")
  Q<-paste0("NetPrice_totalAsset")
  
  R<-paste0("FlowRate")
  S<-paste0("QuickRate")
  
  c("X","ID_NAME",A,B,C,D,E,G,H,I,J,K,L,M,N,P,Q,R,S)
}
 