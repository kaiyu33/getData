x_path<-"file:///C:/Users/Student/Desktop/DATABASE/X032317.csv"
# x_path<-"file:///F:/X032317.csv"
readBin(x_path, "raw", n = 3L)
#可查編碼BOM
readLines(file(x_path, encoding = "BIG5"), n = 6)
#編碼錯誤會出現錯誤訊息且不顯示
x1_path<-"C:/Users/Student/Desktop/DATABASE/X032317.csv"
# x1_path<-"F:/X032317.csv"
A<-read.csv(x1_path,stringsAsFactors = FALSE)
slice(A,1:5)
#'須先library(dplyr)
#'head(A)
colnames(A)<-c("stock_id","YMD","P_S","P_H","P_L","P_E","V_T","V_1000dolar","return%","Turnover%","NoS","PM_Mdolar","final_PP","final_SP","return%_Ln",
               "S/M_V%","turnover/S_V%","TransactionamountPen","P/E_TSE","P/E-TEJ","P/B_TSE","P/B_TEJ","stop_H/L","stock-salesratioTEJ","dividendyieldTSE",
               "cash%","P_D","NotestockA","DisposalstockD","FulldeliveryY","market")
slice(A,1)
sapply(A, "[[",1)

#B<-sub("↓",replacement="",A$V11)
#C<-sub("↑",replacement="",B)
#刪除符號:↓,↑  @成交金額(A$V11)
#改寫成sub("↑",replacement="",sub("↓",replacement="",A$V11))
#B<-slice(A,1:20)
#C<-slice(B[1:4],-1)
#as.character(sapply(C[1], "[",1:19))
#D<-select(C,-YMD,"Y"=lapply(E,"[",3))

B<-mutate(A,"Year"=lapply(strsplit(A$YMD,"/"),"[",1)
          ,"Month"=lapply(strsplit(A$YMD,"/"),"[",2)
          ,"Day"=lapply(strsplit(A$YMD,"/"),"[",3))
C<-select(B,32:34,3:22,24:27)
D<-sub(",",replacement="",C)
chart.Correlation(C[4:27])
