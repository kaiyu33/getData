install.packages("PerformanceAnalytics")
suppressPackageStartupMessages(library(PerformanceAnalytics))
chart.Correlation(iris[-5],bg=iris$Species,pch=21)
#'產生數據關係圖表

round(ca<-cor(attitude),2)
symnum(ca)
heatmap(ca,symm=TRUE,margins=c(7,7))
#'以顏色為程度之對應表