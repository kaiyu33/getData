#install.packages("quantmod")
library(quantmod)

#x_path<-"file:///C:/Users/Student/Desktop/DATABASE/tw0050.csv"
 x_path<-"file:///F:/tw0050.csv"
readBin(x_path, "raw", n = 3L)
#可查編碼BOM
readLines(file(x_path, encoding = "BIG5"), n = 6)
#編碼錯誤會出現錯誤訊息且不顯示
# x1_path<-"C:/Users/Student/Desktop/DATABASE/tw0050.csv"
x1_path<-"F:/tw0050.csv"
tw0050<-read.csv(x1_path,stringsAsFactors = FALSE)
tw0050<-mutate(tw0050,NO=paste0("`",tw0050[[1]],".TW`",sep = ""))

A<-NULL
AX<-c()
AY<-c()
twstock<-c()
A<-for (i in 1:50) {
  Y<-  function(x){
    Z<-cat("`",sapply(tw0050,'[[',i)[1],".TW`",sep = "")
    getSymbols("Z") }
  Y<-  function(x){cat("`",sapply(tw0050,'[[',i)[1],".TW`",sep = "") }
Y<-cat("`",sapply(tw0050,'[[',i)[1],".TW`",sep = "")
#  AX[i]<-cat("`",sapply(tw0050,'[[',i)[1],".TW`",sep = "")
#  AX[i]<-paste0("`",sapply(tw0050,'[[',i)[1],".TW`")
#  AX[i]<-print("`",sapply(tw0050,'[[',i)[1],".TW`",sep = "")
Y<-cat("`",sapply(tw0050,'[[',i)[1],".TW`",sep = "")
Y<-paste0("`",sapply(tw0050,'[[',i)[1],".TW`")
Y<-function(x) {
  Z<-tw0050[[7]][x]
  getSymbols(Z)}
  sub("'",replacement="","fwserfg'54'sef")
  AX[1]
  AZ
  #台股
  stock<-paste(AX[i])
  getSymbols(stock)
  i<-1
  tmp<-paste("tw",sapply(tw0050,'[[',i)[1],sep = "")
  tmp<-stock
  
  #均線資料
  ma_20<-runMean(tw2317[,4],n=20)   
  ma_60<-runMean(tw2317[,4],n=60)
  
  #符合ma_20>ma_60則1(否:0),延遲一天
  position<-Lag(ifelse(ma_20>ma_60, 1,0))
  #(log(今天收盤價/昨天收盤價),即10^"2.2e-02"之指數)*(是否持有:1,0)
  return<-ROC(Ad(tw2317))*position
  #期間
  return<-return['2007-04-10/2013-12-31']
  #(這裡運用國中數學:log(a)+log(b)=log(ab)，exp(log(ab))=ab)將持有期間之所有數字相乘
  rtw2317<-exp(cumsum(return))
}

#台股
stock<-paste(`2317.TW`)
getSymbols(stock)
tw2317<-stock

#均線資料
ma_20<-runMean(tw2317[,4],n=20)   
ma_60<-runMean(tw2317[,4],n=60)

#符合ma_20>ma_60則1(否:0),延遲一天
position<-Lag(ifelse(ma_20>ma_60, 1,0))
#(log(今天收盤價/昨天收盤價),即10^"2.2e-02"之指數)*(是否持有:1,0)
return<-ROC(Ad(tw2317))*position
#期間
return<-return['2007-04-10/2013-12-31']
#(這裡運用國中數學:log(a)+log(b)=log(ab)，exp(log(ab))=ab)將持有期間之所有數字相乘
rtw2317<-exp(cumsum(return))
