#disk location
Upath<-paste0("D:/")
#file location
FI_dir_path<-paste0(Upath,"EXdata/Ex_dividend/")
FI_dir<-dir(FI_dir_path,"csv$")
#read file
getStockNumFI_path<-paste0(FI_dir_path,FI_dir[1])###############################################choice read file
getStockNumFI<-read.csv(getStockNumFI_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8

colnames(getStockNumFI)
##############################################################################################0050 BASIC DATA
#disk location
Upath<-paste0("D:/")
#file location
BD_dir_path<-paste0(Upath,"data/new/tw50/")
BD_dir<-dir(BD_dir_path,"csv$")
#read file
getStockNumBD_path<-paste0(BD_dir_path,BD_dir[1])###############################################choice read file
getStockNumBD<-read.csv(getStockNumBD_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8

colnames(getStockNumBD)
# [1] "X.1"    "X"      "Year"   "Month"  "Day"    "vol_S"  "vol_P"  "P_S"    "P_H"    "P_L"    "P_E"    "P_D2"   "exc"    "NP_D2D"
##############################################################################################FI
#disk location
Upath<-paste0("D:/")
#file location
FI_dir_path<-paste0(Upath,"EXdata/FinancialInformation/FIData/getStockNumFI/")
FI_dir<-dir(FI_dir_path,"csv$")
#read file
getStockNumFI_path<-paste0(FI_dir_path,FI_dir[333])###############################################choice read file
getStockNumFI<-read.csv(getStockNumFI_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8

colnames(getStockNumFI)
# [1] "X.1"                 "X"                   "Id"                  "Name"                "Time"                "OR"                 
# [7] "OR_YoY"              "OR_Rate"             "Income"              "Income_YoY"          "nO_Income"           "nO_Income_YoY"      
# [13] "N_Income"            "N_Income_YoY"        "N_Income_Rate"       "Shared"              "N_Income_Shared"     "N_Income_Shared_YoY"
# [19] "NetPrice_Shared"     "NetPrice_totalAsset" "FlowRate"            "QuickRate"          

##############################################################################################CT
http://www.twse.com.tw/device/ch/trading/exchange/MI_MARGN/MI_MARGN.php?input_date=105%2F04%2F06&selectType=ALL&login_btn=%20%E6%9F%A5%E8%A9%A2%20

#disk location
Upath<-paste0("D:/")
#file location
FI_dir_path<-paste0(Upath,"EXdata/CreditTransactions/CTData/getStockNumCT/")
FI_dir<-dir(FI_dir_path,"csv$")
#read file
#getStockNumFI<-read.csv(FI_path,encoding="big5",stringsAsFactors = FALSE)#<-big5
getStockNumFI<-read.csv(getStockNumFI_path,fileEncoding="UTF-8",stringsAsFactors = FALSE)#<-UTF-8