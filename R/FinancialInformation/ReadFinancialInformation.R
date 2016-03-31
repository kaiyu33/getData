

#start
#'當按總共分成????階段
#'階段一 1999Q1-2000Q1


#install.packages("xlsx")
library(xlsx)
#disk location
Upath<-paste0("F:/")

#確認顯示" "
#GetCheckSymbol_col<-read.xlsx(GetCheckSymbol_path,1,encoding="UTF-8",stringsAsFactors = FALSE)[2]
#GetCheckSymbol<-sapply(slice(GetCheckSymbol_col,12),"[",1)

#取得第一筆資料-產業
GetCheckSymbolIndustry<-"   11 水泥工業  "
GetCheckSymbolCompany<-" 1101 台灣水泥  " 

#file location
FinancialInformationPath<-paste0(Upath,"1999Q1.xls")
FinancialInformation<-read.xlsx(FinancialInformationPath,1,encoding="UTF-8",stringsAsFactors = FALSE)
library(dplyr)

#在15*3的表格內尋找


CheckSymbol_col2<-FinancialInformation[2]
CheckSymbol_col3<-FinancialInformation[3]
for (i in 1:20) {
  CheckSymbol<-sapply(slice(CheckSymbol_col2,i),"[",1)
  i
  if (is.na(CheckSymbol)) {
    next
  }#SKIP
  if (GetCheckSymbolIndustry==CheckSymbol) {
    StartRowIndustry<-i
    print(paste0("StartRowIndustry : ",StartRowIndustry))
  }
}
#StartRowIndustry
for (i in StartRowIndustry:(StartRowIndustry+5)) {
  CheckSymbol<-sapply(slice(CheckSymbol_col2,i),"[",1)
  i
  if (is.na(CheckSymbol)) {
    next
  }#SKIP
  if (GetCheckSymbolCompany==CheckSymbol) {
    StartRowCompany<-i
    print(paste0("StartRowCompany : ",StartRowCompany))
  }
}
#StartRowCompany

#body1<-slice(FinancialInformation,StartRowIndustry:1000)#body col_517
#count(unique(body)[2])
#BodyRowNum<-sapply(count(body1),"[",1)
#unique(body[2])#去除重複行(空白) 但是仍有一行空白 col_513
#unique(body)[2]
#View(body)
#A[12,2]

#CheckSymbol_col3<-FinancialInformation[3]
FIRowNum<-sapply(count(FinancialInformation),"[",1)
DeleteRowNum<-NULL;#財報數據空白  
DeleteRowTotalNum<-0;#財報數據空白行數  
DeleteRowNum_NA<-NULL;#空白行 
DeleteRowTotalNum_NA<-0;#空白行數 
CompanyRowNum<-NULL;#有公佈財報的公司         印
IndustryRowNum<-NULL;#產業財報數據            印
CompanyRowNum_NAFI<-NULL;#沒有公佈財報的公司  印
DeleteRowNum_BeforeEnd_StartRow<-1000;
for (j in 1:FIRowNum) {
  #取出 產業 公司 的資料 不含colname
  CheckSymbol3<-sapply(slice(CheckSymbol_col3,j),"[",1)
  CheckSymbol2<-sapply(slice(CheckSymbol_col2,j),"[",1)
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
      if(grepl("^\ [0-9]{4}",CheckSymbol2)){#有公佈財報的公司
        CompanyRowNum<-cbind(CompanyRowNum,j)
      }else if(grepl("^\ {3}[0-9]{2}",CheckSymbol2)){#產業財報數據
        IndustryRowNum<-cbind(IndustryRowNum,j)
      }
    }
  }
  #當DeleteRowNum_BeforeEnd_StartRow改變後才會執行
  if (grepl("^\ *[(]",CheckSymbol2)) {
    #找頁尾 不需要的
    DeleteRowNum<-cbind(DeleteRowNum,j)
    DeleteRowTotalNum=DeleteRowTotalNum+1
    DeleteRowNum_BeforeEnd_StartRow<-j
  }else if(j>DeleteRowNum_BeforeEnd_StartRow){
    DeleteRowNum<-cbind(DeleteRowNum,j)
    DeleteRowTotalNum=DeleteRowTotalNum+1
  }
}

body<-slice(FinancialInformation,-DeleteRowNum);#colnum=528to439
body_CompanyRowNum<-slice(FinancialInformation,CompanyRowNum);#有公佈財報的公司               印  439
body_IndustryRowNum<-slice(FinancialInformation,IndustryRowNum);#產業財報數據                 印  419
body_CompanyRowNum_NAFI<-slice(CheckSymbol_col2,CompanyRowNum_NAFI);#沒有公佈財報的公司       印   20
View(body);
View(body_CompanyRowNum);
View(body_IndustryRowNum);

#col reduce-71  FinancialInformation[3]   營       業        收     入      		當季
#body col_517
#col reduce-39  FinancialInformation[2]  公  司  名  稱
#body col_457
#517-457 約60家截止前未交財報



body<-slice(FinancialInformation,-DeleteRowNum);#colnum=528to439
body_CompanyRowNum<-slice(FinancialInformation,CompanyRowNum);#有公佈財報的公司               印  439
body_IndustryRowNum<-slice(FinancialInformation,IndustryRowNum);#產業財報數據                 印  419
body_CompanyRowNum_NAFI<-slice(CheckSymbol_col2,CompanyRowNum_NAFI);#沒有公佈財報的公司       印   20

#write.csv file location
body_path<-paste0(Upath,"1999Q1.csv")
body_CompanyRowNum_path<-paste0(Upath,"1999Q1_Company.csv")
body_IndustryRowNum_path<-paste0(Upath,"1999Q1_Industry.csv")
body_CompanyRowNum_NAFI_path<-paste0(Upath,"1999Q1_Company_NAFI.csv")

#write.csv file
write.csv(body,file = body_path)
write.csv(body_CompanyRowNum,file = body_CompanyRowNum_path)
write.csv(body_IndustryRowNum,file = body_IndustryRowNum_path)
write.csv(body_CompanyRowNum_NAFI,file = body_CompanyRowNum_NAFI_path)





