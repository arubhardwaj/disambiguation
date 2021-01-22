#install.packages('radr')
library(readr)
#install.packages('data.table')
library(data.table)
#install.packages('tidyverse')
library(tidyverse)



all_inventors <- data.table::fread("/home/arubhardwaj/E/disambiguation/DATA/all_inventors.csv")
head(all_inventors)


