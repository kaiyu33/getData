library(dplyr)
#'http://ic.tpex.org.tw/introduce.php?ic=T000 資料來源
NUM<-read.csv("C:/Users/kai/Desktop/NUM.csv",header = TRUE,stringsAsFactors = FALSE)

colnames(NUM)<-c("ID_name","a","b","c","d","e","f","g","h","i","j")
D<-NULL
for (a in 1:20) {
  C<-c("上市",sapply(strsplit(NUM$ID_name," "),"[",1)[a],sapply(strsplit(NUM$ID," "),"[",2)[a])
  D<-rbind(D,C)
}
for (a in 23:29) {
  C<-c("上櫃",sapply(strsplit(NUM$ID_name," "),"[",1)[a],sapply(strsplit(NUM$ID," "),"[",2)[a])
  D<-rbind(D,C)
}
colnames(D)<-c("market","ID","name")
rownames(D)<-c(1:nrow(D))

TYPE<-read.csv("C:/Users/kai/Desktop/TYPE.csv",header = FALSE,stringsAsFactors = FALSE)
#class(TYPE)
#View(TYPE)

G<-NULL
for (b in c(1,5,12,17,23)){
  E<-TYPE[b,1]
  G<-rbind(G,E)
}
#G

I<-as.data.frame()
<-NULL
for (d in 1:28) {
  for (c in 2:6) {
    if(TYPE[d,c]!=""){
      H<-c(ifelse(TYPE[d,1]=="",substring(TYPE[d-1,1],3,4),substring(TYPE[d,1],3,4)),TYPE[d,c],
           if (d<5) {
             G[1]
           }else if (5<=d&d<12) {
             G[2]
           }else if (12<=d&d<17) {
             G[3]
           }else if (17<=d&d<23) {
             G[4]
           }else if (23<=d) {
             G[5]
           }
           )
      I<-rbind(I,H)
    }
  }
}
#I
colnames(I)<-c("market_I","name_I","TYPE")
rownames(I)<-c(1:nrow(I))
I<-as.data.frame(I)#轉data.frame不可同名,要先改
D<-as.data.frame(D)
J<-full_join(x=D,y=I,by=c("name"="name_I"))#會有警告,不須理會
K<- unique(J)
rownames(K)<-c(1:nrow(K))

#查重複的欄位
L<-select(K,name)
rownames(L)<-c(1:nrow(L))
M<- unique(L)
rownames(M)<-c(1:nrow(M))
O<-NULL
for (e in 1:68) {
  if(K[e,3]==K[e+1,3]){
    N<-K[e+1,]
    O<-rbind(O,N)}
}
#'榮運*3,中航*3,台航*1

rownames(O)<-c(1:nrow(O))
for (f in 1:nrow(O)) {
  if (O[f,3]==O[f+1,3]&&O[f,3]==O[f+2,3]) {
    P<-O[f+1,5]
    Q<-cbind(O[f,],P)
  }else if (O[f,3]==O[f+1,3]&&O[f,3]!=O[f+2,3]) {
    P<-O[f+1,5]
    Q<-cbind(Q,P)
  }else{
    Q<-rbind(Q,O[f+1,])
  }
}

for (f in 1:nrow(O)) {
  if (O[f,3]==O[f+1,3]&&O[f,3]==O[f+2,3]) {
    P<-O[f+1,5]
    Q<-cbind(O[f,],P)
  }else if (O[f,3]==O[f+1,3]&&O[f,3]!=O[f+2,3]) {
    P<-O[f+1,5]
    Q<-cbind(Q,P)
  }else{
    Q<-rbind(Q,O[f+1,])
  }
}


substr(TYPE[[1]][1],-1,-5)

A<-read.csv("C:/Users/kai/Desktop/NUM.csv",header = TRUE,stringsAsFactors = FALSE)
B<-read.csv("C:/Users/kai/Desktop/NUM.csv",header = TRUE,stringsAsFactors = FALSE)
colnames(A)<-c("a","s","c","d","e","f","g","h","i","j","k")
colnames(B)<-c("a1","s1","c1","d1","e1","f1","g1","h1","i1","j1","k1")
A$s1=B$s1
A=A[,c("a","s","s1")]#BY許懷中
