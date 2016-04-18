#'Allotment_Coupon
#'
#disk location
Upath<-paste0("F:/")

#file location with complete data
x1_path<-paste0(Upath,"EXdata/JAVA_getTwseData3/94YearCoupon.txt")
# #read file
# F:\EXdata\JAVA_getTwseData3
# getStockNum_java<-read.csv(FI_path,encoding="big5",stringsAsFactors = FALSE)#<-big5
# getStockNum_java<-read.csv2(x1_path,fileEncoding="UTF-8",stringsAsFactors = FALSE,header=FALSE)#<-UTF-8
#確認顯示" "
CheckSymbol<-sapply(strsplit(readLines(x1_path,encoding="UTF-8")[2],";"),"[",17)

for (k in 94:104) {
  #file location with complete data
  x1_path<-paste0(Upath,"EXdata/JAVA_getTwseData3/",k,"YearCoupon.txt")
  #read file
  csvv<-readLines(x1_path,encoding="UTF-8")
  
  #   #method:1 差 欄位會有逗號 未解決
  #   csvv[1]
  #   strsplit(csvv[1],";")
  # 
  #   A<-NULL
  #   for (i in 1:600) {
  #     if (is.na(csvv[i])) {
  #     }else{
  #       B<-NULL
  #       for (j in 1:24) {
  #         if(CheckSymbol==sapply(strsplit(csvv[i],";"),"[",j)){
  #           D<-""
  #         }else{
  #           D<-sapply(strsplit(csvv[i],";"),"[",j)
  #         }
  #         B<-cbind(B,D)
  #       }
  #       A<-rbind(A,B)
  #     }
  #   }
  #   View(A)
  #   
  #   head(A)
  #   colnames(A)<-c(1:ncol(A))
  #   new_path00<-paste0(Upath,"JAVA_getTwseData3/",k,"YearCoupon.csv")
  #   write.csv(A,file = new_path00)
  #   #colnames(A)<-c("ID","name","C_Year","C_BaseDate","C_Stock_Earnings","C_Stock_Other","C_Stock_ExchangeDate",""
  #   #""
  # }
  
  #method:2
  csvv<-gsub(",",replacement="",csvv)
  csvv<-gsub(" ",replacement="",csvv)
  # csvv[1]
  csvv<-strsplit(csvv,";")
  # class(csvv)
  # length(csvv)
  csvv_dataframe<-t(as.data.frame(csvv))
  # class(csvv)
  # csvv2[,1]
  # colnames(csvv)
  # ncol(csvv)
  rownames(csvv_dataframe)<-c(2:(length(csvv)+1))
  colnames(csvv_dataframe)<-c(1:24)
  csvv_dataframe<-rbind(c("num","公司代號","公司名稱","股利所屬年度","權利分派基準日",
                          
                          "餘轉增資配股(元/股)","法定盈餘公積、資本公積轉增資配股(元/股)",
                          "配股總股數(股)","配股總金額(元)","配股總股數佔盈餘配股總股數之比例(%)","員工紅利配股率",
                          "盈餘分配之股東現金股利(元/股)","法定盈餘公積、資本公積發放之現金(元/股)","除息交易日",
                          "現金股利發放日","員工紅利總金額(元)","現金增資總股數(股)","現金增資認股比率(%)","現金增資認購價(元/股)",
                          "現金增資認購價(元/股)",
                          
                          "董監酬勞(元)","公告日期","公告時間","普通股每股面額"),csvv_dataframe)
  
  View(csvv_dataframe)
  head(csvv_dataframe)
  
  new_path00<-paste0(Upath,"JAVA_getTwseData3/",k,"YearCoupon.csv")
  write.csv(A,file = new_path00)
  #colnames(A)<-c("ID","name","C_Year","C_BaseDate","C_Stock_Earnings","C_Stock_Other","C_Stock_ExchangeDate",""
  #""
}

