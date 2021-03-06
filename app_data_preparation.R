# Data preparation for app

rm(list = ls())
gc()  
###############################################.
## Functions/Packages/filepaths/lookups ----
###############################################.

library(lubridate)#dates
library(tidyverse)
library(janitor) # round_half_up

non_empty_cols <- function(x) { sum(!is.na(x)) > 0  }

#source("functions_packages_data_prep.R")
setwd("/conf/PHSCOVID19_Analysis/COVID-19-Publication-Dashboard/shiny_app")

# Lab Cases
LabCases <- read_csv("data/LabCases.csv") %>% 
  select_if(non_empty_cols)
LabCases <- LabCases %>% 
  rename(Count = NumberCasesperDay) %>% 
  mutate(Date =ymd(Date))
saveRDS(LabCases, "data/LabCases.rds")

# Admissions
Admissions <- read_csv("data/Admissions.csv") %>% 
  select_if(non_empty_cols)
Admissions <- Admissions %>% 
  rename(Date = ADMISSION_DATE1,
         Count = TESTEDIN)%>% 
  mutate(Date = ymd(Date))
  
saveRDS(Admissions, "data/Admissions.rds")

# ICU
ICU <- read_csv("data/ICU.csv") %>% 
  select_if(non_empty_cols)
ICU <- ICU %>% 
  mutate(Date = ymd(Date)) %>%
  rename(Average7 = `7-Day Moving Average`)
saveRDS(ICU, "data/ICU.rds")

# NHS24
NHS24 <- read_csv("data/NHS24.csv")
NHS24 <- NHS24 %>% 
  mutate(Date = ymd(Date))
saveRDS(NHS24, "data/NHS24.rds")

#SAS
SAS <- read_csv("data/SAS.csv")
SAS <- SAS %>% 
  mutate(Date = ymd(Date))
saveRDS(SAS, "data/SAS.rds")

#AssessmentHub
AssessmentHub <- read_csv("data/AssessmentHub.csv") 
AssessmentHub <- AssessmentHub %>% 
  mutate(Date = ymd(Date))
saveRDS(AssessmentHub, "data/AssessmentHub.rds")

#NHS Inform
NHSInform <- read_csv("data/NHSInform.csv")
NHSInform <- NHSInform %>% 
  mutate(date = ymd(date)) 
saveRDS(NHSInform, "data/NHSInform.rds")

#NHS24 Self Help Guides
SelfHelp <- read_csv("data/SelfHelpGuides.csv")
SelfHelp <- SelfHelp %>% 
  mutate(Date = ymd(Date))
saveRDS(SelfHelp, "data/SelfHelp.rds")


#read age/sex/deprivation data
LabCases_AgeSex <- read_csv("data/LabCases_AgeSex.csv")
saveRDS(LabCases_AgeSex, "data/LabCases_AgeSex.rds")

LabCases_SIMD <- read_csv("data/LabCases_SIMD.csv") %>% 
  mutate(cases_pc = cases_pc * 100)
saveRDS(LabCases_SIMD, "data/LabCases_SIMD.rds")

Admissions_AgeSex <- read_csv("data/Admissions_AgeSex.csv") %>% 
  select(1:4)
saveRDS(Admissions_AgeSex, "data/Admissions_AgeSex.rds")

Admissions_SIMD <- read_csv("data/Admissions_SIMD.csv") %>% 
  mutate(cases_pc = cases_pc * 100) %>% select(1:3)
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

SAS_AgeSex <- read_csv("data/SAS_AgeSex.csv") %>% select(1:4)
saveRDS(SAS_AgeSex, "data/SAS_AgeSex.rds")

SAS_SIMD <- read_csv("data/SAS_SIMD.csv") %>% mutate(cases_pc = cases_pc * 100)
saveRDS(SAS_SIMD, "data/SAS_SIMD.rds")

# #read NHS24/SAS other data
# NHS24_inform <- read_csv("data/NHSInform.csv") %>% mutate(date = as.Date(date, "%d-%b-%y"))
# saveRDS(NHS24_inform, "data/NHS24_inform.rds")
# 
# NHS24_selfhelp <- read_csv("data/NHS24_selfhelp.csv") %>% mutate(date = as.Date(date, "%d-%b-%y"))
# saveRDS(NHS24_selfhelp, "data/NHS24_selfhelp.rds")

NHS24_community <- read_csv("data/NHS24_community.csv") %>% 
  select_if(non_empty_cols)
NHS24_community <- NHS24_community %>% 
                    pivot_longer(-date, 
                                 names_to = "outcome",
                                 values_to = "count") %>%
  mutate(date = ymd(date)) 

saveRDS(NHS24_community, "data/NHS24_community.rds")

SAS_all <- read_csv("data/SAS_all.csv") %>% 
  mutate(date = ymd(date)) %>% 
  select_if(non_empty_cols)
saveRDS(SAS_all, "data/SAS_all.rds")


# Child Data --------------------------------------------------------------


# Children  Cases
ChildCases <- read_csv("data/cases_children.csv")
ChildCases <- ChildCases %>% 
  #rename(Count = NumberCasesperDay) %>% 
  mutate(`Week ending` = ymd(`Week ending`), 
         `% of patients testing positive` = `% of patients testing positive`*100)
