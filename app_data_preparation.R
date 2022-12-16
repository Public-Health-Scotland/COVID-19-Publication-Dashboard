# Data preparation for app

# This script loads data from \\nssstats01\C19_Test_and_Protect\Test & Protect - Warehouse\Weekly Dashboard Data\Output
# and saves out .rds files needed for running the dashboard to the shiny_app/data folder in your Analyst space

rm(list = ls())
gc()

###############################################.
## Functions/Packages/filepaths/lookups ----
###############################################.

library(lubridate)#dates
library(tidyverse)
library(janitor) # round_half_up
library(readxl)
library(glue)

# Getting main script location for working directory
path_main_script_location = dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(path_main_script_location)

non_empty_cols <- function(x) { sum(!is.na(x)) > 0  }

week_start <- format( floor_date( today()+1, unit='week', week_start=1 ), "%d%m%Y")

output_folder <- "/conf/C19_Test_and_Protect/Test & Protect - Warehouse/Weekly Dashboard Data/Output/"

# Demographics
Demographics <- read_csv(glue("{output_folder}/Demographics.csv"))
saveRDS(Demographics, "shiny_app/data/Demographics.rds")

# Lab Cases
LabCases <- read_csv(glue("{output_folder}/LabCases.csv")) %>%
  select_if(non_empty_cols)
LabCases <- LabCases %>%
  dplyr::rename(Count = NumberCasesperDay) %>%
  mutate(Date =ymd(Date))
saveRDS(LabCases, "shiny_app/data/LabCases.rds")

# Reinfections

LabCasesReinfections <- read_csv(glue("{output_folder}/LabCasesReinfections.csv")) %>%
  select_if(non_empty_cols)
LabCasesReinfections <- LabCasesReinfections %>%
  dplyr::rename(Count = NumberCasesperDay) %>%
  mutate(Date =ymd(Date))
saveRDS(LabCasesReinfections, "shiny_app/data/LabCasesReinfections.rds")

# Admissions
Admissions <- read_csv(glue("{output_folder}/Admissions.csv")) %>%
  select_if(non_empty_cols)
Admissions <- Admissions %>%
  dplyr::rename(Date = ADMISSION_DATE1,
                Count = TESTEDIN)

saveRDS(Admissions, "shiny_app/data/Admissions.rds")

Admissions_SimdTrend <- read_csv(glue("{output_folder}/Admissions_SimdTrend.csv"))

saveRDS(Admissions_SimdTrend, "shiny_app/data/Admissions_SimdTrend.rds")

# ICU
ICU <- read_csv(glue("{output_folder}/ICU.csv")) %>%
  select_if(non_empty_cols)
ICU <- ICU %>%
  mutate(Date = ymd(Date)) %>%
  dplyr::rename(Average7 = `7-Day Moving Average`)
saveRDS(ICU, "shiny_app/data/ICU.rds")

# NHS24
NHS24 <- read_csv(glue("{output_folder}/NHS24.csv"))
NHS24 <- NHS24 %>%
  mutate(Date = ymd(Date))
saveRDS(NHS24, "shiny_app/data/NHS24.rds")

#SAS
SAS <- read_csv(glue("{output_folder}/SAS.csv"))
SAS <- SAS %>%
  mutate(Date = ymd(Date))
saveRDS(SAS, "shiny_app/data/SAS.rds")

#AssessmentHub
AssessmentHub <- read_csv(glue("{output_folder}/AssessmentHub.csv"))
AssessmentHub <- AssessmentHub %>%
  mutate(Date = ymd(Date))
saveRDS(AssessmentHub, "shiny_app/data/AssessmentHub.rds")

#NHS Inform
NHSInform <- read_csv(glue("{output_folder}/NHSInform.csv"))
NHSInform <- NHSInform %>%
  mutate(date = ymd(date))
saveRDS(NHSInform, "shiny_app/data/NHSInform.rds")

#NHS24 Self Help Guides
SelfHelp <- read_csv(glue("{output_folder}/SelfHelpGuides.csv"))
SelfHelp <- SelfHelp %>%
  mutate(Date = ymd(Date))
saveRDS(SelfHelp, "shiny_app/data/SelfHelp.rds")

#Quarantine
Quarantine <- read_csv(glue("{output_folder}/Quarantine.csv"))
saveRDS(Quarantine, "shiny_app/data/Quarantine.rds")

