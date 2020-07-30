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


#read age/sex/deprivation data
LabCases_AgeSex <- read_csv("data/LabCases_AgeSex.csv")
saveRDS(LabCases_AgeSex, "data/LabCases_AgeSex.rds")

LabCases_SIMD <- read_csv("data/LabCases_SIMD.csv") %>% mutate(cases_pc = cases_pc * 100)
saveRDS(LabCases_SIMD, "data/LabCases_SIMD.rds")

Admissions_AgeSex <- read_csv("data/Admissions_AgeSex.csv")
saveRDS(Admissions_AgeSex, "data/Admissions_AgeSex.rds")

Admissions_SIMD <- read_csv("data/Admissions_SIMD.csv") %>% mutate(cases_pc = cases_pc * 100)
saveRDS(Admissions_SIMD, "data/Admissions_SIMD.rds")

ICU_AgeSex <- read_csv("data/ICU_AgeSex.csv")
saveRDS(ICU_AgeSex, "data/ICU_AgeSex.rds")

NHS24_AgeSex <- read_csv("data/NHS24_AgeSex.csv")
saveRDS(NHS24_AgeSex, "data/NHS24_AgeSex.rds")

NHS24_SIMD <- read_csv("data/NHS24_SIMD.csv") %>% mutate(cases_pc = cases_pc * 100)
saveRDS(NHS24_SIMD, "data/NHS24_SIMD.rds")

AssessmentHub_AgeSex <- read_csv("data/AssessmentHub_AgeSex.csv")
saveRDS(AssessmentHub_AgeSex, "data/AssessmentHub_AgeSex.rds")

AssessmentHub_SIMD <- read_csv("data/AssessmentHub_SIMD.csv") %>% mutate(cases_pc = cases_pc * 100)
saveRDS(AssessmentHub_SIMD, "data/AssessmentHub_SIMD.rds")

SAS_AgeSex <- read_csv("data/SAS_AgeSex.csv")
saveRDS(SAS_AgeSex, "data/SAS_AgeSex.rds")

SAS_SIMD <- read_csv("data/SAS_SIMD.csv") %>% mutate(cases_pc = cases_pc * 100)
saveRDS(SAS_SIMD, "data/SAS_SIMD.rds")

#read NHS24/SAS other data
NHS24_inform <- read_csv("data/NHS24_inform.csv") %>% mutate(date = as.Date(date, "%d/%m/%y"))
saveRDS(NHS24_inform, "data/NHS24_inform.rds")

NHS24_selfhelp <- read_csv("data/NHS24_selfhelp.csv") %>% mutate(date = as.Date(date, "%d/%m/%y"))
saveRDS(NHS24_selfhelp, "data/NHS24_selfhelp.rds")

NHS24_community <- read_csv("data/NHS24_community.csv") %>% 
                    pivot_longer(-date, 
                                names_to = "outcome", 
                                values_to = "count")
saveRDS(NHS24_community, "data/NHS24_community.rds")

SAS_all <- read_csv("data/SAS_all.csv") %>% mutate(date = as.Date(date, "%d-%b-%y"))
saveRDS(SAS_all, "data/SAS_all.rds")

