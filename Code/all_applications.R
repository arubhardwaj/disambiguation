#install.packages('radr')
library(readr)
#install.packages('data.table')
library(data.table)
#install.packages('tidyverse')
library(tidyverse)


#----------------------------------------------------------------------------------------------------
# Import Full application_data
#----------------------------------------------------------------------------------------------------

#application_data <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/application_data_FULL.csv")
#head(application_data)

#----------------------------------------------------------------------------------------------------
# Required Columns from application_data_FULL
#----------------------------------------------------------------------------------------------------

# Create a new data frame of required columns
#application_data <-  subset(application_data, select = c(application_number,filing_date, patent_number, invention_title) )
#colnames(application_data)
#dim(application_data)




application_data <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/application_data.csv")
head(application_data)



#save.image("application_data.RData") # to save the workflow!
#write.csv(application_data, "application_data.csv")

application_data <- application_data[!application_data$patent_number=="",]

application_data <- application_data%>%
                        rename(patent_id=patent_number)

head(application_data)

table(application_data$patent_id==6795487)


# Dropping rows with duplicate IDs

application_data$patent_id[duplicated(application_data$patent_id)]

application_data <- application_data[!application_data$patent_id=="D251712" | !application_data$patent_id=="None",]

# Do we have any more duplicates left? 
any(duplicated(names(application_data$patent_id)))
