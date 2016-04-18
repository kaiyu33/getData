#'readTWSEEx_dividend
#'
#'前身:JAVA_getTwseData3

#disk location#TW50
Upath<-paste0("D:/")
#file location
tw50_dir_path<-paste0(Upath,"EXdata/tw0050.csv")
#read file
getStockNumtw50<-read.csv(tw50_dir_path,stringsAsFactors = FALSE)# NOT UTF-8

#disk location#TW50
Upath<-paste0("D:/")
#file location
tw_dir_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/getStockNumFI/")
tw_dir<-dir(tw_dir_path,"csv$")

#disk location
Upath<-paste0("D:/")
#file location
ED_dir_path<-paste0(Upath,"EXdata/Ex_dividend/")
ED_dir<-dir(ED_dir_path,"csv$")

#讀檔案
for (k in 94:104) {
  Ex_dividend_year<-paste0(k,"Ex_dividend")
  #read file
  getStockNumED_path<-paste0(ED_dir_path,Ex_dividend_year,".csv")###############################################choice read file
  # getStockNumED<-read.csv(getStockNumED_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8
  Ex_dividend_File<-paste("Ex_dividend",k,sep=".")
  assign(Ex_dividend_File,read.csv(getStockNumED_path,fileEncoding="UTF-8",stringsAsFactors = FALSE))
}
#最後一個即可
colnames(Ex_dividend.104)<-c("num","ID","name","dividend_Y","basicDate","dividend_S_Earnings","dividend_S_Law","dividend_S_Date","employee_S1","employee_S2","employee_S3","employee_S4","dividend_C_Earnings","dividend_C_Law","dividend_C_Date","dividend_C_PaymentDate","employee_C_total","CashCapitalIncrease_S","CashCapitalIncrease_Rate","CashCapitalIncrease_Price","DS_C","Announcement_Date","Announcement_Time","Denomination_Shares")

# c("num","公司代號","公司名稱","股利所屬年度","權利分派基準日",
# 
# "餘轉增資配股(元/股)","法定盈餘公積、資本公積轉增資配股(元/股)",
# "配股總股數(股)","配股總金額(元)","配股總股數佔盈餘配股總股數之比例(%)","員工紅利配股率",
# "盈餘分配之股東現金股利(元/股)","法定盈餘公積、資本公積發放之現金(元/股)","除息交易日",
# "現金股利發放日","員工紅利總金額(元)","現金增資總股數(股)","現金增資認股比率(%)","現金增資認購價(元/股)",
# "現金增資認購價(元/股)",
# 
# "董監酬勞(元)","公告日期","公告時間","普通股每股面額")

#執行檔案
# assign(getNumFile,NULL)
# View(get(paste("Ex_dividend",k,sep=".")))

# for (i in 1:nrow(getStockNumtw50)) {#TW50
  # getNum<-getStockNumtw50[i,1]
  for (i in 1:length(tw_dir)) {#TW
  getNum<-substr(tw_dir[i],1,4)
  l<-0
  for (year in 94:104) {
    readFile<-paste("Ex_dividend",k,sep=".")
    for (j in 1:nrow(get(paste("Ex_dividend",k,sep=".")))) {#待檔案筆數
      if (get(paste("Ex_dividend",k,sep="."))[j,2]==getNum) {#找相同代號
        getNumFile<-paste0("TW.",getNum)
        if(l>0){#已有資料
          # assign(getNumFile,get(paste("Ex_dividend",k,sep="."))[j,])
          assign(getNumFile,rbind(get(getNumFile),get(paste("Ex_dividend",k,sep="."))[j,]))
        }else if (l==0) {#第一次
          l<-1
          assign(getNumFile,get(paste("Ex_dividend",k,sep="."))[j,])
        }
        
      }
    }  
  }
}

# TW.2227
# grepl("^TW",ls())

get(ls(pattern = "^TW")[1])
#存檔
for (m in 1:length(ls(pattern = "^TW"))) {
  #   getNum<-getStockNumtw50[i,1]
  #   getNumFile<-paste0("TW.",getStockNumtw50[i,1])
  new_path00<-paste0(Upath,"EXdata/Ex_dividend/getStockNumED/",ls(pattern = "^TW")[m],".csv")
  write.csv(get(ls(pattern = "^TW")[m]),file = new_path00)
}


