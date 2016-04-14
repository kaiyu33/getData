#'getStockNumTWSECT_ver2
#'
#'繼承自:getStockNumCT
#'繼承自:getStockNumTWSECT
#'繼承自:getStockNumTWSECT_ver1
#'
#'繼承自:crawler otc credirtransfer
#'
#'沒有儲存total總表
#'
#start

# library(dplyr)

#disk location
Upath<-paste0("D:/")

# D:\EXdata\CreditTransactions\CTData\getStockNumCT
# '1103嘉泥
# D:\EXdata\FinancialInformation\FIData\getStockNumFI
# 1103嘉泥

#file location
getStockNumCT_path<-paste0(Upath,"EXdata/CreditTransactions/CTData/getStockNumCT/")
DIRCT<-dir(getStockNumCT_path,"^[']")

#file location
getStockNumFI_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/getStockNumFI/")
DIRFI<-dir(getStockNumFI_path,"^[0-9]")

bodyNARow_num<-0
bodyNA<-NULL
for (i in 1:NROW(DIRFI)) {
  if(substr(DIRFI[i],1,4)%in%substr(DIRCT,2,5)){
    bodyNARow_num<-bodyNARow_num+1
    bodyNA<-rbind(bodyNA,substr(DIRFI[i],1,4))
  }
  
}

NROW(DIRFI)
NCOL(DIRFI)

bodyNARow_num<-bodyNARow_num+1
bodyNARow<-cbind(bodyNARow_num,getStockNum)
bodyNA<-rbind(bodyNA,bodyNARow)

body_path_NA<-paste0(Upath,"EXdata/CreditTransactions/CTData/getStockNumCT/total.csv")
write.csv(bodyNA,file = body_path_NA,fileEncoding="UTF-8") 

DIR<-dir(getStockNumCT_path)

#本迴圈是為了取得股票代碼-一般
getStockNumforCT_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/getStockNumFI/")
getStockNumforCT_DIR<-dir(getStockNumforCT_path)
# getStockNumforCT_RowNum<-1
for (getStockNumforCT_RowNum in 1:length(getStockNumforCT_DIR)) {#1改成58     7
  getStockNum<-paste0("'",substr(getStockNumforCT_DIR[getStockNumforCT_RowNum],1,4))
  
    