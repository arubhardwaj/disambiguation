import delimited ${filedata}disambiguation_files/all-results.txt, stringcols(_all) clear

rename v1 application_number
rename v2 raw_uuid
rename v3 inventor_disambiguated
rename v4 firstname
rename v5 middlename
rename v6 lastname
drop v7 //this is blank and is supposed to show if there is other text after the name (jr, etc).
rename v8 state
rename v9 filing_date
rename v10 invention_title

save ${disambiguation_files}disambig_apps.txt, replace
