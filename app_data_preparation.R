# Data preparation for app

rm(list = ls())
gc()

###############################################.
## Functions/Packages/filepaths/lookups ----
###############################################.

#source("functions_packages_data_prep.R")
setwd("/conf/PHSCOVID19_Analysis/COVID-19-Publication-Dashboard/shiny_app")

library(lubridate)#dates
library(tidyverse)
library(janitor) # round_half_up

non_empty_cols <- function(x) { sum(!is.na(x)) > 0  }

# Lab Cases
LabCases <- read_csv("data/LabCases.csv") %>%
  select_if(non_empty_cols)
LabCases <- LabCases %>%
  dplyr::rename(Count = NumberCasesperDay) %>%
  mutate(Date =ymd(Date))
saveRDS(LabCases, "data/LabCases.rds")

# Reinfections

LabCasesReinfections <- read_csv("data/LabCasesReinfections.csv") %>%
  select_if(non_empty_cols)
LabCasesReinfections <- LabCasesReinfections %>%
  dplyr::rename(Count = NumberCasesperDay) %>%
  mutate(Date =ymd(Date))
saveRDS(LabCasesReinfections, "data/LabCasesReinfections.rds")

# Admissions
Admissions <- read_csv("data/Admissions.csv") %>%
  select_if(non_empty_cols)
Admissions <- Admissions %>%
  dplyr::rename(Date = ADMISSION_DATE1,
                Count = TESTEDIN)%>%
  mutate(Date = ymd(Date))

saveRDS(Admissions, "data/Admissions.rds")

# ICU
ICU <- read_csv("data/ICU.csv") %>%
  select_if(non_empty_cols)
ICU <- ICU %>%
  mutate(Date = ymd(Date)) %>%
  dplyr::rename(Average7 = `7-Day Moving Average`)
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

#Quarantine
Quarantine <- read_csv("data/Quarantine.csv")
saveRDS(Quarantine, "data/Quarantine.rds")

#Vaccine Certification
VaccineCertification <- read_csv("data/VaccineCertification.csv")
saveRDS(VaccineCertification, "data/VaccineCertification.rds")

#LFD
LFD<- read_csv("data/LFD_Board.csv")
saveRDS(LFD, "data/LFD.rds")
LFD_Weekly<- read_csv("data/LFD_Weekly.csv")
saveRDS(LFD_Weekly, "data/LFD_Weekly.rds")
LFD_TestGroup <- read_csv("data/LFD_TestGroup.csv")
saveRDS(LFD_TestGroup, "data/LFD_TestGroup.rds")

#read age/sex/deprivation data
LabCases_AgeSex <- read_csv("data/LabCases_AgeSex.csv")
saveRDS(LabCases_AgeSex, "data/LabCases_AgeSex.rds")

LabCases_SIMD <- read_csv("data/LabCases_SIMD.csv") %>%
  mutate(cases_pc = cases_pc * 100)
saveRDS(LabCases_SIMD, "data/LabCases_SIMD.rds")

LabCases_Age <- read_csv("data/LabCases_Age.csv") %>%
  group_by(Date) %>%
  mutate(Percent = round_half_up(100*Cases/sum(Cases), 2)) %>%
  select(-Cases)
saveRDS(LabCases_Age, "data/LabCases_Age.rds")

Admissions_AgeSex <- read_csv("data/Admissions_AgeSex.csv") %>%
  select(1:4)
saveRDS(Admissions_AgeSex, "data/Admissions_AgeSex.rds")

Cases_Adm <- read_csv("data/Cases_Adm.csv") %>%
  dplyr::rename(date = Date, count = Percent) %>%
  mutate(count = round_half_up(count,2))
saveRDS(Cases_Adm, "data/Cases_Adm.rds")

Cases_Age <- read_csv("data/Cases_AgeGrp.csv") %>%
  group_by(Date) %>%
  mutate(Percent = round_half_up(100*Cases/sum(Cases), 2)) %>%
  select(-Cases) %>%
  # Removing square brackets
  dplyr::mutate(Age = gsub(pattern = "\\[|\\]",
                                   replacement = "",
                                   Age))
saveRDS(Cases_Age, "data/Cases_AgeGrp.rds")

Prop_Adm_AgeGrp = read_csv("data/Prop_Admitted_AgeGrp.csv")
saveRDS(Prop_Adm_AgeGrp, "data/Prop_Admitted_AgeGrp.rds")


Admissions_AgeBD <- read_csv("data/Admissions_AgeBD.csv")
saveRDS(Admissions_AgeBD, "data/Admissions_AgeBD.rds")

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

