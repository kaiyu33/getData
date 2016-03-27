x_path<-"file:///C:/Users/Student/Desktop/DATABASE/X012317.csv"
# x_path<-"file:///F:/X012317.csv"
readBin(x_path, "raw", n = 3L)
#可查編碼BOM
readLines(file(x_path, encoding = "BIG5"), n = 6)
#編碼錯誤會出現錯誤訊息且不顯示
x1_path<-"C:/Users/Student/Desktop/DATABASE/X012317.csv"
# x1_path<-"F:/X012317.csv"
A<-read.csv(x1_path,stringsAsFactors = FALSE)
slice(A,1:5)
#'須先library(dplyr)
#'head(A)
colnames(A)
slice(A,1)
sapply(A, "[[",1)

#B<-sub("↓",replacement="",A$V11)
#C<-sub("↑",replacement="",B)
#刪除符號:↓,↑  @成交金額(A$V11)
#改寫成sub("↑",replacement="",sub("↓",replacement="",A$V11))
B<-slice(A,1:20)
C<-slice(B[1:4],-1)
#as.character(sapply(C[1], "[",1:19))

colnames(C)<-c("YMD","p","vol(t)","vol(p)")
#D<-select(C,-YMD,"Y"=lapply(E,"[",3))

D<-mutate(C,"Year"=lapply(strsplit(C$YMD,"/"),"[",1)
          ,"Month"=lapply(strsplit(C$YMD,"/"),"[",2)
          ,"Day"=lapply(strsplit(C$YMD,"/"),"[",3))
E<-select(D,5:7,2:4)

chart.Correlation(E[4:6])


#colnames(D[5])<-c("year","month","day")
#class(D[[34]][[1]])="character"
#檢查:D[[34]][[1]]
sapply(D,"[",1)
E<-select(D,V2,V3,V4)
F<-numeric(E)
mode(E[1,1])
E[1,1]>50
plot(x=A$V2,y=A$V3)
mode(E[1])
mode(E$V2)