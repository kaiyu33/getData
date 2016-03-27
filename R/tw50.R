library(dplyr)
#disk location
Upath<-paste0("D:/")
#file location with complete data
x1_path<-paste0(Upath,"data/new/00/00.csv")
#read file
csvv<-read.csv(x1_path,header = TRUE,stringsAsFactors = FALSE)
csvv<-select(csvv,"file"=V1)
csvv<-mutate(csvv,"ID"=substring(csvv$file,1,4))
#colnames(csvv)<-c("ID")


#file location
exdata_path<-paste0(Upath,"EXdata/tw0050.csv")
#read file
tw50<-read.csv(exdata_path,header = TRUE,stringsAsFactors = FALSE)
#rename colnames
colnames(tw50)<-c("A","name","IndustryClass","SharesOutstanding","FreeFloat","indexWeight")
tw50<-mutate(tw50,"ID"=substring(tw50$A,1,4))
tw50<-select(tw50,ID,2:5)


#抓台灣50並且有完整資料的資訊
A<-inner_join(tw50,csvv,by=c("ID"="ID"))
#抓台灣50並且有"不"完整資料的資訊
B<-anti_join(tw50,csvv,by="ID")

#將台灣50有完整的資料存到"data/new/tw50/"資料夾內
#將資料不完整的存到"data/new/tw50/anti/"資料夾內
#在"data/new/tw50/anti/"資料夾內再有00資料夾,存待整理欄位表
D<-paste0(Upath,"data/new/")
newdata<-dir(D,"csv")
Dlength<-length(newdata)

for (a in 1:Dlength) {
  for (b in 1:nrow(A)) {
    if (substring(newdata[a],1,4)==A[b,1]) {
      new_path<-paste0(Upath,"data/new/tw50/",newdata[a])
      paste0(Upath,"data/new/",newdata[a]) %>%
      read.csv(header = TRUE,stringsAsFactors = FALSE) %>%
      write.csv(file = new_path)
    }else if(b<=nrow(B)){
      if(substring(newdata[a],1,4)==B[b,1]){
        new_pathanti<-paste0(Upath,"data/new/tw50/anti/",newdata[a])
        paste0(Upath,"data/new/",newdata[a]) %>%
        read.csv(header = TRUE,stringsAsFactors = FALSE) %>%
        write.csv(file = new_pathanti)
        
        new_path00<-paste0(Upath,"data/new/tw50/anti/00/",newdata[a])
        paste0(Upath,"data/new/00/",newdata[a]) %>%
        read.csv(header = TRUE,stringsAsFactors = FALSE) %>%
        write.csv(file = new_path00)
      }
    }
    
  }
}