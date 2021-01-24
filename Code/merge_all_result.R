disambig_apps <- data.table::fread("DATA/disambig_apps.csv")
application_data <- data.table::fread("DATA/application_data.csv")

colnames(application_data)
colnames(disambig_apps) 

#==================================================================================
names(application_data)[1]<-paste("Srno")
application_data <- subset(application_data, select = -c(Srno))
disambig_apps <- subset(disambig_apps, select = -c(V1))

#====================================================================================
head(application_data)
head(disambig_apps)
mode(application_data$application_number)
mode(disambig_apps$application_number)
#=====================================================================================
#application_data$application_number <- as.numeric(application_data$application_number)
application_data$application_number <- as.numeric(application_data$application_number)

na.omit(application_data$application_number)
#table(is.na(application_data$application_number))

nrow(application_data)
nrow(disambig_apps)

disambig_apps <- disambig_apps[,-disambig_apps$V1]



merged_disambig_apps <- merge(disambig_apps, application_data, by = 'application_number')

saveRDS(merged_disambig_apps, "DATA/merged_disambig_apps.Rds") # exporting in Rds because it is light weight!
