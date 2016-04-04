#start
#'getStockNumFI
#'
#'繼承自:TotalTable
#'
#'繼承自:StockFI
#'階段二:將各財報會及於一個CSV檔
#'
#'繼承自:本檔:getStockNumFI
#'三種做法

#儲存及改變環境設定
old.options=options()
options(stringsAsFactors = FALSE)

starttime_all<-proc.time()

#install.packages("xlsx")
library(xlsx)
library(dplyr)
#disk location
Upath<-paste0("F:/")
#file location
getStockNumFI_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/StockFI.csv")
#read file
#getStockNumFI<-read.csv(FI_path,encoding="big5",stringsAsFactors = FALSE)#<-big5
getStockNumFI<-read.csv(getStockNumFI_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8

# #個股號碼 Id meth:1  請關閉  #個股號碼 Id meth:2 setting-START    SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
# getStockNum<-1101

# #個股號碼 Id meth:2 setting-START  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
# runID<-NULL
# for (file_year in 1999:2015) {
#   for (file_QNum in 1:4) {
#     runID<-cbind(runID,paste0(file_year,"Q",file_QNum))
#   }
# }
# #以哪個年度的Id為基準尋找
# runIDNum<-67
# 
# #file location  BY Company
# getStockNum_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/",runID[runIDNum],"_Company.csv")
# #read file
# #getStockNumFI<-read.csv(FI_path,encoding="big5",stringsAsFactors = FALSE)#<-big5
# getStockNum_file<-read.csv(getStockNum_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8
# 
# #共幾筆資料
# RowgetStockNumTotal<-sapply(count(getStockNum_file),"[",1)
# 
# #個股號碼 Id meth:2 setting-END   EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

#個股號碼 Id meth:3  請關閉  #個股號碼 Id meth:2 setting-START    SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
getOnlyStockNumFI<-unique(getStockNumFI[2])
RowgetStockNumTotal<-sapply(count(getOnlyStockNumFI),"[",1)


#meth:2 3  最大迴圈 選其中一個
for (RowgetStockNum in 1:RowgetStockNumTotal) {
  starttime<-proc.time()
  
  # #meth:2  最大迴圈   2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
  # getStockNum<-sapply(getStockNum_file[2],"[",RowgetStockNum)
  #meth:3  最大迴圈   3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
  getStockNum<-sapply(getOnlyStockNumFI,"[",RowgetStockNum)
  
  #大迴圈 位置 1     LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
  #大迴圈 START   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
  #starttime<-proc.time()
  
  #colnames(getStockNumFI)
  
  #共幾筆資料
  RowNumTotal<-sapply(count(getStockNumFI),"[",1);
  
  body1<-NULL;
  
  for (RowNum in 1:RowNumTotal) {
    if (sapply(getStockNumFI,"[",RowNum)[2]==getStockNum) {
      body1<-rbind(body1,sapply(getStockNumFI,"[",RowNum))
      #sapply(getStockNumFI[1],"[",1)
      #getStockNumFI[1,]
    }
  }
  #View(body1)
  
  if (is.null(body1)!=1) {
    #共幾筆資料 body1 取最新名字Name
    RowNumTotal_body1<-nrow(body1)
    #RowgetStockNum=360 @ 2015Q3 "東<U+78B1>"  
    if (getStockNum!=1708) {
      #write.csv file location 
      body_path1<-paste0(Upath,"EXdata/FinancialInformation/FIData/getStockNumFI/",getStockNum,body1[RowNumTotal_body1,3],".csv")
    }else if (getStockNum==1708) {
      body1<-as.data.frame(body1)
      Name<-sub("<U[+]78B1>",replacement="鹼",body1$Name)
      #"碱"無法顯示 會顯示為<U+78B1>
      body1<-select(body1,-1,-3)
      body1<-mutate(body1,"Name"=Name)
      body1<-select(body1,1:2,20,3:19)
      body1
      #write.csv file location 
      body_path1<-paste0(Upath,"EXdata/FinancialInformation/FIData/getStockNumFI/",getStockNum,"東碱.csv")
    }
    #write.csv file location 用最舊的名字Name
    #body_path1<-paste0(Upath,"EXdata/FinancialInformation/FIData/getStockNumFI/",getStockNum,body1[1,3],".csv")
    
    #write.csv file
    write.csv(body1,file = body_path1,fileEncoding="UTF-8") 
  }
  #顯示每次所需時間(秒)
  runtime<-proc.time()-starttime 
  #print(paste(getStockNum,body1[RowNumTotal_body1,3],RowgetStockNum," FINISHED !!!"," ( ",round(runtime[1],2),round(runtime[2],2),round(runtime[3],2)," ) "))
  cat(paste(getStockNum,body1[RowNumTotal_body1,3],RowgetStockNum,"\tFINISHED !!! (",round(runtime[1],2),"\t",round(runtime[2],2),"\t",round(runtime[3],2),")\n"))
  
  #大迴圈 END  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
  
}
#大迴圈 位置 2     LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL

runtime_all<-proc.time()-starttime_all
print(starttime_all)
print(proc.time())
print(runtime_all)

# 還原原先環境設定
options(old.options)

#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX