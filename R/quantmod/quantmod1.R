#'套件:quantmod
#'個股K線
#
#install.packages("quantmod")
library(quantmod)

#'美股-AAPL
#'直接取用Yahoo Finance 
getSymbols("AAPL")
chartSeries(AAPL)
chartSeries(AAPL["2000-01::2012-06"],theme="white")
#均線資料
ma_20<-runMean(AAPL[,4],n=20)   
ma_60<-runMean(AAPL[,4],n=60)
#加入均線
addTA(ma_20,on=1,col="blue")
addTA(ma_60,on=1,col="red")
addBBands()
#進行策略回測

#符合ma_20>ma_60則1(否:0),延遲一天
position<-Lag(ifelse(ma_20>ma_60, 1,0))
#(log(今天收盤價/昨天收盤價),即10^"2.2e-02"之指數)*(是否持有:1,0)
return<-ROC(Cl(AAPL))*position
#期間
return<-return['2007-03-30/2013-12-31']
#(這裡運用國中數學:log(a)+log(b)=log(ab)，exp(log(ab))=ab)將持有期間之所有數字相乘
return<-exp(cumsum(return))
#損益圖畫出
plot(return)

#台股
getSymbols("2317.TW")
chartSeries(`2317.TW`)
#chartSeries(`2317.TW`["2000-01::2012-06"],theme="white")

#均線資料
ma_20<-runMean(`2317.TW`[,4],n=20)   
ma_60<-runMean(`2317.TW`[,4],n=60)
#加入均線
addTA(ma_20,on=1,col="blue")
addTA(ma_60,on=1,col="red")
addBBands()
#Bollinger%b = (Close-LowerBound) / (UpperBound-LowerBound)
addBBands(draw="p")
addMACD()
#進行策略回測

#符合ma_20>ma_60則1(否:0),延遲一天
position<-Lag(ifelse(ma_20>ma_60, 1,0))
#(log(今天收盤價/昨天收盤價),即10^"2.2e-02"之指數)*(是否持有:1,0)
return<-ROC(Ad(`2317.TW`))*position
#期間
return<-return['2007-04-10/2013-12-31']
#(這裡運用國中數學:log(a)+log(b)=log(ab)，exp(log(ab))=ab)將持有期間之所有數字相乘
return<-exp(cumsum(return))
#損益圖畫出
plot(return)

