x1_path<-"C:/Users/Andy/Desktop/002317.csv"
AA<-read.csv(x1_path,stringsAsFactors = FALSE)

BB<-c(0,AA[["股價漲跌.元."]])
CC<- BB[2:491]

A<-cbind(CC,AA)

x<-NULL
for(a in 2:24){
    y<-colnames(A)[a]
    x<-paste(c(x, y),sep = "", collapse=" + ")}


  
train<- as.data.frame(sapply(A, "[", 2:400))
test<- as.data.frame(sapply(A, "[", 401:490))



m<-lm(CC~最高價.元. + 最低價.元.+ 成交量.千股. + 成交值.千元. + 報酬率. + 週轉率. + 流通在外股數.千股. + 市值.百萬元. + 最後揭示買價 + 最後揭示賣價 + 報酬率.Ln + 市值比重. + 成交值比重. + 成交筆數.筆. + 本益比.TSE + 本益比.TEJ + 股價淨值比.TSE + 股價淨值比.TEJ + 股價營收比.TEJ + 股利殖利率.TSE + 現金股利率,train)


p<-predict(m, test, se.fit = TRUE)
pvalue<-p[["fit"]]
ori<-test[["CC"]]
pvalueB<-ifelse(pvalue>=0,1,0)
oriB<-ifelse(ori>=0,1,0)

compare<-ifelse(oriB==pvalueB,1,0)
mean(compare)


p<-predict(m, train, se.fit = TRUE)
pvalue<-p[["fit"]]
ori<-train[["CC"]]
pvalueB<-ifelse(pvalue>=0,1,0)
oriB<-ifelse(ori>=0,1,0)

compare<-ifelse(oriB==pvalueB,1,0)
mean(compare)


