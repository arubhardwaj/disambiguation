import delimited ${disambiguation_files}patent_inventor.tsv, clear
rename v1 patent_id
rename v2 inventor_id
drop if patent_id == "patent_id"
save ${filedata}disambiguation_files/patent_inventor.dta, replace

import delimited ${disambiguation_files}inventor.tsv, clear
rename v1 inventor_id
rename v2 firstname
rename v3 lastname
drop if inventor_id == "id"
split firstname, p(" ")
keep inventor_id firstname1 lastname
rename firstname1 firstname
replace firstname = upper(firstname)
replace lastname = upper(lastname)
save ${filedata}disambiguation_files/inventor.dta, replace

merge 1:m inventor_id using ${disambiguation_files}patent_inventor.dta
drop if _merge != 3
drop _merge
save ${filedata}disambiguation_files/patents_inventors_merged, replace