#install.packages('radr')
library(readr)
#install.packages('data.table')
library(data.table)
#install.packages('tidyverse')
library(tidyverse)

all_results <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/all-results.txt")
head(all_results)



########################################################################################
# Renaming Columns
#==========================================================================================
colnames(all_results)

all_results <- all_results %>% 
                    rename(application_number=V1, raw_uuid = V2, inventor_disambiguated=V3, firstname=V4, middlename=V5, lastname=V6, state=V8, filing_date=V9, invention_title=V10 )


head(all_results)


