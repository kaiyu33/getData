#'
#'
#'
#

P2=P1*d_s/Denomination_Shares

#disk location
Upath<-paste0("F:/")
ED_Dir_path<-paste0(Upath,"EXdata/Ex_dividend/getStockNumED/")
ED_dir<-dir(ED_Dir_path)
ED_path<-paste0(ED_Dir_path,ED_dir[1])
ED<-read.csv(ED_path,stringsAsFactors = FALSE)

for (i in 1:nrow(ED)) {
  for (j in 1:ncol(ED)) {
    # ED[i,j]<-ifelse(is.na(ED[i,j]),0,break)
    if(is.na(ED[i,j])|is.null(ED[i,j])|ED[i,j]==""||ED[i,j]=="<NA>"){
      # assign(ED[i,j],0)
      # replace(ED[i,j],0)
      "0"->ED[i,j]
    }
    
  }
}

as.data.frame(ED,is.na=0)
gsub(is.na(ED),0,ED)

if(ED[7,i<-grep(is.na(ED[7,]),ED[7,])])
ED[1,]
txt <- c("arm","foot","lefroo", "bafoobar")
if(length(i <- grep("foo", txt)))