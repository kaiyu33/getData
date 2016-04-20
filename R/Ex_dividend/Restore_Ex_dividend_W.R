#'Restore_Ex_dividend_W
#'only:EDxts
#'繼承:Restore_Ex_dividend
#'
#'還原除權息 2005-2016
#'資料 data tw50 共50隻
#'
#'繼承:TWSEEx_dividend2
#'
#'繼承:readTWSEEx_dividend
#'
#'前身:JAVA_getTwseData3
#

#disk location
Upath<-paste0(substr(getwd(),1,1),":/")

#file location
BD_dir_path<-paste0(Upath,"data/new/tw50/")
BD_dir<-dir(BD_dir_path,"csv$")

for (i in 1:length(BD_dir)) {
  #read file############################################################################################BD
  getStockNumBD_path<-paste0(BD_dir_path,BD_dir[i])###############################################choice read file
  getStockNumBD<-read.csv(getStockNumBD_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8
  colnames(getStockNumBD)
  
  getStockNumBD<-filter(getStockNumBD,getStockNumBD$Year>=2005)
  getStockNumBD<-mutate(getStockNumBD,"Date"=as.Date(paste(getStockNumBD$Year,getStockNumBD$Month,getStockNumBD$Day,sep="-")))
  getStockNumBD2<-select(getStockNumBD,c(ncol(getStockNumBD),6:(ncol(getStockNumBD)-1)))
  
  # colnames(getStockNumBD2)
  # [1] "Date"   "vol_S"  "vol_P"  "P_S"    "P_H"    "P_L"    "P_E"    "P_D2"   "exc"    "NP_D2D"
  
  assign(paste("ReED_BD",substr(BD_dir[i],1,4),sep="."),getStockNumBD2)
  
  
  
  # #file location############################################################################################ED
  ED_path<-paste0(Upath,"EXdata/Ex_dividend/getStockNumED/TW.",substr(BD_dir[i],1,4),".csv")
  
  # assign(paste("ReED_ED",substr(BD_dir[i],1,4),sep="."),read.csv(ED_path,stringsAsFactors = FALSE))
  # 
  # ED<-get(paste("ReED_ED",substr(BD_dir[i],1,4),sep="."))
  ED<-read.csv(ED_path,stringsAsFactors = FALSE)
  for (k in 1:nrow(ED)) {
    for (j in 1:ncol(ED)) {
      if(is.na(ED[k,j])|is.null(ED[k,j])|ED[k,j]==""||ED[k,j]=="<NA>"){
        0->ED[k,j]
      }
    }
  }
  
  # getData<-NULL
  # for (k in 1:nrow(ED)) {
  #   if ((ED$dividend_C_Earnings+ED$dividend_C_Law)[k]>0) {
  #     getData<-rbind(getData,cbind(
  #       as.character(as.Date(
  #         paste(
  #           as.numeric(strsplit(ED$dividend_C_Date[k],"/")[[1]][1])+1911,
  #           as.numeric(strsplit(ED$dividend_C_Date[k],"/")[[1]][2]),
  #           as.numeric(strsplit(ED$dividend_C_Date[k],"/")[[1]][3])
  #           ,sep="-")
  #       ))
  #       ,
  #       "C",
  #       (ED$dividend_C_Earnings+ED$dividend_C_Law)[k]))
  #   }
  #   if (((ED$dividend_S_Earnings+ED$dividend_S_Law)[k]/10>0)) {
  #     getData<-rbind(getData,cbind(
  #       as.character(as.Date(
  #         paste(
  #           as.numeric(strsplit(ED$dividend_S_Date[k],"/")[[1]][1])+1911,
  #           as.numeric(strsplit(ED$dividend_S_Date[k],"/")[[1]][2]),
  #           as.numeric(strsplit(ED$dividend_S_Date[k],"/")[[1]][3])
  #           ,sep="-")
  #       ))
  #       ,
  #       "S",
  #       (ED$dividend_S_Earnings+ED$dividend_S_Law)[k]))
  #   }
  # }
  # assign(paste("ReED_ED",substr(BD_dir[i],1,4),sep="."),getData)
  
  
  getDataC<-NULL
  getDataS<-NULL
  for (k in 1:nrow(ED)) {
    if ((ED$dividend_C_Earnings+ED$dividend_C_Law)[k]>0) {
      getDataC<-rbind(getDataC,cbind(
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
      getDataS<-rbind(getDataS,cbind(
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
  # assign(paste("ReED_ED_C",substr(BD_dir[i],1,4),sep="."),getDataC)
  # assign(paste("ReED_ED_S",substr(BD_dir[i],1,4),sep="."),getDataS)
  # 
  # #################################################################################################################
  # # y<-get(paste("ReED_ED",substr(BD_dir[i],1,4),sep="."))
  # yc<-getDataC
  # ys<-getDataS
  
  # #i=41
  # #需修改
  # options(stringsAsFactors = T)
  # options("stringsAsFactors")
  # 
  # colnames(getDataS)<-c("Date","Type","Num")
  # colnames(getDataC)<-c("Date","Type","Num")
  # getData<-merge(getDataS,getDataC,by="Date",all=T,stringsAsFactors=F)
  # 
  # for (m in 1:nrow(getData)) {
  #   for (n in 1:ncol(getData)) {
  #     if (is.na(getData[m,n])) {
  #       0->getData[m,n]
  #     }
  #   }
  # }
  
  # #i=1
  #   if(!is.null(getDataC)){
  #   EDxtsC<-xts(as.matrix(getDataC[,-1]),
  #               as.Date(getDataC[,1]),
  #               #as.POSIXct(fr[,1], tz=Sys.getenv("TZ")),
  #               src='myData',updated=Sys.time())
  # }
  #   if(!is.null(getDataS)){
  #       EDxtsS<-xts(as.matrix(getDataS[,-1]),
  #               as.Date(getDataS[,1]),
  #               #as.POSIXct(fr[,1], tz=Sys.getenv("TZ")),
  #               src='myData',updated=Sys.time())
  #   }
  # EDxts<-cbind(EDxtsS,EDxtsC)
  # for (m in 1:nrow(EDxts)) {
  #   for (n in 1:ncol(EDxts)) {
  #     if (is.na(EDxts[m,n])) {
  #       0->EDxts[m,n]
  #     }
  #   }
  # }
  
  if(!is.null(getDataS)&!is.null(getDataC)){
  colnames(getDataS)<-c("Date","Type","Num")
  colnames(getDataC)<-c("Date","Type","Num")
  getData<-merge(getDataS,getDataC,by ="Date",all=T)
  getData$Date<-as.character(getData$Date)
  getData$Type.x<-as.character(getData$Type.x)
  getData$Num.x<-as.character(getData$Num.x)
  getData$Type.y<-as.character(getData$Type.y)
  getData$Num.y<-as.character(getData$Num.y)

  for (m in 1:nrow(getData)) {
    for (n in 1:ncol(getData)) {
      if (is.na(getData[m,n])[[1]]) {
        0->getData[m,n]
      }
    }
  }
  }else{
    if(!is.null(getDataS)){
      colnames(getDataS)<-c("Date","Type.x","Num.x")
      getData<-getDataS
    }
    if(!is.null(getDataC)){
      colnames(getDataC)<-c("Date","Type.y","Num.y")
      getData<-getDataC
    }
  }

  # x<-get(paste("ReED_BD",substr(BD_dir[i],1,4),sep="."))
  # colnames(x)<-c("Date","vol_S","vol_P","Open","High","Low","Close","P_D2","exc","NP_D2D")

  # BDxts<-xts(as.matrix(x[,-1]),
  #            as.Date(x[,1]),
  #            #as.POSIXct(fr[,1], tz=Sys.getenv("TZ")),
  #            src='myData',updated=Sys.time())
  # BDxts<-BDxts["2005-01-01/2016-02-29"]

  # ED_path_W<-paste0(Upath,"EXdata/Ex_dividend/getStockNumED2/TW.",substr(BD_dir[i],1,4),".csv")
  # # ED<-read.csv(ED_path,stringsAsFactors = FALSE)
  #
  # #write.csv file location
  # # body_path2<-paste0(Upath,"EXdata/FinancialInformation/FIData/StockFI2.csv")
  # #write.csv file
  # write.csv(getData,file = ED_path_W,fileEncoding="UTF-8")
}