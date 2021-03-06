#start
#'新增尋找欄位位置
#'讀 寫檔案
#'
#'當按總共分成????階段
#'階段一 1999Q1-2000Q1
#'1-6
#'階段二 2000Q1-2004Q2
#'7-23
#'2004Q2 runIDNum=23時 因為隱藏一列 FInum=4
#'類股代號變動

#install.packages("xlsx")
library(xlsx)
library(dplyr)
#disk location
Upath<-paste0("F:/")


starttime_all<-proc.time()
#最大迴圈 跑各檔案

runID<-NULL
for (file_year in 1999:2015) {
  for (file_QNum in 1:4) {
    runID<-cbind(runID,paste0(file_year,"Q",file_QNum))
  }
}

for (runIDNum in 1:67) {
  print(runID[runIDNum])
  
  starttime<-proc.time()
  
  #file location
  FI_path<-paste0(Upath,"EXdata/FinancialInformation/",runID[runIDNum],".xls")
  #read file
  FinancialInformation<-read.xlsx(FI_path,1,encoding="UTF-8",stringsAsFactors = FALSE)
  
  #找起始欄位之位置[X,Y]
  namenum<-NULL
  StartRowIndustry<-NULL
  FInum<-NULL
  if (runIDNum<=5) {
    for (i in 1:3) {
      for (j in 1:15) {
        if (grepl("^\ {3}[0,1]{2}\ +",FinancialInformation[[i]][j])) {
          namenum<-i;
          StartRowIndustry<-j;
        }
      }
    }
    for (i in 1:5) {
      for (j in 1:10) {
        if (grepl("^\ *OPERATING\ *REVENUES\ *$",FinancialInformation[[i]][j])) {
          FInum<-i;
        }
      }
    }
  }else if (runIDNum>=6) {
    for (i in 1:3) {
      for (j in 1:15) {
        if (grepl("^[0,1]{2}\ *$",FinancialInformation[[i]][j])) {
          #"2015Q2" "01    "
          namenum<-i;
          StartRowIndustry<-j;
        }
      }
    }
    for (i in 1:5) {
      for (j in 1:10) {
        if (grepl("^Operating\ {0,1}Revenues$",FinancialInformation[[i]][j])) {
          #'"2014Q2""OperatingRevenues"
          FInum<-i;
        }
        if (grepl("^OPERATING REVENUES$",FinancialInformation[[i]][j])) {#runIDNum  6
          FInum<-i;
        }
      }
    }
  }
  
  #該年度無未公布財報
  if(namenum!=1){
    DelteDataNum<-namenum-1
    FinancialInformation<-select(FinancialInformation,-DelteDataNum)
    FInum<-FInum-namenum+1
  }
  
  #用來判斷之欄位
  CheckSymbol_col_name<-FinancialInformation[1]
  CheckSymbol_col_FI<-FinancialInformation[FInum]
  
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
  write.csv(body,file = body_path,fileEncoding="UTF-8")
  write.csv(body_CompanyRowNum,file = body_CompanyRowNum_path,fileEncoding="UTF-8")
  write.csv(body_IndustryRowNum,file = body_IndustryRowNum_path,fileEncoding="UTF-8")
  if(is.null(CompanyRowNum_NAFI)!=1){
    write.csv(body_CompanyRowNum_NAFI,file = body_CompanyRowNum_NAFI_path,fileEncoding="UTF-8")
  }
  
  #顯示每次所需時間(秒)
  runtime<-proc.time()-starttime
  print(paste(runID[runIDNum]," , FINISHED!"," ( ",round(runtime[1],2),round(runtime[2],2),round(runtime[3],2)," ) "))  
}


runtime_all<-proc.time()-starttime_all
print(starttime_all)
print(proc.time())
print(runtime_all)

