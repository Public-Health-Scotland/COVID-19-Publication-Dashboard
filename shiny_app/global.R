## Uncomment the line below if you are running the app locally from a different directory to the one given
## Make sure it is commented out before deploying the app
#setwd("/conf/PHSCOVID19_Analysis/COVID-19-Publication-Dashboard/shiny_app")

# Global
###############################################

## Data extraction dates ----

#publication date
pub_date <- as.Date("2022-02-16")

Labcases_date <- format(pub_date - 3, "%d %B %Y")
ICU_date <- format(pub_date - 4, "%d %B %Y")
NHS24_date <- format(pub_date - 3, "%d %B %Y")

SAS_date <- format(pub_date - 5, "%d %B %Y")

AssessmentHub_date <- format(pub_date - 7, "%d %B %Y")
Admissions_date <- format(pub_date -4, "%d %B %Y")

#ECOSS, for LabCases
labcases_extract_date <- format(pub_date - 3, "%d %B %Y") #format date

#For Hospital Admissions
admission_extract_date <- format(pub_date - 3, "%A %d %B %Y") #format date

#For ICU Admissions
ICU_extract_date <- format(pub_date - 2, "%A %d %B %Y") #format date

#For LFD
LFD_date <- format(pub_date - 3, "%A %d %B %Y") #format date
LFD_demo_date <- format(pub_date - 7, "%A %d %B %Y")

###############################################.
## Packages ----

library(shiny)
library(plotly) # for charts
library(shinyWidgets) # for dropdowns
library(dplyr) # for data manipulation
library(DT) # for data table
library(shinycssloaders) #for loading icons, see line below
# it uses github version devtools::install_github("andrewsali/shinycssloaders")
# This is to avoid issues with loading symbols behind charts and perhaps with bouncing of app
library(shinyjs) # for enable/disable functions
library(readr) # for writing/reading csvs
library(stringr) #for manipulating strings
library(forcats) #manipulating factors
library(flextable)
library(tidytable)
library(shinyBS) #for collapsible panels in commentary
library(glue) #for pasting strings
library(lubridate)
library(janitor)
library(phsstyles)
library(tidyr)
library(magrittr)

###############################################.
## Functions ----

plot_box <- function(title_plot, plot_output) {
  tagList(h4(title_plot),
          withSpinner(plotlyOutput(plot_output)))
}


plot_box_2 <- function(title_plot, subtitle_plot = "", plot_output) {
  tagList(h4(title_plot),p(tags$i(subtitle_plot)),
          withSpinner(plotlyOutput(plot_output), proxy.height = "500px"))
}

plot_cut_box <- function(title_plot1, plot_output1,
                         title_plot2, plot_output2, extra_content = NULL) {
  tagList(
    fluidRow(column(6, h4(title_plot1)),
             column(6, h4(title_plot2))),
    extra_content,
    fluidRow(column(6, withSpinner(plotlyOutput(plot_output1))),
             column(6, withSpinner(plotlyOutput(plot_output2))))
  )
}

#if missing plot (e.g. no SIMD)
plot_cut_missing <- function(title_plot, plot_output, extra_content = NULL) {
  tagList(
    fluidRow(column(6, h4(title_plot))),
    extra_content,
    fluidRow(column(6, withSpinner(plotlyOutput(plot_output))))
  )
}

###############################################.
## Data ----
#
# ## correct filepath
# cv_fp <- function(filename) {
#   fp <- "/conf/PHSCOVID19_Analysis/COVID-19-Publication-Dashboard/shiny_app/"
#   paste0(fp, filename)
# }


LabCases <-readRDS("data/LabCases.rds")
LabCasesReinfections <-readRDS("data/LabCasesReinfections.rds")
Admissions <-readRDS("data/Admissions.rds")
ICU <- readRDS("data/ICU.rds")
NHS24 <- readRDS("data/NHS24.rds")
AssessmentHub <- readRDS("data/AssessmentHub.rds")
SAS <- readRDS("data/SAS.rds")
NHS24_inform <- readRDS("data/NHSInform.rds")
NHS24_selfhelp <- readRDS("data/SelfHelp.rds")

