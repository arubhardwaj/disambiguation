# Step-1
The first data file was all_results.txt which was downloaded from the dropbox. First, it requires some changes in the names of variables to identify them properly. Columns where renamed as follows:

application_number = V1,
raw_uuid = V2,
inventor_disambiguated = V3,
firstname = V4,
middlename = V5,
lastname = V6,
state = V8,
filing_date = V9,
invention_title = V10
In this file there is also one more column named V7, which was not taken in the data as it was blank. At this stage the all_results.txt file has 18725297 rows. 

In this file there are 494830 unique for the inventor disambiguated. 

This file was exported and saved as disambig_apps.csv. 

# Step-2

Then I selected only 4 columns from the all_applications.csv file. Which was downloaded from the USPTO’s website.  The 4 columns selected were: application_number,filing_date, patent_number, invention_title. After this, this file was saved as all_application.csv. 

To clean this data we dropped rows where patent_id was blank (or Null/NA). We also dropped  "D251712" and "NONE" entries from this column. At this stage patent_id was unique throughout and there were no duplicates in the data. 

# Step-3
In this step, we merged the disambig_apps.csv and all_application.csv files by application_number. This file was named as granted_patents. It is important to check if application_number in the both files is “numeric”, if not then it should be converted to numeric type in the R environment. 

Also, the NA values in the application_number column are dropped (along with the first column only IF these two files were exported from R. As exported files in CSV creates one column for serial numbers.  

Inventor.tsv file did not need any changes. So we merged patent_inventor.tsv and inventors.tsv by inventor_id. In this step we also converted all First Name and Last Name in uppercase. Then this file was exported as inventor.csv (all_inventor.csv in table).

# Step-4
Now is the time to merge patent_inventor.csv and inventor.csv by inventor_id. And this is exported as patents_inventors_merged.csv.

# Step-5
Here I created a unique ID by combining application_number column with firstname, middlename and lastname column, and named it as ID. This column is now there in both the datasets so we merged bothmerged_disambig_apps.csv and patents_inventors_merged.csv by ID. The final output is exported as last_merge.RDS
