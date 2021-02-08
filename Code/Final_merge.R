#install.packages('radr')
library(readr)
#install.packages('data.table')
library(data.table)
#install.packages('tidyverse')
library(tidyverse)



#-----------------------------------------------------------------------------
merged_disambig_apps <- readRDS("/home/arubhardwaj/E/disambiguation/DATA/merged_disambig_apps.Rds")
patents_inventors_merged <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/patents_inventors_merged.csv")
application_data <- data.table::fread("/home/arubhardwaj/E/disambiguation/wfdata/application_data.csv")

#---------------------------------------------------------------------------------
# remove rows
application_data<- application_data[!application_data$patent_id=="None",]
application_data<- application_data[!application_data$patent_id=="D251712",]
#---------------------------------------------------------------------------------

nrow(patents_inventors_merged[duplicated(patents_inventors_merged$patent_id),])
nrow(patents_inventors_merged)
colnames(application_data)
colnames(merged_disambig_apps)
colnames(patents_inventors_merged)

application_data<-application_data[,-1]
patents_inventors_merged<-patents_inventors_merged[,-1]

app_inv<-merge(application_data, patents_inventors_merged, by ='patent_id')
colnames(app_inv)
mode(app_inv$application_number)
mode(merged_disambig_apps$application_number)

merged_disambig_apps$ID <- paste(merged_disambig_apps$application_number, merged_disambig_apps$firstname, merged_disambig_apps$middlename, merged_disambig_apps$lastname )
app_inv$ID <- paste(app_inv$application_number, app_inv$firstname, app_inv$lastname)

last_merge <- merge(merged_disambig_apps, app_inv, by ='ID')

saveRDS(last_merge, "last_merge.Rds")
colnames(last_merge)
nrow(last_merge)