#read age/sex/deprivation data
LabCases_AgeSex <- readRDS("data/LabCases_AgeSex.rds")
LabCases_Age <- readRDS("data/LabCases_Age.rds")
LabCases_SIMD <- readRDS("data/LabCases_SIMD.rds")
Admissions_AgeSex <- readRDS("data/Admissions_AgeSex.rds")
Admissions_SIMD <- readRDS("data/Admissions_SIMD.rds")
Admissions_AgeBD <- readRDS("data/Admissions_AgeBD.rds")
ICU_AgeSex <- readRDS("data/ICU_AgeSex.rds")
NHS24_AgeSex <- readRDS("data/NHS24_AgeSex.rds")
NHS24_SIMD <- readRDS("data/NHS24_SIMD.rds")
AssessmentHub_AgeSex <- readRDS("data/AssessmentHub_AgeSex.rds")
AssessmentHub_SIMD <- readRDS("data/AssessmentHub_SIMD.rds")
SAS_AgeSex <- readRDS("data/SAS_AgeSex.rds")
SAS_SIMD <- readRDS("data/SAS_SIMD.rds")

Cases_Adm <- readRDS("data/Cases_Adm.rds")
Cases_AgeGrp <- readRDS("data/Cases_AgeGrp.rds")
Prop_Adm_AgeGrp = readRDS("data/Prop_Admitted_AgeGrp.rds")

#read SAS/NHS24 other data
NHS24_community <- readRDS("data/NHS24_community.rds")
SAS_all <- readRDS("data/SAS_all.rds")

# read in children data
#ChildCases <- readRDS("data/ChildCases.rds")
#ChildTests <- readRDS("data/ChildTests.rds")
#Child <- readRDS("data/Child.rds")

#Contact Tracing
#ContactTracing<- readRDS("data/ContactTracingWeekly.rds")
ContactTime <- readRDS("data/ContactTime.rds")
#ContactEC <- readRDS("data/ContactTracingEducation.rds")
ContactWeeklyCases <- readRDS("data/ContactTracingWeeklyCases.rds")
ContactTracingWeeklyCumulative <- readRDS("data/ContactTracingWeeklyCumulative.rds")
Settings <- readRDS("data/Settings.rds")
ContactTracingAverages <- readRDS("data/ContactTracingAverages.rds")
#ContactTracingAveragesAge <- readRDS("data/ContactTracingAveragesAge.rds")
ContactTracingTestingPositive <- readRDS("data/ContactTracingTestingPositive.rds")
ContactTracingFail <- readRDS("data/ContactTracingFail.rds")
ContactTracingRegions <- readRDS("data/ContactTracingRegions.rds")
ContactTracingInterviews <- readRDS("data/ContactTracingInterviews.rds")
ProximityApp <- readRDS ("data/ProximityApp.rds")
#ContactTracingDemoAge <-readRDS("data/ContactTracingDemoAge.rds")
#ContactTracingDemoSex <-readRDS("data/ContactTracingDemoSex.rds")
#ContactTracingDemoSIMD <-readRDS("data/ContactTracingDemoSIMD.rds")


# Health Care Workers
HealthCareWorkerCancer <- readRDS("data/HCW_SpecialistCancer.rds")
HealthCareWorkerElderly <- readRDS("data/HCW_CareOfElderly.rds")
HealthCareWorkerPsychiatry <- readRDS("data/HCW_Psychiatry.rds")

# Ethnicity
Ethnicity <- readRDS("data/Ethnicity.rds")
Ethnicity_Chart <- readRDS("data/Ethnicity_Chart.rds")

# Care Homes
Care_Homes <- readRDS("data/Care_Homes.rds")

# Quarantine
Quarantine <- readRDS("data/Quarantine.rds")

