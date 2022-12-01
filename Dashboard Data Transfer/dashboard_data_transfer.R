#####################################################
# Script to transfer data from Input data folder    #
# to dashboard data folder                          #
# Author: Rosalyn Pearson; rosalyn.pearson@phs.scot #
# Date created: 17/11/2021                          #
#####################################################

library(dplyr)
library(magrittr)
library(glue)
library(openxlsx)
library(lubridate)
library(janitor)
library(stringr)
library(data.table)
library(stats)
library(zoo)
library(tidyr)
library(readxl)
library(readr)
# remotes::install_github("RosalynLP/friendlyloader")
# Provides the following functions:
# ----------------------------------
# read_csv_with_options
# read_excel_with_options
# read_all_sheets
library(friendlyloader)

# Setting permisisons for files outputted
Sys.umask("006")

# Getting main script location for working directory
path_main_script_location = dirname(rstudioapi::getActiveDocumentContext()$path)

setwd(path_main_script_location)

report_date <- floor_date(today(), "week", 1) + 2


# Dashboard main folder is located one up from data transfer
dashboard_folder <- "../"
# Output to weekly dashboard data folder (shared)
input_data <- "/conf/C19_Test_and_Protect/Test & Protect - Warehouse/Weekly Dashboard Data/Input/"
output_folder <- "/conf/C19_Test_and_Protect/Test & Protect - Warehouse/Weekly Dashboard Data/Output/"


# Getting useful functions
source("data_transfer_functions.R")

# Getting population information
# ------------------------------

copy_bool <- file.copy(
  from="/conf/C19_Test_and_Protect/Test & Protect - Warehouse/Weekly Dashboard Data/population.csv",
  to=glue("{input_data}/population.csv"),
  overwrite=TRUE)

if (copy_bool == FALSE){
  stop("Failed to copy population.csv to input data. Check that population.csv is in
       /conf/C19_Test_and_Protect/Test & Protect - Warehouse/Weekly Dashboard Data/")
}

i_population <- read_csv_with_options(glue(input_data, "population.csv"))  %>%
  dplyr::rename(age_group = contains("MYE"))

i_population %<>%
  pivot_longer(cols=c("Male", "Female", "Total"), values_to="value", names_to="sex") %>%
  dplyr::rename(pop_number=value)

i_population[i_population == "May-14"] <- "5-14"
i_population$age_group[i_population$age_group == "total"] <- "All"
i_population$age_group <- sapply(i_population$age_group, function(x) str_remove(x, "years"))
i_population$age_group <- sapply(i_population$age_group, function(x) str_remove_all(x, " "))


# Refresh input data folder ----
# Clear input data
purrr::walk(list.files(path=input_data, full.names=TRUE), unlink, recursive=TRUE)

# Copy new files across from data folder
data_folder <- glue("/conf/C19_Test_and_Protect/Test & Protect - Warehouse/",
                                    "Weekly Data Folders/{report_date}/Data")

data_files = list.files(path=data_folder, recursive=TRUE, full.names=TRUE)
purrr::walk(data_files, file.copy, to = input_data, recursive=TRUE, overwrite=TRUE)

# Key within each transfer file:
# ------------------------------
# i: input files - from weekly report data folder copied across
# o: output - dashboard output folder updated last week
# g: generated in this script - for replainscing output

##### 1. ICU
source("Transfer scripts/transfer_ICU.R")

##### 2. Admissions
source("Transfer scripts/transfer_admissions.R")

##### 3. Lab Data
source("Transfer scripts/transfer_labdata.R")

##### 4. Care Homes
source("Transfer scripts/transfer_carehomes.R")
source("Transfer scripts/transfer_carehomes_sg.R")

##### 5. Ethnicity
# Updated quarterly
#source("Transfer scripts/transfer_ethnicity.R")

##### 6. LFD
source("Transfer scripts/transfer_LFD.R")

##### 7. Length of Stay
source("Transfer scripts/transfer_los.R")

##### 8. Vaccine certification
source("Transfer scripts/transfer_vaccinecert.R")

#############################
###### Updated monthly ######
#############################

##### 9. Vaccine Wastage
source("Transfer scripts/transfer_vaccinewaste.R")


##### Archived -----

##### 1. NHS24
#source("Transfer scripts/transfer_NHS24.R")

##### 2. Community Hubs and Assessment
#source("Transfer scripts/transfer_commhubsassessment.R")

##### 3. NHS24 Community
#source("Transfer scripts/transfer_NHS24community.R")

##### 4. NHS Inform
#source("Transfer scripts/transfer_NHSInform.R")

##### 5. Community Testing
#source("Transfer scripts/transfer_communitytesting.R")

##### 6. Health Care Workers
#source("Transfer scripts/transfer_HCW.R")

##### 7. Care Homes
#source("Transfer scripts/transfer_carehomes_archive.R")

##### 8. Contact Tracing
#source("Transfer scripts/transfer_CT.R")

##### 9. Quarantine
#source("Transfer scripts/transfer_quarantine.R")

##### 10. NHS Proximity app
#source("Transfer scripts/transfer_proximityapp.R")

##### 11. Travel
#source("Transfer scripts/transfer_travel.R")

##### 12. Settings
# Hasn't been updated on the dashboard since August so leaving blank here for now

##### 13. Outdated Hospital Admissions
#source("Transfer scripts/transfer_cases.R")

#### 14. Self Help Guides
#source("Transfer scripts/transfer_selfhelp.R")

##### 15. SAS
#source("Transfer scripts/transfer_SAS.R")
