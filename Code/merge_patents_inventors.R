#install.packages('radr')
library(readr)
#install.packages('data.table')
library(data.table)
#install.packages('tidyverse')
library(tidyverse)
#install.packages('dplyr')
library(dplyr)
#install.packages('foreign')
library(foreign)
#----------------------------------------------------------------------------------------------------

# patent inventor
patent_inventor <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/patent_inventor.tsv")
colnames(patent_inventor)

table(patent_inventor$patent_id=="patent_id")
head(patent_inventor)


# Inventor

inventor <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/inventor.tsv")
colnames(inventor)

inventor <- inventor %>%
                    rename(inventor_id = id, firstname = name_first,  lastname = name_last)

table(inventor$inventor_id=='6584128-1')
head(inventor)

# Converting First and Last name in uppercase
inventor$firstname <- toupper(inventor$firstname)
inventor$lastname <- toupper(inventor$lastname)

# Exporting data in CSV
write.csv(inventor, file = "DATA/inventor.csv")

#---------------------------------------------------------------------------------------------------
# Merging inventor.csv and patent_inventor.csv
#---------------------------------------------------------------------------------------------------

#patent_inventor <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/patent_inventor.tsv")
#inventor <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/inventor.csv", head = TRUE)

head(patent_inventor)
head(inventor)

#inventor <- inventor[,-1] # drop the first columns which shows serial number if one imports from Exported CSV file

nrow(inventor)
nrow(patent_inventor)

patents_inventors_merged <- merge(inventor, patent_inventor, by = 'inventor_id')

# Export merged data in CSV
write.csv(patents_inventors_merged, file = "DATA/patents_inventors_merged.csv")

table(is.na(patents_inventors_merged))

