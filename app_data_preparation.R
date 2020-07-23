# Data preparation for app

rm(list = ls())
gc()
###############################################.
## Functions/Packages/filepaths/lookups ----
###############################################.

library(lubridate)#dates
library(tidyverse)
source("functions_packages_data_prep.R")
setwd("//freddy/DEPT/PHIBCS/PHI/Publications/Health Topic/HPS/Covid-19/COVID19_Dashboard/")


# Lab Cases
LabCases <- read_csv("data/LabCases.csv")
LabCases <- LabCases %>% 
  rename(Count = NumberCasesperDay) %>% 
  mutate(Date = as.Date(Date, "%d/%B/%y"))
saveRDS(LabCases, "data/LabCases.rds")


# Admissions
Admissions <- read_csv("data/Admissions.csv")
Admissions <- Admissions %>% 
  rename(Date = ADMISSION_DATE1,
         Count = TESTEDIN)%>% 
  mutate(Date = as.Date(Date, "%d/%B/%y"))
  
saveRDS(Admissions, "data/Admissions.rds")


# ICU
ICU <- read_csv("data/ICU.csv")
ICU <- ICU %>% 
  mutate(Date = as.Date(Date, "%d/%B/%y"))
saveRDS(ICU, "data/ICU.rds")

# NHS24
NHS24 <- read_csv("data/NHS24.csv")
NHS24 <- NHS24 %>% 
  mutate(Date = as.Date(Date, "%d/%B/%y"))
saveRDS(NHS24, "data/NHS24.rds")



#SAS
SAS <- read_csv("data/SAS.csv")
SAS <- SAS %>% 
  mutate(Date = as.Date(Date, "%d/%B/%y"))
saveRDS(SAS, "data/SAS.rds")

#AssessmentHub
AssessmentHub <- read_csv("data/AssessmentHub.csv")
AssessmentHub <- AssessmentHub %>% 
  mutate(Date = as.Date(Date, "%d/%B/%y"))
saveRDS(AssessmentHub, "data/AssessmentHub.rds")

#NHS Inform
NHSInform <- read_csv("data/NHSInform.csv")
NHSInform <- NHSInform %>% 
  mutate(Date = as.Date(Date, "%d/%B/%y"))
saveRDS(NHSInform, "data/NHSInform.rds")

#NHS24 Self Help Guides
SelfHelp <- read_csv("data/SelfHelpGuides.csv")
SelfHelp <- SelfHelp %>% 
  mutate(Date = as.Date(Date, "%d/%B/%y"))
saveRDS(SelfHelp, "data/SelfHelp.rds")