#Vaccine Certification
VaccineCertification <- read_csv(glue("{output_folder}/VaccineCertification.csv"))
saveRDS(VaccineCertification, "shiny_app/data/VaccineCertification.rds")

#LFD
LFD<- read_csv(glue("{output_folder}/LFD_Board.csv"))
saveRDS(LFD, "shiny_app/data/LFD.rds")
LFD_Weekly<- read_csv(glue("{output_folder}/LFD_Weekly.csv"))
saveRDS(LFD_Weekly, "shiny_app/data/LFD_Weekly.rds")
LFD_TestGroup <- read_csv(glue("{output_folder}/LFD_TestGroup.csv"))
saveRDS(LFD_TestGroup, "shiny_app/data/LFD_TestGroup.rds")

#read age/sex/deprivation data
LabCases_AgeSex <- read_csv(glue("{output_folder}/LabCases_AgeSex.csv"))
saveRDS(LabCases_AgeSex, "shiny_app/data/LabCases_AgeSex.rds")

LabCases_SIMD <- read_csv(glue("{output_folder}/LabCases_SIMD.csv"))
saveRDS(LabCases_SIMD, "shiny_app/data/LabCases_SIMD.rds")

LabCases_Age <- read_csv(glue("{output_folder}/LabCases_Age.csv")) %>%
  group_by(Date) %>%
  mutate(Percent = round_half_up(100*Cases/sum(Cases), 2)) %>%
  select(-Cases)
saveRDS(LabCases_Age, "shiny_app/data/LabCases_Age.rds")

LabCases_Age_All <- read_csv(glue("{output_folder}/LabCases_Age_All.csv")) %>%
  dplyr::rename("Age group" = "Age", "Cases" = "cases") %>%
  dplyr::arrange("Week ending")
saveRDS(LabCases_Age_All, "shiny_app/data/LabCases_Age_All.rds")

Admissions_AgeSex <- read_csv(glue("{output_folder}/Admissions_AgeSex.csv")) %>%
  select(1:4)
saveRDS(Admissions_AgeSex, "shiny_app/data/Admissions_AgeSex.rds")


Admissions_AgeBD <- read_csv(glue("{output_folder}/Admissions_AgeBD.csv"))
saveRDS(Admissions_AgeBD, "shiny_app/data/Admissions_AgeBD.rds")

Admissions_AgeGrp = read_csv(glue("{output_folder}/Admissions_AgeGrp.csv")) %>%
  group_by(Date) %>%
  mutate(Percent = round_half_up(100*Admissions/sum(Admissions), 2)) %>%
  select(-Admissions)
saveRDS(Admissions_AgeGrp, "shiny_app/data/Admissions_AgeGrp.rds")

Admissions_SIMD <- read_csv(glue("{output_folder}/Admissions_SIMD.csv")) %>%
  mutate(cases_pc = cases_pc * 100) %>% select(1:3)
saveRDS(Admissions_SIMD, "shiny_app/data/Admissions_SIMD.rds")

ICU_AgeSex <- read_csv(glue("{output_folder}/ICU_AgeSex.csv"))
saveRDS(ICU_AgeSex, "shiny_app/data/ICU_AgeSex.rds")

NHS24_AgeSex <- read_csv(glue("{output_folder}/NHS24_AgeSex.csv"))
saveRDS(NHS24_AgeSex, "shiny_app/data/NHS24_AgeSex.rds")

NHS24_SIMD <- read_csv(glue("{output_folder}/NHS24_SIMD.csv")) %>% mutate(cases_pc = cases_pc * 100)
saveRDS(NHS24_SIMD, "shiny_app/data/NHS24_SIMD.rds")

AssessmentHub_AgeSex <- read_csv(glue("{output_folder}/AssessmentHub_AgeSex.csv"))
saveRDS(AssessmentHub_AgeSex, "shiny_app/data/AssessmentHub_AgeSex.rds")

AssessmentHub_SIMD <- read_csv(glue("{output_folder}/AssessmentHub_SIMD.csv")) %>%
  mutate(cases_pc = cases_pc * 100)
saveRDS(AssessmentHub_SIMD, "shiny_app/data/AssessmentHub_SIMD.rds")

SAS_AgeSex <- read_csv(glue("{output_folder}/SAS_AgeSex.csv")) %>% select(1:4)
saveRDS(SAS_AgeSex, "shiny_app/data/SAS_AgeSex.rds")

