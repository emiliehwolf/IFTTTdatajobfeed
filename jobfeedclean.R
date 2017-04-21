## Get and Clean Job Postings spreadsheet
## 
## Author: Emilie H. Wolf
## Date: April 20, 2017
##
## Place this script and datajobs.xlsx in same folder and
## set the working directory to where they are located.

library(lubridate)
library(xlsx)
library(stringr)
library(tidyr)

## Read in Excel spreadsheet
jobdata <- read.xlsx("./datajobs.xlsx", sheetIndex = 1, header=FALSE)

## Use lubridate to change the time column to the proper time class format
times <- mdy_hm(jobdata[,1])

## Change the other columns to character
titles <- as.character(jobdata[,2])
descriptions <- as.character(jobdata[,3])

## Create new headers and create a new data frame
jobdata <- data.frame(Time = times, Title = titles,
                      Description = descriptions, stringsAsFactors = FALSE)

rm(descriptions,times,titles)

## Split a column to extract the City and State (after last instance of hyphen)
tidy <- extract(jobdata, Title, into=c("hash","CityState"), "(.*) - +([^-]+)$")

