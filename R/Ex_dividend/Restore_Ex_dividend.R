#'Restore_Ex_dividend
#'
#'還原除權息 2005-2016
#'資料 data tw50 共50隻
#'
#'繼承:TWSEEx_dividend2
#'
#'繼承:readTWSEEx_dividend
#'
#'前身:JAVA_getTwseData3

#disk location
Upath<-paste0("F:/")

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
  assign(paste("ReED_ED",substr(BD_dir[i],1,4),sep="."),getData)
  
  
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
  assign(paste("ReED_ED_C",substr(BD_dir[i],1,4),sep="."),getDataC)
  assign(paste("ReED_ED_S",substr(BD_dir[i],1,4),sep="."),getDataS)
}
y<-get(paste("ReED_ED",substr(BD_dir[i],1,4),sep="."))
yc<-get(paste("ReED_ED_C",substr(BD_dir[i],1,4),sep="."))
ys<-get(paste("ReED_ED_S",substr(BD_dir[i],1,4),sep="."))

EDxtsC<-xts(as.matrix(yc[,-1]),
           as.Date(yc[,1]),
           #as.POSIXct(fr[,1], tz=Sys.getenv("TZ")),
           src='myData',updated=Sys.time())
EDxtsS<-xts(as.matrix(ys[,-1]),
           as.Date(ys[,1]),
           #as.POSIXct(fr[,1], tz=Sys.getenv("TZ")),
           src='myData',updated=Sys.time())

EDxts<-cbind(EDxtsS,EDxtsC)
for (m in 1:nrow(EDxts)) {
  for (n in 1:ncol(EDxts)) {
    if (is.na(EDxts[m,n])) {
      0->EDxts[m,n]
    }
  }
}

x<-get(paste("ReED_BD",substr(BD_dir[i],1,4),sep="."))
colnames(x)<-c("Date","vol_S","vol_P","Open","High","Low","Close","P_D2","exc","NP_D2D")

BDxts<-xts(as.matrix(x[,-1]),
           as.Date(x[,1]),
           #as.POSIXct(fr[,1], tz=Sys.getenv("TZ")),
           src='myData',updated=Sys.time())
BDxts<-BDxts["2005-01-01/2016-02-29"]
# 
# for(r in nrow(EDxts):1){#除權息 以現在為基準 故有負數的出現
#     if(r>1){
#       assign(paste0("ReED_BD",r),(as.numeric(BDxts[paste0(time(EDxts[r-1,]),"/",time(EDxts[r,])-1)]$Close)-as.numeric(EDxts[r,4]))/(1+as.numeric(EDxts[r,2])))
#     }else if(r==1){
#       assign(paste0("ReED_BD",r),(as.numeric(BDxts[paste0("2005-01-01","/",time(EDxts[r,])-1)]$Close)-as.numeric(EDxts[r,4]))/(1+as.numeric(EDxts[r,2])))
#     }
#     if(r<nrow(EDxts)){
#       for (s in (r+1):nrow(EDxts)) {
#         assign(paste0("ReED_BD",r),(get(paste0("ReED_BD",r))-as.numeric(EDxts[s,4]))/(1+as.numeric(EDxts[s,2])))
#       }
#     }
# }
# 
# ls(pattern = "^ReED_BD")

assign(paste0("ReED_BD",0),as.numeric(BDxts[paste0("2005-01-01","/",time(EDxts[1,])-1)]$Close))
for(r in 1:nrow(EDxts)){#除權息 改以 以2005-01-01為基準
  if(r<nrow(EDxts)){
    assign(paste0("ReED_BD",r),
           (
             as.numeric(BDxts[paste0(time(EDxts[r,]),"/",time(EDxts[r+1,])-1)]$Close)*(1+as.numeric(EDxts[r,2]))+as.numeric(EDxts[r,4])
           )
           )
  }else if(r==nrow(EDxts)){
    assign(paste0("ReED_BD",r),(
      as.numeric(BDxts[paste0(time(EDxts[r,]),"/","2016-02-29")]$Close)*(1+as.numeric(EDxts[r,2]))+as.numeric(EDxts[r,4])
    )
    )
  }
  if(r>1){
    for (s in (r-1):1) {
      assign(paste0("ReED_BD",r),(
        get(paste0("ReED_BD",r))*(1+as.numeric(EDxts[s,2]))+as.numeric(EDxts[s,4])
      ))
    }
  }
}

ls(pattern = "^ReED_BD")

# for(r in nrow(EDxts):1){
#   if(EDxts[r,1]=="S"&EDxts[r,3]=="C" ){#除權息
#     assign(paste0("ReED_BD",r),(as.numeric(BDxts[paste0(time(EDxts[r-1,]),"/",time(EDxts[r,])-1)]$Close)-as.numeric(EDxts[r,4]))/(1+as.numeric(EDxts[r,2])))
#     
#   }else if(EDxts[r,1]!="S"&EDxts[r,3]=="C" ){#僅除息
#     assign(paste0("ReED_BD",r),as.numeric(BDxts[paste0(time(EDxts[r-1,]),"/",time(EDxts[r,])-1)]$Close)-as.numeric(EDxts[r,4]))
#   }else if(EDxts[r,1]=="S"&EDxts[r,3]!="C" ){#僅除權
#     assign(paste0("ReED_BD",r),as.numeric(BDxts[paste0(time(EDxts[r-1,]),"/",time(EDxts[r,])-1)]$Close)/(1+as.numeric(EDxts[r,2])))
#     
#   }
#   if(r==1){
#   break  
#   }
# }
time(EDxts[1,3])-30


for (i in 1:length(BD_dir)) {
x<-get(paste("ReED_BD",substr(BD_dir[i],1,4),sep="."))
colnames(x)<-c("Date","vol_S","vol_P","Open","High","Low","Close","P_D2","exc","NP_D2D")
x<-select(x,c(1,4:7))
# x<-select(x,c(1,4:7,2,3,8:10))



}

BDxts<-xts(as.matrix(x[,-1]),
           as.Date(x[,1]),
           #as.POSIXct(fr[,1], tz=Sys.getenv("TZ")),
           src='myData',updated=Sys.time())

time(BDxts[1])
# [1] "2005-01-03"

attr(BDxts, "dimnames") #等同於 dimnames(sample.xts)
# [[1]]
# NULL
# [[2]]
# [1] "vol_S"  "vol_P"  "P_S"    "P_H"    "P_L"    "P_E"    "P_D2"   "exc"    "NP_D2D"
attr(BDxts, "dimnames")<-as.list("CName"=C("vol_S","vol_P","Open","High","Low","Close","Volume", "P_D2","exc","NP_D2D"))
attr(BDxts, "dimnames")[[2]][6]<-"Adj"
attr(BDxts, "dimnames")[[2]][6]

chartSeries(BDxts["2014-01-01/2014-12-31"])

data2change<-BDxts[,4]
if (BDxts[y[nrow(y),2]]=="C") {
  data2change<-as.numeric(BDxts[paste0("/",y[nrow(y),1])]$Close)-as.numeric(y[nrow(y),3])
  
}

for (k in 1;nrow(y)) {
  x$Date==y[k,1]
}
