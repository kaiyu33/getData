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
A<-read.xlsx("F:/1999Q1.xls",1)
library(dplyr)
slice(A,10:20)



#disk location
Upath<-paste0("F:/")
#file location
#x1_path<-paste0(Upath,"EXdata/FinancialInformation/1999Q1.xls")
x1_path<-paste0(Upath,"1999Q1.xls")

read.xls("F:\1999Q1.xls", sheet=1)

#read file
csvv<-
  read.csv(perl=F:/,x1_path,sheet =CC881, header = FALSE)
csvv
csvv<-select(csvv,"file"=V1)
csvv<-mutate(csvv,"ID"=substring(csvv$file,1,4))
#colnames(csvv)<-c("ID")