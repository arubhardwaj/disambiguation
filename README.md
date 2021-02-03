# Read Me

Below are the description about `.R` script each file.

## all_results.R

In this file, I processed the data from `all_results.txt` file. As mentioned in [`import_disambig.do`](https://github.com/arubhardwaj/disambiguation/blob/main/STATA/import_disambig.do) file, I renamed the columns:
(new name = old name)
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

- The first column name in these files was missing and it was because of processing the files and exporting from R to CSV. It created a columns of serial number. Those columns are deleted from both the datasets. 
- `application_number` in `application_data.csv` was not identified as numeric but in `disambig_apps.csv` it was shown into numeric type. Which is changed into numeric type in `application_data.csv` file.
- Removed rows with NAs from `application_number` column in `application_data.csv`.
- Deleted `V1` column in `application_data.csv` (as mentioned above, it was serial number).
- In the last setp, both `application_data.csv` and `disambig_apps.csv` files are merged according to `application_number` column. It dropped the rows which were not intersecting.


## merge_patents_inventors.R

In this script file, I imported two datasets: `patent_inventor.tsv` and `inventors.tsv`. And, processed according to the instructions in [`merge_patent_inventors.do`](https://github.com/arubhardwaj/disambiguation/blob/main/STATA/merge_patents_inventors.do) In the file, I had, `patents_inventor.tsv` were already renamed accordingly as descirbed in `.do` file. 

Columns in `inventor.tsv` needed to be renamed:
(new name = old name)
- inventor_id = id, 
- firstname = name_first, 
- lastname = name_last

`firstname` and `lastname` are converted into uppercase. And then, exported as `inventor.csv`. 

Merging of `patent_inventor.csv` and `inventor.csv` is done on the basis of `inventor_id` column. It dropped the rows which were not intersecting.


## Final_Merge.R

In this final script, `merged_disambig_apps.csv` and `patents_inventors_merged.csv` are merged. There was some trouble in merging these two data files because of being very large, therefore I extracted the rows which had common `patent_id` in both datasets. It reduced the row count and it become possible to process them further. 

Then, I merged `patent_id` column with `lastname` column. Since there were many duplicates in `patent_id`  it was not possible to process them. Algorithm of `merge()` of R was not able to process with too many duplicates and crashing.

The merged result of these 2 columns is named as `ID` column. In the last step, `merged_disambig_apps.csv` and `patents_inventors_merged.csv` were merged according to `ID` column. 

Merged file is exported as `all_merged.RDs`. File become super large after the merge, so it was difficult to export in CSV. However, R's data file exported it in compressed `RDs` format. 












 


