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
# Import Full application_data
#----------------------------------------------------------------------------------------------------
# Change Path
#application_data <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/application_data_FULL.csv")
#head(application_data)

#----------------------------------------------------------------------------------------------------
# Required Columns from application_data_FULL
#----------------------------------------------------------------------------------------------------

# Create a new data frame of required columns
#application_data <-  subset(application_data, select = c(application_number,filing_date, patent_number, invention_title) )
#colnames(application_data)
#dim(application_data)

# Change Path
application_data <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/application_data.csv")
head(application_data)



#save.image("application_data.RData") # to save the workflow if Memory usage is huge!
#write.csv(application_data, "application_data.csv") # Export in CSV

application_data <- application_data[!application_data$patent_number=="",] # Remove Blank Entries

# Rename `patent_id` to `patent_number`
application_data <- application_data%>%
  rename(patent_id=patent_number)


# Drop rows with duplicate IDs
application_data <- application_data$patent_id[duplicated(application_data$patent_id)] 

# Drop `D251712` and `None` from `patent_id`
application_data <- application_data[!application_data$patent_id=="D251712" | !application_data$patent_id=="None",]

# Do we have any more duplicates left? 
any(duplicated(names(application_data$patent_id)))

#=====================================================================================
#=====================================================================================
#=====================================================================================

# Change Path
all_inventors <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/all_inventors.csv")
head(all_inventors)

#=====================================================================================
#=====================================================================================
#=====================================================================================

# Merge Granted Applications and inventor

#==================================================================================
# Run these lines only if `granted patents` and `application data` 
# was exported and not in local environment
# I used `disambig_apps` for `granted_apps`

#disambig_apps <- data.table::fread("DATA/disambig_apps.csv")
#application_data <- data.table::fread("DATA/application_data.csv")
#names(application_data)[1]<-paste("Srno") 
#application_data <- subset(application_data, select = -c(Srno))
#==================================================================================

# Remove `V1` column, as it is not needed!
disambig_apps <- subset(disambig_apps, select = -c(V1))

#====================================================================================
head(application_data) # check
head(disambig_apps) # check
mode(application_data$application_number) # check (should be numeric)
mode(disambig_apps$application_number) # check (should be numeric)
#=====================================================================================
# Convert it, if they are not numeric

application_data$application_number <- as.numeric(application_data$application_number)
disambig_apps$application_number <- as.numeric(disambig_apps$application_number)

na.omit(application_data$application_number) # Remove all NAs
table(is.na(application_data$application_number)) # Just checking if there are NAs

nrow(application_data)
nrow(disambig_apps)

head(disambig_apps$V1) # Check if it exists
disambig_apps <- disambig_apps[,-disambig_apps$V1] # remove `V1` if it exits


# Merge `disambig_apps` and `application_data` by `application_number`

merged_disambig_apps <- merge(disambig_apps, application_data, by = 'application_number')

# save it!!
saveRDS(merged_disambig_apps, "DATA/merged_disambig_apps.Rds") # exporting in Rds because it is light weight!

# Now, it is better to clear the workspace and load this `merged_disambig_apps.Rds` file to work.


#=====================================================================================
#=====================================================================================
#=====================================================================================

# Merge `patent` and `inventor` files



# import `patent_inventor`
# Change Path
patent_inventor <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/patent_inventor.tsv")
#colnames(patent_inventor)

table(patent_inventor$patent_id=="patent_id")
head(patent_inventor)


# import `Inventor.tsv` 
# Change Path
inventor <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/inventor.tsv")
colnames(inventor)

# Rename columns
inventor <- inventor %>%
  rename(inventor_id = id, firstname = name_first,  lastname = name_last)

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

# Merge data
patents_inventors_merged <- merge(inventor, patent_inventor, by = 'inventor_id')

# Export merged data in CSV
#write.csv(patents_inventors_merged, file = "DATA/patents_inventors_merged.csv")

#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------



# Final Merge


#-----------------------------------------------------------------------------
# Change Path!
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
#---------------------------------------------------------------------------------


application_data <- application_data[,-1]
patents_inventors_merged <- patents_inventors_merged[,-1]

app_inv <- merge(application_data, patents_inventors_merged, by ='patent_id')
colnames(app_inv)

# Both mode should be SAME!
mode(app_inv$application_number)
mode(merged_disambig_apps$application_number)

# Create a column `ID` combining application number, first name, middle name and last name
merged_disambig_apps$ID <- paste(merged_disambig_apps$application_number, merged_disambig_apps$firstname, merged_disambig_apps$middlename, merged_disambig_apps$lastname )
app_inv$ID <- paste(app_inv$application_number, app_inv$firstname, app_inv$lastname)

last_merge <- merge(merged_disambig_apps, app_inv, by ='ID')

saveRDS(last_merge, "last_merge.Rds") # Save the file

colnames(last_merge)
nrow(last_merge)





