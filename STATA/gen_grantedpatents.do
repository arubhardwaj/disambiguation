use ${rawdata}2014/application_data, clear
drop if patent_number == ""
keep application_number filing_date patent_number invention_title
bysort patent_number: gen dups = _N
drop if dups > 1
drop dups
rename patent_number patent_id
save ${filedata}disambiguation_files/granted_patents, replace