saveRDS(ChildCases, "data/ChildCases.rds")


# Children  tests
ChildTests <- read_csv("data/tests_children.csv")
ChildTests <- ChildTests %>% 
  #rename(Count = NumberCasesperDay) %>% 
  mutate(`Week ending` = ymd(`Week ending`), 
         `%Positive` = `%Positive`*100)
saveRDS(ChildTests, "data/ChildTests.rds")


# This is simplified data for child testing
ChildDataCases <- ChildCases %>% 
  gather(`Number of Patients tested`, `Number of patients tested positive`, `Number of patients tested negative`,
         `% of patients testing positive`, `Rate per 100,000`, 
         key = Indicator, value = "value") %>% 
  spread(key = `Age Group`, value="value")

ChildDataTests <- ChildTests %>% 
  gather(`Total Tests`, `Positives`, `Negatives`,
         `%Positive`, 
         key = Indicator, value = "value") %>% 
  spread(key = `Age Group`, value="value")

ChildData  <- ChildDataCases %>% 
  rbind(ChildDataTests)
saveRDS(ChildData, "data/Child.rds")


# Contact Tracing ---------------------------------------------------------
ContactTracing <- read_csv("data/ContactTracingWeekly.csv") %>%
  mutate(WeekEnding = ymd(WeekEnding))
saveRDS(ContactTracing, "data/ContactTracingWeekly.rds")

ContactTime <- read_csv("data/ContactTime.csv")
ContactTime <- ContactTime %>% 
  mutate_if(is.numeric, round_half_up, 2) %>%
  mutate(week_ending = ymd(week_ending))
saveRDS(ContactTime, "data/ContactTime.rds")


#Cases reporting an occupation in the Education and Childcare sector
ContactEC <- read_csv("data/ContactTracingEducation.csv")
ContactEC <- ContactEC %>% 
  mutate_if(is.numeric, round_half_up, 2) %>%
  mutate(week_ending = ymd(week_ending))
saveRDS(ContactEC, "data/ContactTracingEducation.rds")


ContactTracingWeeklyCases <- read_csv("data/ContactTracingWeeklyCases.csv") %>%
  mutate(`Week ending` = ymd(`Week ending`))
saveRDS(ContactTracingWeeklyCases, "data/ContactTracingWeeklyCases.rds")


ContactTracingWeeklyCumulative <- read_csv("data/ContactTracingWeeklyCumulative.csv")
saveRDS(ContactTracingWeeklyCumulative, "data/ContactTracingWeeklyCumulative.rds")



# Settings ----------------------------------------------------------------

Settings <- read_csv("data/Settings.csv")

#Settings <- read_csv(file.choose())

AllSettings <- Settings %>% 
  select(-`Setting Location`) %>% 
  group_by(week_ending, `Setting Type`) %>% 
  summarise(`Number of  Cases` = sum(`Number of  Cases`)) %>% 
  rename(`Setting Location` = `Setting Type`) %>% 
  mutate(`Setting Type` = "All setting types")

Settings <- Settings %>% 
  full_join(AllSettings) %>% 
  arrange(desc(`Setting Type`, `Number of  Cases`)) %>%
  mutate(week_ending = ymd(week_ending))


saveRDS(Settings, "data/Settings.rds")

# Health Care Workers -----------------------------------------------------

HCW_SpecialistCancer <- read_csv("data/HCW_SpecialistCancer.csv") %>% select(1:9)
saveRDS(HCW_SpecialistCancer, "data/HCW_SpecialistCancer.rds")

HCW_CareOfElderly <- read_csv("data/HCW_CareOfElderly.csv")
saveRDS(HCW_CareOfElderly, "data/HCW_CareOfElderly.rds")

HCW_Psychiatry <- read_csv("data/HCW_Psychiatry.csv")
saveRDS(HCW_Psychiatry, "data/HCW_Psychiatry.rds")

# Ethnicity -----------------------------------------------------------------

Ethnicity <- read_csv("data/Ethnicity.csv")
Ethnicity <- Ethnicity %>% 
  mutate(Date = month(Date, label = T, abbr = F),
         Percentage = Percentage*100)%>% 
  mutate_if(is.numeric, round, 2)
saveRDS(Ethnicity, "data/Ethnicity.rds")

Ethnicity_Chart <- read_csv("data/Ethnicity_Chart.csv")
Ethnicity_Chart <- Ethnicity_Chart %>% 
  mutate(Date = month(Date, label = T, abbr = F),
         White_p = White_p*100,
         `Black/Caribbean/African_p` = `Black/Caribbean/African_p`*100,
         `South Asian_p` = `South Asian_p`*100,
         Chinese_p = Chinese_p*100,
         Other_p = Other_p*100,
         `Not Available_p` = `Not Available_p`*100) %>% 
  mutate_if(is.numeric, round, 2)
saveRDS(Ethnicity_Chart, "data/Ethnicity_Chart.rds")


care_homes <- read_csv("data/CareHomes.csv") %>% 
  mutate(`Week Ending` = ymd(`Week Ending`))
saveRDS(care_homes, "data/Care_Homes.rds")
