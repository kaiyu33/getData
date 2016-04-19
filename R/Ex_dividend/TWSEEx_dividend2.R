#'TWSEEx_dividend2
#'
#'繼承:readTWSEEx_dividend
#'
#'前身:JAVA_getTwseData3
#P2=P1*d_s/Denomination_Shares

#disk location
Upath<-paste0("D:/")
ED_Dir_path<-paste0(Upath,"EXdata/Ex_dividend/getStockNumED/")
ED_dir<-dir(ED_Dir_path)

for (filNum in 1:length(ED_dir)) {
  ED_path<-paste0(ED_Dir_path,ED_dir[filNum])
  ED<-read.csv(ED_path,stringsAsFactors = FALSE)
  
  # gsub("NA",0,ED)#值後後變成向量 要再回存
  
  for (i in 1:nrow(ED)) {
    for (j in 1:ncol(ED)) {
      if(is.na(ED[i,j])|is.null(ED[i,j])|ED[i,j]==""||ED[i,j]=="<NA>"){
        0->ED[i,j]
      }
    }
  }
  
  #該這麼寫 但是截至104 依然全數為10元
  # (ED$dividend_S_Earnings+ED$dividend_S_Law)/as.numeric(substr(ED$Denomination_Shares[1],5,nchar(ED$Denomination_Shares[1])-1))
  # any(Ex_dividend.100$Denomination_Shares!="新台幣 10.0000元")
  # [1] FALSE
  
  # #除息價格 先
  # (ED$dividend_C_Earnings+ED$dividend_C_Law)>0
  # (ED$dividend_C_Earnings+ED$dividend_C_Law)
  # ED$dividend_C_Date
  # 
  # #除權 配股率  後
  # (ED$dividend_S_Earnings+ED$dividend_S_Law)/10>0
  # (ED$dividend_S_Earnings+ED$dividend_S_Law)/10
  # ED$dividend_S_Date
  # 
  # as.Date(paste(
  #   as.numeric(strsplit(ED$dividend_S_Date[1],"/")[[1]][1])+1911,
  #   as.numeric(strsplit(ED$dividend_S_Date[1],"/")[[1]][2]),
  #   as.numeric(strsplit(ED$dividend_S_Date[1],"/")[[1]][3])
  # ,sep="-"))
  # 
  # as.Date(ED$dividend_S_Date[1]) 
  
  getNum<-substr(ED_dir[filNum],4,7)
  
  # getData<-NULL
  # for (k in 1:nrow(ED)) {
  #   if ((ED$dividend_C_Earnings+ED$dividend_C_Law)[k]>0) {
  #     getData<-rbind(getData,cbind(
  #       ED$dividend_C_Date,
  #       "C",
  #       (ED$dividend_C_Earnings+ED$dividend_C_Law)[k]))
  #   }
  #   if (((ED$dividend_S_Earnings+ED$dividend_S_Law)[k]/10>0)) {
  #     getData<-rbind(getData,cbind(
  #       ED$dividend_S_Date,
  #       "S",
  #       (ED$dividend_S_Earnings+ED$dividend_S_Law)[k]))
  #   }
  # }
  
  getData<-NULL
  for (k in 1:nrow(ED)) {
    if ((ED$dividend_C_Earnings+ED$dividend_C_Law)[k]>0) {
      getData<-rbind(getData,cbind(
        as.character(as.Date(
          paste(
            as.numeric(strsplit(ED$dividend_C_Date[k],"/")[[1]][1])+1911,
            as.numeric(strsplit(ED$dividend_C_Date[k],"/")[[1]][2]),
            as.numeric(strsplit(ED$dividend_C_Date[k],"/")[[1]][3])
            ,sep="-")
        ))
        ,
        "C",
        (ED$dividend_C_Earnings+ED$dividend_C_Law)[k]))
    }
    if (((ED$dividend_S_Earnings+ED$dividend_S_Law)[k]/10>0)) {
      getData<-rbind(getData,cbind(
        as.character(as.Date(
          paste(
            as.numeric(strsplit(ED$dividend_S_Date[k],"/")[[1]][1])+1911,
            as.numeric(strsplit(ED$dividend_S_Date[k],"/")[[1]][2]),
            as.numeric(strsplit(ED$dividend_S_Date[k],"/")[[1]][3])
            ,sep="-")
        ))
        ,
        "S",
        (ED$dividend_S_Earnings+ED$dividend_S_Law)[k]))
    }
  }
  
  assign(paste("Ex_dividend",getNum,sep="."),getData)
  
}