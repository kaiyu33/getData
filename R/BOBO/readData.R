#disk location
Upath<-paste0(substr(getwd(),1,3))
#file location
BO_dir_path<-paste0(Upath,"GitHub/BOBO/")
BO_dir<-dir(BO_dir_path)

"ByMinute"     "ByTime"       "Monthmin.txt" "R"            "RbindAll"     "原始檔" 
# BO2_dir<-dir(paste0(BO_dir_path,BO_dir[c(1,2,3,5)]),"BT.txt$")
BO2_dir<-dir(paste0(BO_dir_path,BO_dir[2]))

# getfutures<-read.csv(getStockNumFI_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8
for (i in 1:length(BO2_dir)) {
   assign(BO2_dir[i],read.csv(paste0(BO_dir_path,BO_dir[2],"/",BO2_dir[i])))
}

data2<-NULL
for (i in 1:length(BO2_dir)) {
  data2<-rbind(data2,cbind(paste0("\"",substr(BO2_dir[i],1,4),"\""),get(BO2_dir[i])))
}
write.csv(data3,paste0(BO_dir_path,"0318to0422.csv"))

data3<-read.csv(paste0(BO_dir_path,"0318to0422.csv"))
colnames(data3)[1]<-"ID"