colnames(NHS24_community) <- gsub("\\.", " ", colnames(NHS24_community)) # Remove . in outcomes

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

#
# # Children  Cases
# ChildCases <- read_csv("data/cases_children.csv")
# ChildCases <- ChildCases %>%
#   #dplyr::rename(Count = NumberCasesperDay) %>%
#   mutate(`Week ending` = ymd(`Week ending`),
#          `% of patients testing positive` = `% of patients testing positive`*100)
# saveRDS(ChildCases, "data/ChildCases.rds")
#
#
# # Children  tests
# ChildTests <- read_csv("data/tests_children.csv")
# ChildTests <- ChildTests %>%
#   #dplyr::rename(Count = NumberCasesperDay) %>%
#   mutate(`Week ending` = ymd(`Week ending`),
#          `%Positive` = `%Positive`*100)
# saveRDS(ChildTests, "data/ChildTests.rds")
#
#
# # This is simplified data for child testing
# ChildDataCases <- ChildCases %>%
#   gather(`Number of Patients tested`, `Number of patients tested positive`, `Number of patients tested negative`,
#          `% of patients testing positive`, `Rate per 100,000`,
#          key = Indicator, value = "value") %>%
#   spread(key = `Age Group`, value="value")
#
# ChildDataTests <- ChildTests %>%
#   gather(`Total Tests`, `Positives`, `Negatives`,
#          `%Positive`,
#          key = Indicator, value = "value") %>%
#   spread(key = `Age Group`, value="value")
#
# ChildData  <- ChildDataCases %>%
#   rbind(ChildDataTests)
# saveRDS(ChildData, "data/Child.rds")


# Contact Tracing ---------------------------------------------------------
#ContactTracing <- read_csv("data/ContactTracingWeekly.csv") %>%
#  mutate(WeekEnding = ymd(WeekEnding))
#saveRDS(ContactTracing, "data/ContactTracingWeekly.rds")

ContactTime <- read_csv("data/ContactTime.csv")
ContactTime <- ContactTime %>%
  mutate_if(is.numeric, round_half_up, 2) %>%
  mutate(week_ending = ymd(week_ending))
saveRDS(ContactTime, "data/ContactTime.rds")


# #Cases reporting an occupation in the Education and Childcare sector
# ContactEC <- read_csv("data/ContactTracingEducation.csv")
# ContactEC <- ContactEC %>%
#   mutate_if(is.numeric, round_half_up, 2) %>%
#   mutate(week_ending = ymd(week_ending))
# saveRDS(ContactEC, "data/ContactTracingEducation.rds")


ContactTracingWeeklyCases <- read_csv("data/ContactTracingWeeklyCases.csv") %>%
  mutate(`Week ending` = ymd(`Week ending`))
saveRDS(ContactTracingWeeklyCases, "data/ContactTracingWeeklyCases.rds")


ContactTracingWeeklyCumulative <- read_csv("data/ContactTracingWeeklyCumulative.csv")
saveRDS(ContactTracingWeeklyCumulative, "data/ContactTracingWeeklyCumulative.rds")

ContactTracingAverages <- read_csv("data/ContactTracing_Average.csv")
saveRDS(ContactTracingAverages, "data/ContactTracingAverages.rds")

ContactTracingFail <- read_csv("data/ContactTracingFail.csv")
saveRDS(ContactTracingFail, "data/ContactTracingFail.rds")

#ContactTracingAveragesAge <- read_csv("data/ContactTracing_Average_Age.csv")
#saveRDS(ContactTracingAveragesAge, "data/ContactTracingAveragesAge.rds")

ContactTracingTestingPositive <- read_csv("data/ContactTracing_Testing_Positive.csv")
saveRDS(ContactTracingTestingPositive, "data/ContactTracingTestingPositive.rds")

ContactTracingRegions <- read_csv("data/ContactTracingRegions.csv")
saveRDS(ContactTracingRegions, "data/ContactTracingRegions.rds")

ContactTracingInterviews <- read_csv("data/ContactTracingInterviews.csv")
saveRDS(ContactTracingInterviews, "data/ContactTracingInterviews.rds")

ProximityApp <- read_csv("data/ProximityApp.csv")
saveRDS(ProximityApp, "data/ProximityApp.rds")

#ContactTracingDemoAge <- read_csv("data/ContactTracingDemoAge.csv")
#saveRDS(ContactTracingDemoAge, "data/ContactTracingDemoAge.rds")

#ContactTracingDemoSex <- read_csv("data/ContactTracingDemoSex.csv")
#saveRDS(ContactTracingDemoSex, "data/ContactTracingDemoSex.rds")

