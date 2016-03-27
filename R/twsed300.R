x_path<-"file:///C:/Users/kai/Desktop/0012.csv"
readBin(x_path, "raw", n = 3L)
#可查編碼BOM
readLines(file(x_path, encoding = "BIG5"), n = 6)
#編碼錯誤會出現錯誤訊息且不顯示
x1_path<-"C:/Users/kai/Desktop/0012.csv"
A<-read.table(x1_path,header = FALSE,sep = ",",stringsAsFactors = FALSE)
slice(A,1:5)

colnames(A)
library(dplyr)
slice(A,1)
sapply(A, "[[",1)

#B<-sub("↓",replacement="",A$V11)
#C<-sub("↑",replacement="",B)
#刪除符號:↓,↑  @成交金額(A$V11)
#改寫成sub("↑",replacement="",sub("↓",replacement="",A$V11))

D<-mutate(A,"E"=strsplit(A$V1,"/"),"vol"=sub("↑",replacement="",sub("↓",replacement="",A$V11)))
D[[34]][[1]]<-c("year","month","day")
#class(D[[34]][[1]])="character"
#檢查:D[[34]][[1]]
F<-select(D,"time"=E,"price"=as.numeric(V5),as.numeric(vol))

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
