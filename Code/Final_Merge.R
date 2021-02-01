library(data.table)
library(plyr)

merged_disambig_apps <- data.table::fread("DATA/merged_disambig_apps.csv", header = TRUE)
patents_inventors_merged <- data.table::fread("DATA/patents_inventors_merged.csv", header = TRUE)


nrow(merged_disambig_apps)
nrow(patents_inventors_merged)
#==============================================================

#colnames(patents_inventors_merged)
#colnames(merged_disambig_apps)

patentID_match <- intersect(patents_inventors_merged$patent_id, merged_disambig_apps$patent_id)

needed <- patentID_match

merged_disambig_apps <- merged_disambig_apps[merged_disambig_apps$patent_id %in% needed, ]
patents_inventors_merged <- patents_inventors_merged[patents_inventors_merged$patent_id %in% needed, ]

nrow(merged_disambig_apps)
nrow(patents_inventors_merged)


# Save files:

#write.csv(merged_disambig_apps,"DATA/merged_disambig_apps.csv")
#write.csv(patents_inventors_merged,"DATA/patents_inventors_merged.csv")

# Remove V1 Column from both datasets: This columns shows serial number, which will be generated again after merge()

merged_disambig_apps <- merged_disambig_apps[,-1]
patents_inventors_merged <- patents_inventors_merged[,-1]

head(merged_disambig_apps)
head(patents_inventors_merged)

# Combine Last Name and Patent_ID to create an ID to merge

ID_disambig <- paste(merged_disambig_apps$patent_id, merged_disambig_apps$lastname) 
ID_inventor <- paste(patents_inventors_merged$patent_id, patents_inventors_merged$lastname) 

merged_disambig_apps$ID <- ID_disambig
patents_inventors_merged$ID <- ID_inventor

# Removing Common Columns
head(patents_inventors_merged)
patents_inventors_merged <- patents_inventors_merged[,-5]
merged_disambig_apps <- merged_disambig_apps[,-4]
merged_disambig_apps <- merged_disambig_apps[,-5]

head(merged_disambig_apps)

#==============================================================================================
# Merging
#==============================================================================================

dt1 <- data.table(patents_inventors_merged, key = "ID") 
dt2 <- data.table(merged_disambig_apps, key = "ID")

all_merged <- dt1[dt2]
nrow(all_merged)
#write.csv(all_merged, "all_merged.csv")
saveRDS(all_merged, "all_merged.Rds") # exporting in Rds because it is light weight!

# Nrows
nrow(dt1)
nrow(dt2)

table(duplicated(all_merged$ID))