#ContactTracingDemoSIMD <- read_csv("data/ContactTracingDemoSIMD.csv")
#saveRDS(ContactTracingDemoSIMD, "data/ContactTracingDemoSIMD.rds")

# Settings ----------------------------------------------------------------

Settings <- read_csv("data/Settings.csv")

#Settings <- read_csv(file.choose())

AllSettings <- Settings %>%
  select(-`Setting Location`) %>%
  group_by(week_ending, `Setting Type`) %>%
  summarise(`Number of  Cases` = sum(`Number of  Cases`)) %>%
  dplyr::rename(`Setting Location` = `Setting Type`) %>%
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
saveRDS(Ethnicity, "data/Ethnicity.rds")

Ethnicity_Chart <- read_csv("data/Ethnicity_Chart.csv")
saveRDS(Ethnicity_Chart, "data/Ethnicity_Chart.rds")

#### Care Homes ----------------------------------------------------------------
care_homes <- read_csv("data/CareHomes.csv") %>%
  mutate(`Week Ending` = ymd(`Week Ending`))
saveRDS(care_homes, "data/Care_Homes.rds")


#### Community Testing ---------------------------------------------------------
replace_zero <- function(x){
  case_when(x == 0 ~ NA_real_,
            x != 0 ~ as.numeric(x))
}

suppress <- function(variable){
  if_else(variable < 5 & variable != 0, "*", as.character(variable))
}

#
# # time series outputs
mtu_ts <- read_csv("data/AllCommunity_Testing_byWeek.csv")

mtu_1.1 <- mtu_ts %>% filter(test_centre != "All") %>%
  select(test_centre, hb2019name, week_ending,
         week_ending_label, total_tests) %>%
  mutate(total_tests = replace_zero(total_tests),
         week_ending = ymd(week_ending))

# mtu_1.1 <- mtu_1 %>% filter(Test_centre != "All") %>%
#   mutate(Number_of_tests =  replace_zero(Number_of_tests))
saveRDS(mtu_1.1, "data/TCT_TestCentres.rds")
#
# mtu_1.2 <- mtu_1 %>% filter(Test_centre == "All")
# saveRDS(mtu_1.2, "data/TCT_AllTestCentres.rds")
mtu_1.2 <- mtu_ts %>%
  group_by(week_ending, week_ending_label, hb2019name) %>%
  summarise_at(vars(total_tests:mtu_tests), sum) %>%
  ungroup() %>%
  mutate(week_ending = ymd(week_ending),
         positive_tests = suppress(positive_tests))
saveRDS(mtu_1.2, "data/TCT_AllTestCentres.rds")

#
# # cumulative outputs
mtu_ct <- read_csv("data/Community_Testing_Totals.csv")

mtu_2 <- mtu_ct %>%
  select(`Health Board` = hb2019name,
         Symptomatic = symptomatic,
         Asymptomatic = asymptomatic) %>%
  pivot_longer(cols = 2:3) %>%
  filter(`Health Board` != "All")

saveRDS(mtu_2, "data/TCT_HBSymptomaticFlag.rds")

mtu_3 <- mtu_ct %>% mutate(percent_positive = round_half_up(100*positive_tests/total_tests,2)) %>%
  select(hb2019name, total_tests, positive_tests, percent_positive) %>%
  mutate(positive_tests = suppress(positive_tests),
         percent_positive  = if_else(percent_positive =="*",
                                     "*", paste(percent_positive))) %>%
  dplyr::rename(`Health Board` = hb2019name)

# secondary suppress?
if(sum(mtu_3$positive_tests == "*") == 1){
  a <- suppressWarnings(as.numeric(mtu_3$positive_tests))
  index <- which(a == min(a, na.rm = TRUE))
  a[index] <- "*"
  a[which(is.na(a))] <- "*"
  mtu_3$positive_tests <- a
}

# mtu_3 <- read_csv("data/CommunityTesting_HB_percent_positive.csv")
# mtu_3 <- mtu_3 %>% dplyr::rename(`Health Board` = hb2019name)
saveRDS(mtu_3, "data/TCT_HBPercentPositive.rds")


mtu_4 <- mtu_ct %>%
  select(`Health Board` = hb2019name,
         MTU = mtu_tests,
         ATS = ats_tests) %>%
  pivot_longer(cols = 2:3) %>%
  filter(`Health Board` != "All")

saveRDS(mtu_4, "data/TCT_HBTestSiteType.rds")

#
# # Key Points
mtu_5 <- read_csv("data/CommunityTesting_key_points.csv")
saveRDS(mtu_5, "data/TCT_KeyPoints.rds")
