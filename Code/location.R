setwd("~/E/disambiguation/")
location <- read.table(file ="~/E/disambiguation/DATA/location.tsv", sep = '\t', header = TRUE)
head(location)

#----------------------------------------------------------
library(tidyverse)
location <- location %>% rename(location_id = id)
colnames(location)

#-----------------------------------------------------------

colnames(last_merge)

# select specific columns
last_merge <- last_merge %>% select(ID, application_number.x, raw_uuid, inventor_disambiguated, middlename, lastname.x, V7, state, filing_date.x, invention_title, V1, patent_id.x, inventor_id, location_id)

last_merge <- last_merge %>% rename( application_number = application_number.x,
                                     lastname = lastname.x,
                                     filing_date = filing_date.x,
                                     patent_id = patent_id.x)

# Merge last_merge and location


last_merge <- merge(last_merge, location, by = 'location_id')
colnames(last_merge)
head(last_merge)

last_merge = last_merge[last_merge$country=='US',]
nrow(last_merge)
length(unique(last_merge$inventor_id))

#----------------------------------------------------------------------------------

gender <- read.table(file ="~/E/disambiguation/DATA/inventor_gender.tsv", sep = '\t', header = TRUE)
head(gender)
nrow(gender)

gender <- gender %>% rename(inventor_id=disamb_inventor_id_20200929)

gender <- gender[,-1]

#-----------------------------------------------------------------------------------

#merge gender in the dataset
last_merge <- merge(last_merge, gender, by = 'inventor_id')

#-----------------------------------------------------------------------------------


colnames(last_merge)

last_merge$gender <- ifelse(last_merge$male == 1, "Male", "Female") 

write_csv(last_merge, "~/E/disambiguation/data2/merge")

last_merge <- read.csv("~/E/disambiguation/data2/merge")

last_merge_unique <- last_merge[unique(last_merge$inventor_id),]

write.csv(last_merge_unique,'~/E/disambiguation/data2/mergeU')

length(unique(last_merge$inventor_id))

#-----------------------------------------------------------------------------
location_freq <- data.frame(table(last_merge$location_id))

head(location_freq)

