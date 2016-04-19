#crawler otc credirtransfer
library(jsonlite)
library(dplyr)
#disk location
Upath<-paste0("F:/")#settinggggggggggggggggggggggggggggggggggggggggggggggggggggg

##date
# # So for dates (post-1901) from Windows Excel
# as.Date(42468, origin = "1899-12-30") # 2016-04-08
# as.numeric(as.Date("2016-04-08"))
# [1] 16899
Today<-as.Date(as.numeric(Sys.Date())+25569, origin = "1899-12-30")
TodayNum_MS<-as.numeric(Sys.Date())+25569
StartDay<-"2011-01-01"#settinggggggggggggggggggggggggggggggggggggggggggggggggggggg
StartDayNum_MS<-as.numeric(as.Date(StartDay))+25569

if (FALSE) {#settinggggggggggggggggggggggggggggggggggggggggggggggggggggg
  dir.create( "F:/EXdata/CreditTransactions", showWarnings = TRUE, recursive = FALSE, mode = "0777")
}


OTCCTtotal<-NULL
for (daynum in TodayNum_MS:StartDayNum_MS) {#settinggggggggggggggggggggggggggggggggggggggggggggggggggggg
  # for (daynum in TodayNum_MS:42460) {
  #daynum<-TodayNum_MS
  day<- paste0(as.numeric(substr(as.Date(daynum, origin = "1899-12-30"),1,4))-1911,"/",
               substr(as.Date(daynum, origin = "1899-12-30"),6,7),"/",
               substr(as.Date(daynum, origin = "1899-12-30"),9,10));
  
  dayoutput<-paste0(substr(as.Date(daynum, origin = "1899-12-30"),1,4),
                    substr(as.Date(daynum, origin = "1899-12-30"),6,7),
                    substr(as.Date(daynum, origin = "1899-12-30"),9,10));
  
  OTC_path<-paste0("http://www.tpex.org.tw/web/stock/margin_trading/margin_balance/margin_bal_result.php?l=zh-tw&d=",day);
  OTC<-fromJSON(OTC_path);
  # names(OTC);
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
    
    #資料整理
    D_totalbyShares<-c(6,7,8)
    totalbyShares<-as.data.frame(totalbyShares)
    totalbyDolars<-as.data.frame(totalbyDolars)
    #將該日資料 除個股資料以外 將資料 彙整成一筆 並與其他日期合併
    #彙整成一筆
    OTCCTtotal_Day<-cbind(day,TF,OTCRow,t(slice(totalbyShares,-D_totalbyShares)),t(slice(totalbyDolars,1:5)))
    #並與其他日期合併
    OTCCTtotal<-rbind(OTCCTtotal,OTCCTtotal_Day)
    
    colnames(OTCData)<-c("代號","名稱","前資餘額(張)","資買","資賣",
                         "現償","資餘額","資屬證金","資使用率(%)","資限額",
                         "前券餘額(張)","券賣","券買","券償","券餘額",
                         "券屬證金","券使用率(%)","券限額","資券相抵(張)","備註")
    # ncol(OTCData)
    # [1] 20
    
    #file location#settinggggggggggggggggggggggggggggggggggggggggggggggggggggg
    OTCCT_path<-paste0(Upath,"EXdata/CreditTransactions/OTCCT",dayoutput,".csv")
    #write.csv file
    write.csv(OTCData,file = OTCCT_path,fileEncoding="UTF-8")
  }
}
colnames(OTCCTtotal)<-c("day","TF","OTCRow","前資餘額(張)","資買","資賣",
                     "現償","資餘額","前券餘額(張)","券賣","券買",
                     "券償","券餘額","前券餘額(張)","券賣","券買",
                     "券償","券餘額")#17
#file location#settinggggggggggggggggggggggggggggggggggggggggggggggggggggg
OTCCTtotal_path<-paste0(Upath,"EXdata/CreditTransactions/OTCCTtotal.csv")
#write.csv file
write.csv( OTCCTtotal,file = OTCCTtotal_path,fileEncoding="UTF-8")

