#disk location
Upath<-paste0("F:/")

k=94
#file location with complete data
x1_path<-paste0(Upath,"EXdata/JAVA_getTwseData3/",k,"YearCoupon.txt")
#read file
csvv<-readLines(x1_path,encoding="UTF-8")

#method:2
csvv<-gsub(",",replacement="",csvv)
csvv[1]
csvv<-strsplit(csvv,";")
csvv[[1]][16]


csvv[1]
# class(csvv)
# length(csvv)
csvv_dataframe<-as.data.frame(csvv)
csvv_dataframe<-t(as.matrix(csvv_dataframe))
# class(csvv)
# csvv2[,1]
# colnames(csvv)
# ncol(csvv)
rownames(csvv_dataframe)<-c(2:(length(csvv)+1))
colnames(csvv_dataframe)<-c(1:24)



#還是分開寫 尤其是中文  否則Error: VECTOR_ELT() can only be applied to a 'list', not a 'raw'
cname<-c("num","公司代號","公司名稱","股利所屬年度","權利分派基準日",
         
         "餘轉增資配股(元/股)","法定盈餘公積、資本公積轉增資配股(元/股)",
         "配股總股數(股)","配股總金額(元)","配股總股數佔盈餘配股總股數之比例(%)","員工紅利配股率",
         "盈餘分配之股東現金股利(元/股)","法定盈餘公積、資本公積發放之現金(元/股)","除息交易日",
         "現金股利發放日","員工紅利總金額(元)","現金增資總股數(股)","現金增資認股比率(%)","現金增資認購價(元/股)",
         "現金增資認購價(元/股)",
         
         "董監酬勞(元)","公告日期","公告時間","普通股每股面額")
csvv_dataframe<-rbind(cname,csvv_dataframe)

# View(csvv_dataframe)
# head(csvv_dataframe)

new_path00<-paste0(Upath,"EXdata/JAVA_getTwseData3/",k,"YearCouponCCC.csv")
write.csv(csvv_dataframe,file = new_path00,fileEncoding="UTF-8")
##########################################################################################################################
#disk location
Upath<-paste0("F:/")
k=94
new_path00<-paste0(Upath,"EXdata/JAVA_getTwseData3/",k,"YearCouponCCC.csv")
csvv<-read.csv(new_path00,stringsAsFactors = FALSE,fileEncoding="UTF-8")

csvv2<-mutate(csvv,"X66"=sub("<U+00A0>",replacement="",csvv$X6))

csvv[i,j]<-grepl("<U[+]00A0>",csvv[i,j])
i=3
  j=7
  
  getSymbols
  
  packages <- c(
    "Rcpp",
    "rjson"
  )
  sapply(packages, function(a) install.packages(a))
  
csvv[3,7]
cs<-sub("<U+00A0>",replacement="",csvv)

cs2<-NULL
for (i in 1:25) {
cs2<-c  
}
cs2[[1]]
#colnames(A)<-c("ID","name","C_Year","C_BaseDate","C_Stock_Earnings","C_Stock_Other","C_Stock_ExchangeDate",""

CA<-as

for (j in 1:length(csvv)) {
  for (i in 1:length(csvv[[1]])) {
    if(grepl("<U[+]00A0>",csvv[i,j])){
      k<-i;l<-j
      function(k,l) {csvv[k,l]="0"}
      # assignMethodsMetaData()
    }
    # csvv(grep("<U[+]00A0>",csvv[i,j]))<-"0"
  }
}
print("<U+00A0>")
grepl('<U+00A0>',csvv[3,7])
csvv("<U+00A0>"==csvv[i,j)<-"0"

("<U+00A0>"==csvv[i,j])
stri_escape_unicode("A")
csvv_dataframe

for (i in 1:length(csvv)) {
  for (j in 1:length(csvv[[1]])) {
    csvv_dataframe[2,6]<-""
  }
}

等價於[ \f\n\r\t\v]。
is.n(csvv_dataframe[2,8])
csvv_dataframe(grep("\s",A[i,j]))
grepl("[ ]*"," ")


grepl("<U+00A0>",csvv_dataframe[i,j])
# is.integer(csvv_dataframe[1,3])
# is.name(csvv_dataframe[1,3])

gsub("<U+00A0>",replacement="",A[i,j])


for (j in 1:length(A)) {
  for (i in 1:length(A[[1]])) {
    %A[%i,%j]<-gsub("<U+00A0>",replacement="0",A[i,j])
    # ifelse(A[i,j]=="<U+00A0>",A[i,j]<-"0",break)
    #   xx<-paste0("A[",i,",",j,"]")
    #   assign(xx,"0")
    #   
    # }
    # gsub("<U+00A0>",replacement="",A[i,j])
    # n<- paste("x",i,sep=".")
    
  }
}



#####################################################

#disk location
Upath<-paste0("D:/")

k=94
#file location with complete data
x1_path<-paste0(Upath,"EXdata/JAVA_getTwseData3/",k,"YearCoupon.txt")
#read file
csv2<-read.csv2(x1_path,encoding="UTF-8")
