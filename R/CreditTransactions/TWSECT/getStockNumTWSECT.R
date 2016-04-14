#'getStockNumTWSECT
#'
#'繼承自:getStockNumCT
#'
#'繼承自:crawler otc credirtransfer
#'
#start

library(dplyr)

starttime<-proc.time()

#disk location
Upath<-paste0("D:/")
#file location
getStockNumCT_path<-paste0(Upath,"EXdata/CreditTransactions/")
DIR<-dir(getStockNumCT_path,"^TWSECT20")
body1<-NULL;
colNameRunNum<-0
bodyNARow_num<-0
bodyNA<-NULL
# Sys.sleep(3)#正在抓取資料 為避免BUG用

#本迴圈是為了取得股票代碼-一般
getStockNumforCT_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/getStockNumFI/")
getStockNumforCT_DIR<-dir(getStockNumforCT_path)
# getStockNumforCT_RowNum<-1
for (getStockNumforCT_RowNum in 521:length(getStockNumforCT_DIR)) {#1改成58     7
  getStockNum<-paste0("'",substr(getStockNumforCT_DIR[getStockNumforCT_RowNum],1,4))
  
  body1<-NULL
  for (DIRnum in length(DIR):1) {#settinggggggggggggggggggggggggggggggggggggggggggggggggggggg
    
    getStockNumCT_path2<-paste0(Upath,"EXdata/CreditTransactions/",DIR[DIRnum])
    #read file
    getStockNumCT<-read.csv(getStockNumCT_path2,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8
    
    #大迴圈 位置 2     LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
    
    #大迴圈 START   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
    #starttime<-proc.time()
    
    #colnames(getStockNumCT)
    
    #共幾筆資料
    RowNumTotal<-sapply(count(getStockNumCT),"[",1);
    
    rowdata<-NULL
    
    
    if (getStockNum!=1708) {
      for (RowNum in 1:RowNumTotal) {
        if (sapply(getStockNumCT,"[",RowNum)[1]==getStockNum) {
          rowdata<-substr(DIR[DIRnum],7,14)
          for (colNum in 1:16) {
            rowdata<-cbind(rowdata,sapply(getStockNumCT,"[",RowNum)[colNum])
          }
          # rowdata<-cbind(DIR[DIRnum],sapply(getStockNumCT,"[",RowNum))
          body1<-rbind(body1,rowdata)
          
          # body1<-rbind(body1,sapply(getStockNumCT,"[",RowNum))
          
          #sapply(getStockNumCT[1],"[",1)
          #getStockNumCT[1,]
        }
      }
    }else if (getStockNum==1708) {
      for (RowNum in 1:RowNumTotal) {
        if (sapply(getStockNumCT,"[",RowNum)[1]==getStockNum) {
          rowdata<-cbind(substr(DIR[DIRnum],7,14),sapply(getStockNumCT,"[",RowNum)[4],"東鹼")
          for (colNum in 鹼:16) {
            rowdata<-cbind(rowdata,sapply(getStockNumCT,"[",RowNum)[colNum])
          }
          body1<-rbind(body1,rowdata)
        }
      }
    }
    
    colNameRunNum<-colNameRunNum+1
    if(colNameRunNum==1){
      colnames(body1)<-c("Date","代號","名稱","買進","賣出","現金償還","前日餘額","今日餘額","限額","買進","賣出","現券償還","前日餘額","今日餘額","限額","資券互抵","註記")
    }
    
    
    #View(body1)
    
    if (is.null(body1)!=1) {
      #共幾筆資料 body1 取最新名字Name
      RowNumTotal_body1<-nrow(body1)
      #RowgetStockNum=360 @ 2015Q3 "東<U+78B1>"  
      if (getStockNum!=1708) {
        #write.csv file location 
        body_path1<-paste0(Upath,"EXdata/CreditTransactions/CTData/getStockNumCT/",getStockNum,body1[1,3],".csv")
        # getStockNumCT_path<-paste0(Upath,"EXdata/CreditTransactions/")
      }else if (getStockNum==1708) {
        body1<-as.data.frame(body1)
        Name<-sub("<U[+]78B1>",replacement="鹼",body1$Name)
        #"碱"無法顯示 會顯示為<U+78B1>
        body1<-select(body1,-1,-3)
        body1<-mutate(body1,"Name"=Name)
        body1<-select(body1,1:2,20,3:19)
        body1
        #write.csv file location
        body_path1<-paste0(Upath,"EXdata/CreditTransactions/CTData/getStockNumCT/",getStockNum,"東碱.csv")
      }
      #write.csv file location 用最舊的名字Name
      #body_path1<-paste0(Upath,"EXdata/CreditTransactions/CTData/getStockNumCT/",getStockNum,body1[1,3],".csv")
      
      #write.csv file
      write.csv(body1,file = body_path1,fileEncoding="UTF-8") 
    }
    # else{
    #   bodyNARow_num<-bodyNARow_num+1
    #   bodyNARow<-cbind(bodyNARow_num,getStockNum)
    #   bodyNA<-rbind(bodyNA,bodyNARow)
    # }
    # #顯示每次所需時間(秒)
    # runtime<-proc.time()-starttime
  }
  cat(paste(getStockNum,body1[RowNumTotal_body1,3],"\tFINISHED !!! ( " ,getStockNumforCT_RowNum," )\n"
            # ,"(",round(runtime[1],2),"\t",round(runtime[2],2),"\t",round(runtime[3],2),")\n" 
  ))
}
body_path_NA<-paste0(Upath,"EXdata/CreditTransactions/CTData/getStockNumCT/total.csv")
write.csv(bodyNA,file = body_path_NA,fileEncoding="UTF-8") 
# 
# [4992,] "4992"        "'1408"    
# [4993,] "4993"        "'1408"    
# [4994,] "4994"        "'1408"    
# [4995,] "4995"        "'1408"    
# [4996,] "4996"        "'1408"    
# [4997,] "4997"        "'1408"    
# [4998,] "4998"        "'1408"    
# [4999,] "4999"        "'1408"    
# [5000,] "5000"        "'1408"    


runtime<-proc.time()-starttime
cat(paste(getStockNum,body1[RowNumTotal_body1,3],"\tFINISHED !!! (",round(runtime[1],2),"\t",round(runtime[2],2),"\t",round(runtime[3],2),")\n" ))
#大迴圈 END  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