SAS_SIMD <- read_csv(glue("{output_folder}/SAS_SIMD.csv")) %>% mutate(cases_pc = cases_pc * 100)
saveRDS(SAS_SIMD, "shiny_app/data/SAS_SIMD.rds")

# #read NHS24/SAS other data
# NHS24_inform <- read_csv(glue("{output_folder}/NHSInform.csv")) %>% mutate(date = as.Date(date, "%d-%b-%y"))
# saveRDS(NHS24_inform, "shiny_app/data/NHS24_inform.rds")
#
# NHS24_selfhelp <- read_csv(glue("{output_folder}/NHS24_selfhelp.csv")) %>% mutate(date = as.Date(date, "%d-%b-%y"))
# saveRDS(NHS24_selfhelp, "shiny_app/data/NHS24_selfhelp.rds")

NHS24_community <- read_csv(glue("{output_folder}/NHS24_community.csv")) %>%
  select_if(non_empty_cols)

colnames(NHS24_community) <- gsub("\\.", " ", colnames(NHS24_community)) # Remove . in outcomes

NHS24_community <- NHS24_community %>%
  pivot_longer(-date,
               names_to = "outcome",
               values_to = "count") %>%
  mutate(date = ymd(date))


saveRDS(NHS24_community, "shiny_app/data/NHS24_community.rds")

SAS_all <- read_csv(glue("{output_folder}/SAS_all.csv")) %>%
  mutate(date = ymd(date)) %>%
  select_if(non_empty_cols)
saveRDS(SAS_all, "shiny_app/data/SAS_all.rds")


# Child Data --------------------------------------------------------------

#
# # Children  Cases
# ChildCases <- read_csv(glue("{output_folder}/cases_children.csv")
# ChildCases <- ChildCases %>%
#   #dplyr::rename(Count = NumberCasesperDay) %>%
#   mutate(`Week ending` = ymd(`Week ending`),
#          `% of patients testing positive` = `% of patients testing positive`*100)
# saveRDS(ChildCases, "shiny_app/data/ChildCases.rds")
#
#
# # Children  tests
# ChildTests <- read_csv(glue("{output_folder}/tests_children.csv")
# ChildTests <- ChildTests %>%
#   #dplyr::rename(Count = NumberCasesperDay) %>%
#   mutate(`Week ending` = ymd(`Week ending`),
#          `%Positive` = `%Positive`*100)
# saveRDS(ChildTests, "shiny_app/data/ChildTests.rds")
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
# saveRDS(ChildData, "shiny_app/data/Child.rds")


# Contact Tracing ---------------------------------------------------------
#ContactTracing <- read_csv(glue("{output_folder}/ContactTracingWeekly.csv")) %>%
#  mutate(WeekEnding = ymd(WeekEnding))
#saveRDS(ContactTracing, "shiny_app/data/ContactTracingWeekly.rds")

ContactTime <- read_csv(glue("{output_folder}/ContactTime.csv"))
ContactTime <- ContactTime %>%
  mutate_if(is.numeric, round_half_up, 2) %>%
  mutate(week_ending = ymd(week_ending))
saveRDS(ContactTime, "shiny_app/data/ContactTime.rds")


# #Cases reporting an occupation in the Education and Childcare sector
# ContactEC <- read_csv(glue("{output_folder}/ContactTracingEducation.csv")
# ContactEC <- ContactEC %>%
#   mutate_if(is.numeric, round_half_up, 2) %>%
#   mutate(week_ending = ymd(week_ending))
# saveRDS(ContactEC, "shiny_app/data/ContactTracingEducation.rds")


ContactTracingWeeklyCases <- read_csv(glue("{output_folder}/ContactTracingWeeklyCases.csv")) %>%
  mutate(`Week ending` = ymd(`Week ending`))
saveRDS(ContactTracingWeeklyCases, "shiny_app/data/ContactTracingWeeklyCases.rds")


ContactTracingWeeklyCumulative <- read_csv(glue("{output_folder}/ContactTracingWeeklyCumulative.csv"))
saveRDS(ContactTracingWeeklyCumulative, "shiny_app/data/ContactTracingWeeklyCumulative.rds")

ContactTracingAverages <- read_csv(glue("{output_folder}/ContactTracing_Average.csv"))
saveRDS(ContactTracingAverages, "shiny_app/data/ContactTracingAverages.rds")

