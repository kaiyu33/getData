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
Upath<-paste0("F:/")
#file location
x1_path<-paste0(Upath,"1999Q1.xls")
A<-read.xlsx(x1_path,1,encoding="UTF-8")
library(dplyr)
body<-slice(A,12:521)#body
#count(unique(body)[2])
#count(body)
unique(body)#去除重複行(空白) 但是仍有一行空白
unique(body)[2]
View(A)



