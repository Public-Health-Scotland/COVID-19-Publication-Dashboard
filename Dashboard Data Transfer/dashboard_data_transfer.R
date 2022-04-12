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
library(reshape)
library(reshape2)
library(stringr)
library(data.table)
library(stats)
library(zoo)
library(tidyr)
library(readxl)
# remotes::install_github("RosalynLP/friendlyloader")
# Provides the following functions:
# ----------------------------------
# read_csv_with_options
# read_excel_with_options
# read_all_sheets
library(friendlyloader)


# Getting main script location for working directory
path_main_script_location = dirname(rstudioapi::getActiveDocumentContext()$path)

setwd(path_main_script_location)

report_date <- floor_date(today(), "week", 1) + 2


dashboard_folder <- "/conf/PHSCOVID19_Analysis/COVID-19-Publication-Dashboard/"
output_folder <- glue(dashboard_folder, "shiny_app/data/")
input_data <- glue(dashboard_folder, "Dashboard Data Transfer/Input data/")
test_output <- glue(dashboard_folder, "Dashboard Data Transfer/Test output/")


# Getting useful functions
source("data_transfer_functions.R")

# Getting population information
# ------------------------------
i_population <- read_csv_with_options(glue(input_data, "population.csv"))

i_population %<>% dplyr::rename(age_group = contains("MYE")) %>%
  melt(id=c("age_group"), variable="sex") %>%
  dplyr::rename(pop_number=value)

i_population[i_population == "May-14"] <- "5-14"
i_population$age_group[i_population$age_group == "total"] <- "All"
i_population$age_group <- sapply(i_population$age_group, function(x) str_remove(x, "years"))
i_population$age_group <- sapply(i_population$age_group, function(x) str_remove_all(x, " "))

# Key within each transfer file:
# ------------------------------
# i: input files - from weekly report data folder copied across
# o: output - dashboard output folder updated last week
# g: generated in this script - for replainscing output

##### 1. NHS24

source("Transfer scripts/transfer_NHS24.R")

##### 2. ICU

source("Transfer scripts/transfer_ICU.R")

##### 3. Community Hubs and Assessment

source("Transfer scripts/transfer_commhubsassessment.R")

##### 4. SAS

source("Transfer scripts/transfer_SAS.R")

##### 5. Admissions

source("Transfer scripts/transfer_admissions.R")

##### 6. Lab Data

source("Transfer scripts/transfer_labdata.R")

##### 7. NHS24 Community

source("Transfer scripts/transfer_NHS24community.R")

##### 8. NHS Inform

source("Transfer scripts/transfer_NHSInform.R")

##### 9. Community Testing

source("Transfer scripts/transfer_communitytesting.R")

##### 10. Health Care Workers

source("Transfer scripts/transfer_HCW.R")

##### 11. Care Homes

source("Transfer scripts/transfer_carehomes.R")

##### 12. Contact Tracing

source("Transfer scripts/transfer_CT.R")

##### 13. Hospital Admissions

source("Transfer scripts/transfer_cases.R")

##### 14. Self Help Guides

source("Transfer scripts/transfer_selfhelp.R")

##### 15. Ethnicity
# NB often not updated week on week
#source("Transfer scripts/transfer_ethnicity.R")

##### 16. Quarantine

#source("Transfer scripts/transfer_quarantine.R")

##### 17. NHS Proximity app

source("Transfer scripts/transfer_proximityapp.R")

##### 18. LFD

source("Transfer scripts/transfer_LFD.R")

##### 19. Travel

#source("Transfer scripts/transfer_travel.R")

##### 20. Settings

# Hasn't been updated on the dashboard since August so leaving blank here for now

##### 21. Vaccine certification

source("Transfer scripts/transfer_vaccinecert.R")


##### 22. Length of Stay

source("Transfer scripts/transfer_los.R")