ContactTracingFail <- read_csv(glue("{output_folder}/ContactTracingFail.csv"))
saveRDS(ContactTracingFail, "shiny_app/data/ContactTracingFail.rds")

#ContactTracingAveragesAge <- read_csv(glue("{output_folder}/ContactTracing_Average_Age.csv"))
#saveRDS(ContactTracingAveragesAge, "shiny_app/data/ContactTracingAveragesAge.rds")

ContactTracingTestingPositive <- read_csv(glue("{output_folder}/ContactTracing_Testing_Positive.csv"))
saveRDS(ContactTracingTestingPositive, "shiny_app/data/ContactTracingTestingPositive.rds")

ContactTracingRegions <- read_csv(glue("{output_folder}/ContactTracingRegions.csv"))
saveRDS(ContactTracingRegions, "shiny_app/data/ContactTracingRegions.rds")

ContactTracingInterviews <- read_csv(glue("{output_folder}/ContactTracingInterviews.csv"))
saveRDS(ContactTracingInterviews, "shiny_app/data/ContactTracingInterviews.rds")

ProximityApp <- read_csv(glue("{output_folder}/ProximityApp.csv"))
saveRDS(ProximityApp, "shiny_app/data/ProximityApp.rds")

#ContactTracingDemoAge <- read_csv(glue("{output_folder}/ContactTracingDemoAge.csv"))
#saveRDS(ContactTracingDemoAge, "shiny_app/data/ContactTracingDemoAge.rds")

#ContactTracingDemoSex <- read_csv(glue("{output_folder}/ContactTracingDemoSex.csv"))
#saveRDS(ContactTracingDemoSex, "shiny_app/data/ContactTracingDemoSex.rds")

#ContactTracingDemoSIMD <- read_csv(glue("{output_folder}/ContactTracingDemoSIMD.csv"))
#saveRDS(ContactTracingDemoSIMD, "shiny_app/data/ContactTracingDemoSIMD.rds")

# Settings ----------------------------------------------------------------

Settings <- read_csv(glue("{output_folder}/Settings.csv"))

#Settings <- read_csv(file.choose())

AllSettings <- Settings %>%
  select(-`Setting Location`) %>%
  group_by(week_ending, `Setting Type`) %>%
  summarise(`Number of  Cases` = sum(`Number of  Cases`)) %>%
  dplyr::rename(`Setting Location` = `Setting Type`) %>%
  mutate(`Setting Type` = "All setting types")

Settings <- Settings %>%
  full_join(AllSettings) %>%
  dplyr::arrange(desc(`Setting Type`), desc(`Number of  Cases`)) %>%
  mutate(week_ending = ymd(week_ending))


saveRDS(Settings, "shiny_app/data/Settings.rds")

# Health Care Workers -----------------------------------------------------

HCW_SpecialistCancer <- read_csv(glue("{output_folder}/HCW_SpecialistCancer.csv")) %>% select(1:9)
saveRDS(HCW_SpecialistCancer, "shiny_app/data/HCW_SpecialistCancer.rds")

HCW_CareOfElderly <- read_csv(glue("{output_folder}/HCW_CareOfElderly.csv"))
saveRDS(HCW_CareOfElderly, "shiny_app/data/HCW_CareOfElderly.rds")

HCW_Psychiatry <- read_csv(glue("{output_folder}/HCW_Psychiatry.csv"))
saveRDS(HCW_Psychiatry, "shiny_app/data/HCW_Psychiatry.rds")

# Ethnicity -----------------------------------------------------------------

Ethnicity <- read_csv(glue("{output_folder}/Ethnicity.csv"))
saveRDS(Ethnicity, "shiny_app/data/Ethnicity.rds")

Ethnicity_Chart <- read_csv(glue("{output_folder}/Ethnicity_Chart.csv"))
saveRDS(Ethnicity_Chart, "shiny_app/data/Ethnicity_Chart.rds")

#### Care Homes ----------------------------------------------------------------
care_homes <- read_csv(glue("{output_folder}/CareHomes.csv")) %>%
  mutate( `Week Ending` = ymd(`Week Ending`),
          # Suppression stuff
          across( contains('with Confirmed'), as.numeric ),
          across( contains('with Confirmed'),
                  function(x) { if_else( is.na(x) | between(x,1,4), '*', as.character(x) ) } ) ) %>%
  dplyr::rename(
    # Ugh long names
    `Number Staff in Care Homes with COVID-19`=`Number Staff in Care Homes with Confirmed COVID-19`,
    `Number of Residents in Care Homes with COVID-19` =  `Number of Residents in Care Homes with Confirmed COVID-19`,
    `Number of Staff in Care Homes with no COVID-19` = `Number of Staff in Care Homes with no Confirmed COVID-19 Cases`
    )
