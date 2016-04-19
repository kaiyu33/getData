#'getYData
#'
#'TWSE PS.1107 沒有
#'
#'繼承:tw50ReturnOnInvestment
#'
#'子連結:packages xts
#'
#'繼承自:multiquantmod1
#'
#'改版:2
#'改以使用tw0050.csv檔案
#'增加時間點 default day 距今300天
#'
#'改版:3
#'增加APP get data write
#'改以以日期做為選擇時間點 而非距今幾日
#'轉xts 用xts的方法 更快速簡潔
#'欄位調整 VOL=0刪除
#'建立周報酬報表
#'
#'跳過改版4
#'
#'改版:5
#'

#install.packages("quantmod")
# library(dplyr)
library(quantmod)



#disk location
Upath<-paste0("D:/")

# #meyhod:1 read dir
# tw50_path<-paste0(Upath,"data/new/tw50/")
# tw50_dir<-dir(tw50_path)
# # tw50_data_path<-paste0(tw50_path,tw50_dir[1])
# # tw50_data<-read.csv(tw50_data_path)

#disk location
Upath<-paste0("D:/")
#file location
FI_dir_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/getStockNumFI/")
FI_dir<-dir(FI_dir_path,"csv$")

for (i in 1:length(FI_dir)) {
  Symbols.name<-paste0(substr(FI_dir[i],1,4),".TW")####################tw50_dir[1]  for loop

#read NUM
getStockNumFI_path<-paste0(FI_dir_path,FI_dir[i])###############################################choice read file

  #meyhod:3 make function on app
  #datasetInput <- reactive({#########################################################################################################app start
  # Symbols.name<-paste0(input$ID,".TW")####################app use
  
  
  verbose <- FALSE###############################################################################################
  tmp <- tempfile()
  on.exit(unlink(tmp))
  
  # beforeDay<-300##########################取距離今天幾天前
  # default.from <- as.Date(as.numeric(Sys.Date())+25569-beforeDay, origin = "1899-12-30")
  # default.to <- Sys.Date()
  
  # from <- if(is.null(from)) default.from else from
  # to <- if(is.null(to)) default.to else to
  # 
  # from.y <- as.numeric(strsplit(as.character(as.Date(from,origin='1970-01-01')),'-',)[[1]][1])
  # from.m <- as.numeric(strsplit(as.character(as.Date(from,origin='1970-01-01')),'-',)[[1]][2])-1
  # from.d <- as.numeric(strsplit(as.character(as.Date(from,origin='1970-01-01')),'-',)[[1]][3])
  # to.y <- as.numeric(strsplit(as.character(as.Date(to,origin='1970-01-01')),'-',)[[1]][1])
  # to.m <- as.numeric(strsplit(as.character(as.Date(to,origin='1970-01-01')),'-',)[[1]][2])-1
  # to.d <- as.numeric(strsplit(as.character(as.Date(to,origin='1970-01-01')),'-',)[[1]][3])
  
  yahoo.URL <- "http://ichart.finance.yahoo.com/table.csv?"
  download.file(paste(yahoo.URL,
                      "s=",Symbols.name,
                      # "&a=",from.m,
                      # "&b=",sprintf('%.2d',from.d),
                      # "&c=",from.y,
                      # "&d=",to.m,
                      # "&e=",sprintf('%.2d',to.d),
                      # "&f=",to.y,
                      # "&g=d&q=q&y=0",
                      # "&z=",Symbols.name,"&x=.csv",
                      sep=''),destfile=tmp,quiet=!verbose)
  #長度超過200警告 from quantmod
  
  tw50_data <- read.csv(tmp,stringsAsFactors=FALSE)
  
  tw50_data<-filter(tw50_data,  Volume > 0)#去除VOL=0
  # tw50_data<-arrange(tw50_data,desc(Date))#一時間排列  進入xts一樣沒用
  
  sample.xts<-xts(as.matrix(tw50_data[,-1]),
                  as.Date(tw50_data[,1]),
                  #as.POSIXct(fr[,1], tz=Sys.getenv("TZ")),
                  src='yahoo',updated=Sys.time())
  
  time(sample.xts[1])
  # [1] "2015-06-22"
  
  attr(sample.xts, "dimnames") #等同於 dimnames(sample.xts)
  # [[1]]
  # NULL
  # 
  # [[2]]
  # [1] "Open"      "High"      "Low"       "Close"     "Volume"    "Adj.Close"
  
  attr(sample.xts, "dimnames")[[2]][6]<-"Adj"
  attr(sample.xts, "dimnames")[[2]][6]
  # [1] "Adj"
  
  # tw50_data<-mutate(tw50_data,"Open"=as.numeric(Open),"High"=as.numeric(High),"Low"=as.numeric(Low),"Close"=as.numeric(Close),"Volume"=as.numeric(Volume),"Adj"=as.numeric(Adj.Close))
  # 
  # colnames(tw50_data)
  # # [1] "Date"      "Open"      "High"      "Low"       "Close"     "Volume"    "Adj.Close" "Adj"
  # rownames(tw50_data)<-tw50_data[[1]]
  # # [1] "2007-01-02" "2007-01-03" "2007-01-04" "2007-01-05" "2007-01-06" "2007-01-07" "2007-01-08" "2007-01-09" "2007-01-10" "2007-01-11" "2007-01-12"
  # 
  # # c("date","Open","High","Low","Close","Volume")
  # sample.xts<-select(tw50_data,-1,-7)
  # 
  # sample.xts <- as.xts(sample.xts, descr='my new xts object')
  # # colnames(sample.xts)
  # # [1] "Open"   "High"   "Low"    "Close"  "Volume" "Adj"  
  # # is.xts(sample.xts)
  
  
  #})#################################################################################################################################app END
  output1<-paste0("TW.",substr(FI_dir[i],1,4))
  assign(output1,sample.xts)
}
#result Example:
TW.2317