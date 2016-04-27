#disk location
Upath<-paste0(substr(getwd(),1,3))
#file location
BO_dir_path<-paste0(Upath,"GitHub/getData/R/BOBO/")
BO_dir<-dir(BO_dir_path)

# "ByMinute"     "ByTime"       "Monthmin.txt" "R"            "RbindAll"     "原始檔" 
# BO2_dir<-dir(paste0(BO_dir_path,BO_dir[c(1,2,3,5)]),"BT.txt$")
BO2_dir<-dir(paste0(BO_dir_path,BO_dir[2]))

data3<-read.csv(paste0(BO_dir_path,"0318to0422.csv"))
data3<-data3[,2:ncol(data3)]

##1
Minute <- integer()
for(i in 1:nrow(data3)){
  tmp <- substr(as.character(data3$Time[i]), 1, nchar(as.character(data3$Time[i]))-2)
  Minute <- c(Minute, tmp)
}
data4<-data3
data4["Minute"] <- Minute
data.step2 <- group_by(data4, Date,Minute) %>%
  summarise(ID = last(ID), Open = first(Open), High = max(High), Low = min(Low), Close = last(Close),Vol = sum(Vol),momentum = sum(momentum),momentum.sig = sum(momentum.sig), momentum.ins = sum(momentum.ins)) %>% 
  ungroup %>%
  arrange(ID) %>% 
  mutate(momentum.diff = momentum.sig - momentum.ins) %>%
  select(Time=Minute, Date:momentum.diff)

##2
A<-filter(data.step2,Minute>1315)%>%
group_by(data4, Date) %>%
  summarise(ID = last(ID), Open = first(Open), High = max(High), Low = min(Low), Close = last(Close),
            Vol = sum(Vol),momentum = sum(momentum),momentum.sig = sum(momentum.sig), momentum.ins = sum(momentum.ins)) %>% 
  ungroup %>%
  arrange(ID)