saveRDS(care_homes, "shiny_app/data/Care_Homes.rds")

### Care home time series ------------------------------------------------------

CareHomeTimeSeries <- read_csv(glue("{output_folder}/CareHomeTimeSeries.csv"))
saveRDS(CareHomeTimeSeries, "shiny_app/data/CareHomeTimeSeries.rds")

### Care home SG visit outbreak status -----------------------------------------

# Find all care home visits files
CareHomeVisitsFiles <- list.files(path=output_folder, pattern="CareHomeVisits*")

for(file in CareHomeVisitsFiles){
  readfile <- read_csv(paste0(output_folder, "/",file))
  saveRDS(readfile, paste0("shiny_app/data/", gsub(".csv", ".rds", file)))
}

### Vaccine Wastage

VaccineWastage <- read_csv(glue("{output_folder}/VaccineWastage.csv"))
saveRDS(VaccineWastage, "shiny_app/data/VaccineWastage.rds")

### Vaccine Wastage Reason

VaccineWastageReason <- read_csv(glue("{output_folder}/VaccineWastageReason.csv"))
saveRDS(VaccineWastageReason, "shiny_app/data/VaccineWastageReason.rds")

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
mtu_ts <- read_csv(glue("{output_folder}/AllCommunity_Testing_byWeek.csv"))

mtu_1.1 <- mtu_ts %>% filter(test_centre != "All") %>%
  select(test_centre, hb2019name, week_ending,
         week_ending_label, total_tests) %>%
  mutate(total_tests = replace_zero(total_tests),
         week_ending = ymd(week_ending))

# mtu_1.1 <- mtu_1 %>% filter(Test_centre != "All") %>%
#   mutate(Number_of_tests =  replace_zero(Number_of_tests))
saveRDS(mtu_1.1, "shiny_app/data/TCT_TestCentres.rds")
#
# mtu_1.2 <- mtu_1 %>% filter(Test_centre == "All")
# saveRDS(mtu_1.2, "shiny_app/data/TCT_AllTestCentres.rds")
mtu_1.2 <- mtu_ts %>%
  group_by(week_ending, week_ending_label, hb2019name) %>%
  summarise_at(vars(total_tests:mtu_tests), sum) %>%
  ungroup() %>%
  mutate(week_ending = ymd(week_ending),
         positive_tests = suppress(positive_tests))
saveRDS(mtu_1.2, "shiny_app/data/TCT_AllTestCentres.rds")

#
# # cumulative outputs
mtu_ct <- read_csv(glue("{output_folder}/Community_Testing_Totals.csv"))

mtu_2 <- mtu_ct %>%
  select(`Health Board` = hb2019name,
         Symptomatic = symptomatic,
         Asymptomatic = asymptomatic) %>%
  pivot_longer(cols = 2:3) %>%
  filter(`Health Board` != "All")

saveRDS(mtu_2, "shiny_app/data/TCT_HBSymptomaticFlag.rds")

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

# mtu_3 <- read_csv(glue("{output_folder}/CommunityTesting_HB_percent_positive.csv"))
# mtu_3 <- mtu_3 %>% dplyr::rename(`Health Board` = hb2019name)
saveRDS(mtu_3, "shiny_app/data/TCT_HBPercentPositive.rds")


mtu_4 <- mtu_ct %>%
  select(`Health Board` = hb2019name,
         MTU = mtu_tests,
         ATS = ats_tests) %>%
  pivot_longer(cols = 2:3) %>%
  filter(`Health Board` != "All")

saveRDS(mtu_4, "shiny_app/data/TCT_HBTestSiteType.rds")

#
# # Key Points
mtu_5 <- read_csv(glue("{output_folder}/CommunityTesting_key_points.csv"))
saveRDS(mtu_5, "shiny_app/data/TCT_KeyPoints.rds")



### Length of Stay ----

los <- read_csv(glue("{output_folder}/Length_of_Stay.csv"))
saveRDS(los, "shiny_app/data/Length_of_Stay.rds")