# LFD
LFD <- readRDS("data/LFD.rds")
LFD_Weekly <- readRDS("data/LFD_Weekly.rds")
# Get data from LFT dashboard
#lft_dash_path <- "/conf/C19_Test_and_Protect/Test & Protect - Warehouse/LFT Dashboard/Calum P/AM_COVID-19_LateralFlowTests/shiny_app/data"
lfd_demographics_data <- readRDS("data/Demographics.rds") %>% filter(indicator != "Local Authority")

people_output_selection <- c("Age Group and Sex", "SIMD")
plot_output_selection <- c("All Individuals", "Positive Testing Individuals")

# Mobile Testing Units
mtu_heatmap_data <- readRDS("data/TCT_TestCentres.rds")
mtu_heatmap_data2 <- mtu_heatmap_data %>%
  dplyr::mutate(Number_of_tests = replace_na(total_tests, 0)) %>%
  dplyr::rename(`Test Centre` = test_centre,
                'NHS Board' = hb2019name,
                `Number of Tests` = Number_of_tests,
                `Week Ending` = week_ending_label) %>%
  select(`Test Centre`, 'NHS Board', `Week Ending`,  `Number of Tests`)

mtu_ts_data <- readRDS("data/TCT_AllTestCentres.rds")

mtu_cumul_symp <- readRDS("data/TCT_HBSymptomaticFlag.rds")
mtu_cumul_pos <- readRDS("data/TCT_HBPercentPositive.rds")
mtu_cumul_site <- readRDS("data/TCT_HBTestSiteType.rds")

mtu_keypoints <- readRDS("data/TCT_KeyPoints.rds")

br3<-function(){tagList(br(),br(),br())}

###############################################.
## Data lists --------------------------------------------------------------


data_list <- c("Positive Cases" = "LabCases",
               "Reinfections" = "LabCasesReinfections",
               "Hospital Admissions" = "Admissions",
               "Hospital Admissions by Ethnicity" = "Ethnicity_Chart",
               "ICU Admissions" = "ICU",
               "NHS24 Contacts" = "NHS24",
               "Community Hubs and Assessment Centres" = "AssessmentHub",
               "Scottish Ambulance Service" = "SAS")


CTdata_list_chart_tab <- c ("Contact Tracing time performance %",
                            "Contact Tracing time performance cases",
                            "Average number of contacts per case",
                            "Protect Scotland App")


CTdata_list_data_tab <- c (#"Contact Tracing Weekly by Health Board" = "ContactTracing",
                           "Contact Tracing time performance measures" = "ContactTime",
                         #  "Cases reporting an occupation in the Education and Childcare sector" = "ContactEC",
                           "Cases recorded in contact tracing software" = "ContactWeeklyCases",
                           "Cumulative cases recorded in contact tracing software" ="ContactTracingWeeklyCumulative",
                           #"Average number of contacts per case" = "ContactTracingAveragesAge",
                           "Number of Contacts Positive Within 10 Days of Exposure" = "ContactTracingTestingPositive",
                           "Incomplete index cases by reason incomplete" = "ContactTracingFail",
                           "Protect Scotland App" = "ProximityApp")

                            #"Index and contact cases by age" = "ContactTracingDemoAge",
                           #"Index and contact cases by sex" = "ContactTracingDemoSex",
                           #"Index and contact cases by SIMD quintile" = "ContactTracingDemoSIMD")



SettingList <- c(sort(unique(Settings$`Setting Type`)))

HCWdata_list_data_tab <- c ("Specialist Cancer Wards and Treatment Areas" = "HealthCareWorkerCancer",
                            "Long Stay Care of the Elderly" = "HealthCareWorkerElderly",
                            "Long Stay Old Age Psychiatry and Learning Disability Wards" = "HealthCareWorkerPsychiatry")


#extra choices for data tables

