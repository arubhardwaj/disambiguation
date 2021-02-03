# Read Me

Below are the description about `.R` script each file.

## all_results.R

In this file, I processed the data from `all_results.txt` file. As mentioned in `import_disambig.do` file, I renamed the columns:

- application_number = V1,
- raw_uuid = V2, 
- inventor_disambiguated = V3,
- firstname = V4,
- middlename = V5, 
- lastname = V6, 
- state = V8, 
- filing_date = V9,
- invention_title = V10

After changing names, I exported the file as `disambig_apps.csv`.

## all_applications.R

In this file, I made changes in the file name. As mentioned in the code, first I imported data file `all_applications_FULL.csv` and subset the data selecting only 4 columns: `application_number`,`filing_date`, `patent_number`, `invention_title`.  Then stored subset data file in `all_applications.csv`. 

After this, I followed all the steps described in [`gen_grandtedpatents.do`](https://github.com/arubhardwaj/disambiguation/blob/main/STATA/gen_grantedpatents.do) file. 

- I dropped all the rows from `patent_id` which were blank.
- I identified all the duplicates and removed it. In this file there were only 2 entries with duplicates: "D251712" and "NONE".
- Then I cross checked if there are anymore duplicates left? Fortunately, I found none.

## all_inventors.R

This file was to check if there is any need to make changes. I find, that all the column names were already **same** as stated in [`merge_patents_inventors.do`](https://github.com/arubhardwaj/disambiguation/blob/main/STATA/merge_patents_inventors.do) file. 

## merge_all_result.R

This script deals with `disambig_apps.csv` and `application_data.csv` (processed from all_results.R and all_applications.R). 




 


