#crawler otc credirtransfer
library(jsonlite)

#disk location
Upath<-paste0("D:/")

# # So for dates (post-1901) from Windows Excel
# as.Date(42468, origin = "1899-12-30") # 2016-04-08

for (daynum in 42468:42460) {
  day<- paste0(as.numeric(substr(as.Date(daynum, origin = "1899-12-30"),1,4))-1911,"/",substr(as.Date(daynum, origin = "1899-12-30"),6,7),"/",substr(as.Date(daynum, origin = "1899-12-30"),9,10))
dayoutput<-paste0(substr(as.Date(daynum, origin = "1899-12-30"),1,4),substr(as.Date(daynum, origin = "1899-12-30"),6,7),substr(as.Date(daynum, origin = "1899-12-30"),9,10))

  OTC_path<-paste0("http://www.tpex.org.tw/web/stock/margin_trading/margin_balance/margin_bal_result.php?l=zh-tw&d=",day);
  OTC<-fromJSON(OTC_path);
  names(OTC);
  #[1] "reportDate"    "iTotalRecords" "aaData"        "tfootData_one" "tfootData_two"
  
  if (OTC$iTotalRecords!=0) {
    
    TF<-OTC$reportDate==day
    OTCRow<-OTC$iTotalRecords
    OTCData<-OTC$aaData
    totalbyShares<-OTC$tfootData_one
    totalbyDolars<-OTC$tfootData_two
    # fromJSON("http://www.tpex.org.tw/web/stock/margin_trading/margin_balance/margin_bal_result.php?l=zh-tw&d=105/04/07")$reportDate
    # fromJSON("http://www.tpex.org.tw/web/stock/margin_trading/margin_balance/margin_bal_result.php?l=zh-tw&d=105/04/07")$iTotalRecords
    # fromJSON("http://www.tpex.org.tw/web/stock/margin_trading/margin_balance/margin_bal_result.php?l=zh-tw&d=105/04/07")$aaData
    # fromJSON("http://www.tpex.org.tw/web/stock/margin_trading/margin_balance/margin_bal_result.php?l=zh-tw&d=105/04/07")$tfootData_one
    # fromJSON("http://www.tpex.org.tw/web/stock/margin_trading/margin_balance/margin_bal_result.php?l=zh-tw&d=105/04/07")$tfootData_two
    
    #fromJSON("http://www.tpex.org.tw/web/stock/margin_trading/margin_balance/margin_bal_result.php?l=zh-tw&d=105/04/07")[2]
    
    
    #file location
    OTCCT_path<-paste0(Upath,"EXdata/CreditTransactions/",dayoutput,".csv")
    #write.csv file
    write.csv(OTCData,file = OTCCT_path,fileEncoding="UTF-8")
  }
}
#file location
OTCCTtotal_path<-paste0(Upath,"EXdata/CreditTransactions/OTCCTtotal.csv")
#write.csv file
write.csv( OTCCTtotal,file = OTCCTtotal_path,fileEncoding="UTF-8")

