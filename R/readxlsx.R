#this file location F:/getData

#install.packages("gdata")
#library(gdata)
#remove.packages("gdata")
#'解安裝 我不會使用 但是xlsx可以正常使用
#'require(gdata)
#'df = read.xls ("myfile.xlsx"), sheet = 1, header = TRUE)
#'xls2csv(xls, sheet=1, verbose=FALSE, blank.lines.skip=TRUE,perl="F:/1999Q1.xls")


#start
#install.packages("xlsx")
library(xlsx)
#disk location
Upath<-paste0("D:/")

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

CheckSymbol_col2<-FinancialInformation[2]
for (i in 1:20) {
  CheckSymbol<-sapply(slice(CheckSymbol_col,i),"[",1)
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
  CheckSymbol<-sapply(slice(CheckSymbol_col,i),"[",1)
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

body<-slice(FinancialInformation,StartRowIndustry:1000)#body col_517
#count(unique(body)[2])
BodyRowNum<-sapply(count(body),"[",1)
#unique(body[2])#去除重複行(空白) 但是仍有一行空白 col_513
#unique(body)[2]
#View(body)
#A[12,2]

CheckSymbol_col3<-FinancialInformation[3]
DeleteRowNum<-NULL
DeleteRowTotalNum<-0
for (j in StartRowIndustry:BodyRowNum) {
  CheckSymbol<-sapply(slice(CheckSymbol_col3,j),"[",1)
  #col reduce-71  FinancialInformation[3]   營       業        收     入      		當季
  #col reduce-39  FinancialInformation[2]  公  司  名  稱 
  if (is.na(CheckSymbol)|(regexec("^\ *$",CheckSymbol)[[1]][1]==1)) {
    DeleteRowNum<-cbind(DeleteRowNum,j)
    DeleteRowTotalNum=DeleteRowTotalNum+1
  }
  if (regexec("^\ *(",CheckSymbol)[[1]][1]==1) {
    DeleteRowNum<-cbind(DeleteRowNum,j)
    DeleteRowTotalNum=DeleteRowTotalNum+1
    DeleteRowNum
  }
}

body<-slice(FinancialInformation,-DeleteRowNum)
#col reduce-71  FinancialInformation[3]   營       業        收     入      		當季
#body col_517
#col reduce-39  FinancialInformation[2]  公  司  名  稱
#body col_457
#517-457 約60家截止前未交財報

#EndRowCompany
regexec("^\ {3}[0-9]{2,4}",GetCheckSymbolIndustry)[[1]][1]#奇數都是TRUE
regexec("^\ [0-9]{2,4}",GetCheckSymbolCompany)[[1]][1]
regexec("^\ *[0-9]{2,4}",GetCheckSymbolCompany)
regexec("^[\ ]*$",GetCheckSymbolCompany)[[1]][1]

#Industry
for (j in StartRowIndustry:) {
  
}
if (condition) {
  
}


#Company


#Company 截止前未交財報
regexec("^\ {3}[0-9]{2,4}",GetCheckSymbolIndustry)[[1]][1]
regexec("^\ [0-9]{2,4}",GetCheckSymbolCompany)[[1]][1]
regexec("^\ *[0-9]{2,4}",GetCheckSymbolCompany)
attr()

  sapply(read.xlsx(GetCheckSymbol_path,encoding="UTF-8")[2],"[",i)
  sapply(strsplit(readLines(x1_path,encoding="UTF-8")[2],";"),"[",17)