data_list_data_tab <- c("Positive cases" = "LabCases",
                        "Reinfections" = "LabCasesReinfections",
                        "Positive cases by age and sex" = "LabCases_AgeSex",
                        "Positive cases by deprivation" = "LabCases_SIMD",
                        "Distribution of COVID-19 cases by age group" = "Cases_AgeGrp",
                        "Hospital admissions" = "Admissions",
                        "Hospital admissions by age and sex" = "Admissions_AgeSex",
                        "Hospital admissions by deprivation" = "Admissions_SIMD",
                        "Weekly hospital admissions by age" = 'Admissions_AgeBD',
                        "Proportion of weekly cases admitted to hospital within 14 days of a first positive test" = "Cases_Adm",
                        "Proportion of weekly cases admitted to hospital by age group" = "Prop_Adm_AgeGrp",
                        "Hospital admissions by ethnicity" = "Ethnicity",
                        "ICU admissions" = "ICU",
                        "ICU admissions by age" = "ICU_AgeSex",
                        "NHS24 contacts" = "NHS24",
                        "NHS24 contacts by age and sex" = "NHS24_AgeSex",
                        "NHS24 contacts by deprivation" = "NHS24_SIMD",
                        "NHS Inform hits" = "NHS24_inform",
                        "NHS24 self help guides" = "NHS24_selfhelp",
                        "NHS24 community outcomes"  = "NHS24_community",
                        "Community hubs and assessment centres" = "AssessmentHub",
                        "Community hubs and assessment centres by age" = "AssessmentHub_AgeSex",
                        "Community hubs and assessment centres by deprivation" = "AssessmentHub_SIMD",
                        "Scottish Ambulance Service" = "SAS",
                        "Scottish Ambulance Service by age and sex" = "SAS_AgeSex",
                        "Scottish Ambulance Service by deprivation" = "SAS_SIMD",
                        "Scottish Ambulance Service - all incidents" = "SAS_all")

data_list_quarantine_tab <- c("Quarantine statistics by date" = "Quarantine")

###############################################.
## Palettes  ----

pal_overall <- c('#000000', '#0078D4','#9B4393', '#bdbdbd', '#bdbdbd', '#bdbdbd', '#7fcdbb')

pal_WkAge <- c('#0078D4','#9B4393', '#7fcdbb')

#for nhs24 community outcomes
pal_comm <- c("#3F3685", "#9B4393", "#0078D4", "#C73918", "#83BB26", "#6B5C85")

#for female/male/total sex
pal_sex <- c('#9B4393', '#0078D4', "#000000")

pal_reinf <- c('#0078D4', '#9B4393')

#for child charts
pal_child <- c("#3F3685", "#9B4393", "#0078D4", "#83BB26", "#C73918", "#6B5C85")

#for contact tracing charts
#pal_CT <- c('#0078D4', '#3393DD', '#80BCEA',  '#B3D7F2','#000000')

pal_CT <- c(phs_colours("phs-blue"),
            phs_colours("phs-purple"),
            phs_colours("phs-magenta"),
            phs_colours("phs-teal"),
            phs_colours("phs-green"),
            '#000000')

pal_3_week <- c(phs_colours("phs-purple"), phs_colours("phs-magenta"), phs_colours("phs-blue"))

#for contact tracing charts
pal_ETH <- c('#3F3685', '#9B4393', '#0078D4',  '#83BB26','#C73918')

#for SIMD
pal_simd <- c('#0078D4', '#DFDDE3', '#DFDDE3', '#DFDDE3', '#83BB26')

#for mtus
pal_mtu <- c('#0078D4','#9B4393')

#for AgeGrp chart
pal_AgeGrp <- c('#000000', '#0078D4', '#3393DD', '#80BCEA',  '#B3D7F2')

###############################################.
## Plot Parameters ---------------------------------------------------------

# Style of x and y axis
xaxis_plots <- list(title = FALSE, tickfont = list(size=14), titlefont = list(size=14),
                    showline = TRUE, fixedrange=TRUE)

yaxis_plots <- list(title = FALSE, rangemode="tozero", fixedrange=TRUE, size = 4,
                    tickfont = list(size=14), titlefont = list(size=14))

# Buttons to remove
bttn_remove <-  list('select2d', 'lasso2d', 'zoomIn2d', 'zoomOut2d',
                     'autoScale2d',   'toggleSpikelines',  'hoverCompareCartesian',
                     'hoverClosestCartesian')

## END

