#start
#'

#install.packages("xlsx")
library(xlsx)
library(dplyr)
#disk location
Upath<-paste0("D:/")

runID<-NULL
for (file_year in 1999:2015) {
  for (file_QNum in 1:4) {
    runID<-cbind(runID,paste0(file_year,"Q",file_QNum))
  }
}
runIDNum<-1
for (runIDNum in 1:67) {
  print(runID[runIDNum])
  
  starttime<-proc.time()
  
  #file location
  FI_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/",runID[runIDNum],"_Company.csv")
  #read file
  StockFI<-read.csv(FI_path,encoding="big5",stringsAsFactors = FALSE)#<-big5
  
  FIName<-runID[runIDNum]
  FIName0<-runID[runIDNum-1]
  A<-paste0("OR",FIName)
  B<-paste0("OR",FIName0)
  C<-paste0("OR",FIName,"Rate")
  D<-paste0("Income",FIName)
  E<-paste0("Income",FIName0)
  G<-paste0("nO_Income",FIName)
  H<-paste0("nO_Income",FIName0)
  I<-paste0("N_Income",FIName)
  J<-paste0("N_Income",FIName0)
  K<-paste0("N_Income",FIName,"Rate")
  L<-paste0("Shared")
  M<-paste0("N_Income_Shared",FIName)
  N<-paste0("N_Income_Shared",FIName0)
  P<-paste0("NetPrice_Shared")
  Q<-paste0("NetPrice_totalAsset")
  R<-paste0("FlowRate")
  S<-paste0("QuickRate")
  
  colnames(StockFI)<-c("X",A,B,C,D,E,G,H,I,J,K,L,M,N,P,Q,R,S)
  head(StockFI)
  #用來判斷之欄位
  CheckSymbol_col_name<-StockFI[2]
  
  class(StockFI[2])
  class(StockFI$OR1999Q2)
  
  strsplit(StockFI$台.灣.證.券.交.易.所.上.市.公.司.財.務.資.料.簡.報.," ")
  
  #該年度無未公布財報
  if(namenum!=1){
    DelteDataNum<-namenum-1
    FinancialInformation<-select(FinancialInformation,-DelteDataNum)
    FInum<-FInum-namenum+1
  }
  
  
  #找公司 整體 產業 未公布財報 所需第幾筆之筆數 
  FIRowNum<-sapply(count(FinancialInformation),"[",1)
  DeleteRowNum<-NULL;#財報數據空白  
  DeleteRowTotalNum<-0;#財報數據空白行數  
  DeleteRowNum_NA<-NULL;#空白行 
  DeleteRowTotalNum_NA<-0;#空白行數 
  CompanyRowNum<-NULL;#有公佈財報的公司         印
  IndustryRowNum<-NULL;#產業財報數據            印
  CompanyRowNum_NAFI<-NULL;#沒有公佈財報的公司  印
  DeleteRowNum_BeforeEnd_StartRow<-1000;
  BodyRowNum<-NULL
  for (j in 1:FIRowNum) {
    #取出 產業 公司 的資料 不含colname
    CheckSymbol3<-sapply(slice(CheckSymbol_col_FI,j),"[",1)
    CheckSymbol2<-sapply(slice(CheckSymbol_col_name,j),"[",1)
    #col reduce-71  FinancialInformation[3]   營       業        收     入      		當季
    #col reduce-39  FinancialInformation[2]  公  司  名  稱 
    if(DeleteRowNum_BeforeEnd_StartRow>999){
      if (is.na(CheckSymbol3)|StartRowIndustry>j|grepl("^\ *$",CheckSymbol3)) {
        #找NA 空白( "財報數據"  ) 頁首(colname)
        DeleteRowNum<-cbind(DeleteRowNum,j)
        DeleteRowTotalNum=DeleteRowTotalNum+1
        if (grepl("^\ [0-9]{4}",CheckSymbol2)) {#沒有公佈財報的公司
          CompanyRowNum_NAFI<-cbind(CompanyRowNum_NAFI,j)
        }else if(is.na(CheckSymbol2)){
          #找NA 空白(財報數據&  "公司名稱欄位"  ) 頁首(colname)
          DeleteRowNum_NA<-cbind(DeleteRowNum,j);#小BUG 9出現兩次/*/-*/-/-/
          DeleteRowTotalNum_NA=DeleteRowTotalNum+1;
        }
      }else if(grepl("^[0-9]*$",CheckSymbol3)){#有公佈財報
        if(grepl("^\ *[0-9]{4}",CheckSymbol2)){#有公佈財報的公司
          CompanyRowNum<-cbind(CompanyRowNum,j)
          BodyRowNum<-cbind(BodyRowNum,j)
        }else if(grepl("^\ {3}[0-9]{2}\ +",CheckSymbol2)){#產業財報數據 runIDNum  1:5
          IndustryRowNum<-cbind(IndustryRowNum,j)
          BodyRowNum<-cbind(BodyRowNum,j)
        }else if(grepl("^[0-9]{2}\ *$",CheckSymbol2)){#產業財報數據
          #"2015Q2" "01    "
          IndustryRowNum<-cbind(IndustryRowNum,j)
          BodyRowNum<-cbind(BodyRowNum,j)
        }
      }
    }
  }
  
  #  body<-slice(FinancialInformation,-DeleteRowNum);#colnum=528to439
  body<-slice(FinancialInformation,BodyRowNum);#colnum=528to439
  body_CompanyRowNum<-slice(FinancialInformation,CompanyRowNum);#有公佈財報的公司               印  439
  body_IndustryRowNum<-slice(FinancialInformation,IndustryRowNum);#產業財報數據                 印  419
  if(is.null(CompanyRowNum_NAFI)!=1){
    body_CompanyRowNum_NAFI<-slice(CheckSymbol_col_name,CompanyRowNum_NAFI);#沒有公佈財報的公司       印   20
  }
  #View(body);
  #View(body_CompanyRowNum);
  #View(body_IndustryRowNum);
  
  #write.csv file location
  body_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/",runID[runIDNum],".csv")
  body_CompanyRowNum_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/",runID[runIDNum],"_Company.csv")
  body_IndustryRowNum_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/",runID[runIDNum],"_Industry.csv")
  body_CompanyRowNum_NAFI_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/",runID[runIDNum],"_Company_NAFI.csv")
  
  
  #write.csv file
  write.csv(body,file = body_path)
  write.csv(body_CompanyRowNum,file = body_CompanyRowNum_path)
  write.csv(body_IndustryRowNum,file = body_IndustryRowNum_path)
  if(is.null(CompanyRowNum_NAFI)!=1){
    write.csv(body_CompanyRowNum_NAFI,file = body_CompanyRowNum_NAFI_path)
  }
  
  #顯示每次所需時間(秒)
  runtime<-proc.time()-starttime
  print(paste(runID[runIDNum]," , FINISHED!"," ( ",round(runtime[1],2),round(runtime[2],2),round(runtime[3],2)," ) "))  
}


runtime_all<-proc.time()-starttime_all
print(starttime_all)
print(proc.time())
print(runtime_all)

