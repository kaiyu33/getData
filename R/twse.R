x_path<-"file:///F:/X012317.csv"
readBin(x_path, "raw", n = 3L)
#可查編碼BOM
readLines(file(x_path, encoding = "BIG5"), n = 6)
#編碼錯誤會出現錯誤訊息且不顯示
x1_path<-"F:/X012317.csv"
A<-read.table(x1_path,header = FALSE,sep = ",",stringsAsFactors = FALSE)
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
D<-mutate(C,"A1"=strsplit(V1,"/"))
D[[5]][[1]]<-c("year","month","day")
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
~~~
D<-  select(C,as.integer(V2),as.integer(V3),as.integer(V4),as.integer(V60))
  
suppressPackageStartupMessages(library(PerformanceAnalytics))
chart.Correlation(E)
mode(C$V3)

as.numeric(C$V3)

data(managers)
chart.Correlation(managers[,1:8], histogram=TRUE, pch="+")
~~~
  G<-list(
  for (i in 3:59) {
    cat('"as.numeric(C$V',i,')"', sep = "")
    #sep間隙改為什麼
    if(i!=59)cat(",")
  }
  for (i in 3:59) {
    "as.numeric(C$V"+i+")"
    #sep間隙改為什麼
    #if(i!=59)cat(",")
  }
  )
  for (i in G) {
    
  }
  
  F<-select(C,"X"=as.integer(V3),as.integer(V4),as.integer(V5),as.integer(V6),as.integer(V7),as.integer(V8),as.integer(V9),as.integer(V10))
,as.integer(V11),as.integer(V12),as.integer(V13),as.integer(V14),as.integer(V15),as.integer(V16),as.integer(V17),as.integer(V18),as.integer(V19),as.integer(V20),as.integer(V21),as.integer(V22),as.integer(V23),as.integer(V24),as.integer(V25),as.integer(V26),as.integer(V27),as.integer(V28),as.integer(V29),as.integer(V30),as.integer(V31),as.integer(V32),as.integer(V33),as.integer(V34),as.integer(V35),as.integer(V36),as.integer(V37),as.integer(V38),as.integer(V39),as.integer(V40),as.integer(V41),as.integer(V42),as.integer(V43),as.integer(V44),as.integer(V45),as.integer(V46),as.integer(V47),as.integer(V48),as.integer(V49),as.integer(V50),as.integer(V51),as.integer(V52),as.integer(V53),as.integer(V54),as.integer(V55),as.integer(V56),as.integer(V57),as.integer(V58),as.integer(V59)
  Z<-as.integer(sapply(D[1], "[",1:19))
  Z<-as.integer(sapply(D[2], "[",1:19))
  Z<-as.integer(sapply(D[3], "[",1:19))
  Z<-as.integer(sapply(D[4], "[",1:19))
as.numeric(C[[2]])
  mode(C[[2]][1])
mode(D$V4[3])
F$X[3]
mode(F$X[3])

sapply(D[1], "[",1:19)
D[1]
# as.numeric(V)
G<-slice(F,2:301)

plot(x=G$vol,y=G$price)
#價量圖

line(x=G$vol,y=G$price)
model=lm(G$price~G$vol) #建立迴規模式lm(Y~X)，並命名為model

summary(model) #檢視迴歸統計量
summary.aov(model)
abline(lm(G$price~G$vol))


F1<-select(D,"price"=as.numeric(V5),as.numeric(vol),as.numeric(V2),as.numeric(V3),as.numeric(V4))
H<-select(F1,-E)
plot(F1)
attach(F1)
plot(~F1$V2,H$V3,H$V4,H$V5)

slice(F1,1:5)
sapply(D, "[[",1)
