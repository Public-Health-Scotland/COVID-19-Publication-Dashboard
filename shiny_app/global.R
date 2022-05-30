## Uncomment the line below if you are running the app locally from a different directory to the one given
## Make sure it is commented out before deploying the app
#setwd("/conf/PHSCOVID19_Analysis/COVID-19-Publication-Dashboard/shiny_app")

# Global
###############################################

## Data extraction dates ----

#publication date
pub_date <- as.Date("2022-05-19")

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

#For vaccine certification
vaccine_cert_date <- format(pub_date -4, "%d %B %Y")

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
## Data ----

# Infection levels and cases ----

LabCases <-readRDS("data/LabCases.rds")
LabCasesReinfections <-readRDS("data/LabCasesReinfections.rds")
LabCases_AgeSex <- readRDS("data/LabCases_AgeSex.rds")
LabCases_Age <- readRDS("data/LabCases_Age.rds")
LabCases_SIMD <- readRDS("data/LabCases_SIMD.rds")


# LFDs ----

LFD <- readRDS("data/LFD.rds")
LFD_Weekly <- readRDS("data/LFD_Weekly.rds")
lfd_demographics_data <- readRDS("data/Demographics.rds") %>% filter(indicator != "Local Authority")
LFD_TestGroup <- readRDS("data/LFD_TestGroup.rds")

people_output_selection <- c("Age Group and Sex", "SIMD")
plot_output_selection <- c("All Individuals", "Positive Testing Individuals")

# Severe illness ----

Admissions <-readRDS("data/Admissions.rds")
Admissions_AgeSex <- readRDS("data/Admissions_AgeSex.rds")
Admissions_SIMD <- readRDS("data/Admissions_SIMD.rds")
Admissions_AgeBD <- readRDS("data/Admissions_AgeBD.rds")
Admissions_AgeGrp <- readRDS("data/Admissions_AgeGrp.rds")

ICU <- readRDS("data/ICU.rds")
ICU_AgeSex <- readRDS("data/ICU_AgeSex.rds")

LOS_Data = readRDS("data/Length_of_Stay.rds")%>%
  filter(`Age Group` != "Unknown")

Cases_Adm <- readRDS("data/Cases_Adm.rds")
Cases_AgeGrp <- readRDS("data/Cases_AgeGrp.rds")
Prop_Adm_AgeGrp = readRDS("data/Prop_Admitted_AgeGrp.rds")

Ethnicity <- readRDS("data/Ethnicity.rds")
Ethnicity_Chart <- readRDS("data/Ethnicity_Chart.rds")

# Populations of interest ----

CareHomeTimeSeries <- readRDS('data/CareHomeTimeSeries.rds')

CareHomeVisitsNotes <- readRDS("data/CareHomeVisitsNotes.rds")
CareHomeVisitsDate <- CareHomeVisitsNotes %>%
  slice(1) %>%
  .$Meaning
CareHomeVisitsDate <- format(ymd(CareHomeVisitsDate), "%d %B %Y")
CareHomeVisitsBoard <- readRDS("data/CareHomeVisitsBoard.rds")
CareHomeVisitsOutbreak <- readRDS("data/CareHomeVisitsOutbreak.rds")
CareHomeVisitsBoardOlder <- readRDS("data/CareHomeVisitsBoardOlder.rds")
CareHomeVisitsNotOlder <- readRDS("data/CareHomeVisitsOutbreakOlder.rds")

# Surveillance ----

NHS24 <- readRDS("data/NHS24.rds")
NHS24_inform <- readRDS("data/NHSInform.rds")
NHS24_selfhelp <- readRDS("data/SelfHelp.rds")
NHS24_AgeSex <- readRDS("data/NHS24_AgeSex.rds")
NHS24_SIMD <- readRDS("data/NHS24_SIMD.rds")
NHS24_community <- readRDS("data/NHS24_community.rds")

AssessmentHub <- readRDS("data/AssessmentHub.rds")
AssessmentHub_AgeSex <- readRDS("data/AssessmentHub_AgeSex.rds")
AssessmentHub_SIMD <- readRDS("data/AssessmentHub_SIMD.rds")

SAS <- readRDS("data/SAS.rds")
SAS_AgeSex <- readRDS("data/SAS_AgeSex.rds")
SAS_SIMD <- readRDS("data/SAS_SIMD.rds")
SAS_all <- readRDS("data/SAS_all.rds")

# Vaccinations ----

# Archive ----

ContactTime <- readRDS("data/ContactTime.rds")
ContactWeeklyCases <- readRDS("data/ContactTracingWeeklyCases.rds")
ContactTracingWeeklyCumulative <- readRDS("data/ContactTracingWeeklyCumulative.rds")
ContactTracingAverages <- readRDS("data/ContactTracingAverages.rds")
ContactTracingTestingPositive <- readRDS("data/ContactTracingTestingPositive.rds")
ContactTracingFail <- readRDS("data/ContactTracingFail.rds")
ContactTracingRegions <- readRDS("data/ContactTracingRegions.rds")
ContactTracingInterviews <- readRDS("data/ContactTracingInterviews.rds")

Settings <- readRDS("data/Settings.rds")

ProximityApp <- readRDS ("data/ProximityApp.rds")

Care_Homes <- readRDS("data/Care_Homes.rds")

HealthCareWorkerCancer <- readRDS("data/HCW_SpecialistCancer.rds")
HealthCareWorkerElderly <- readRDS("data/HCW_CareOfElderly.rds")
HealthCareWorkerPsychiatry <- readRDS("data/HCW_Psychiatry.rds")

Quarantine <- readRDS("data/Quarantine.rds")

VaccineCertification <- readRDS("data/VaccineCertification.rds")

VaccineWastage <- readRDS("data/VaccineWastage.rds") %>%
  dplyr::rename(`Month Beginning` = month,
                `Doses Administered` = number_of_doses_administered,
                `Doses Wasted` = number_of_doses_wasted,
                `% Wasted` = percentage_wasted)

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


###############################################.
## Data lists --------------------------------------------------------------

# Lists for trend graphs

inf_levels_cases_list <- c("Positive Cases" = "LabCases",
                           "Reinfections" = "LabCasesReinfections")

severe_illness_list <- c("Hospital Admissions" = "Admissions",
                         "Hospital Admissions by Ethnicity" = "Ethnicity_Chart",
                         "ICU Admissions" = "ICU")

surveillance_list <- c("NHS24 Contacts" = "NHS24",
                       "Scottish Ambulance Service" = "SAS")

surveillance_archive_list <- c("Community Hubs and Assessment Centres" = "AssessmentHub")

CTdata_list_chart_tab <- c("Contact Tracing time performance %",
                            "Contact Tracing time performance cases",
                            "Average number of contacts per case",
                            "Protect Scotland App")


CTdata_list_data_tab <- c(
  "Contact Tracing time performance measures" = "ContactTime",
  "Cases recorded in contact tracing software" = "ContactWeeklyCases",
  "Cumulative cases recorded in contact tracing software" ="ContactTracingWeeklyCumulative",
  "Number of Contacts Positive Within 10 Days of Exposure" = "ContactTracingTestingPositive",
  "Incomplete index cases by reason incomplete" = "ContactTracingFail",
  "Protect Scotland App" = "ProximityApp")

SettingList <- c(sort(unique(Settings$`Setting Type`)))

HCWdata_list_data_tab <- c ("Specialist Cancer Wards and Treatment Areas" = "HealthCareWorkerCancer",
                            "Long Stay Care of the Elderly" = "HealthCareWorkerElderly",
                            "Long Stay Old Age Psychiatry and Learning Disability Wards" = "HealthCareWorkerPsychiatry")


# Lists for drop-down data tables

inf_levels_cases_data_list <- c("Positive cases" = "LabCases",
                                "Reinfections" = "LabCasesReinfections",
                                "Positive cases by age and sex" = "LabCases_AgeSex",
                                "Positive cases by deprivation" = "LabCases_SIMD",
                                "Distribution of COVID-19 cases by age group" = "Cases_AgeGrp")

severe_illness_data_list <- c("Hospital admissions" = "Admissions",
                              "Hospital admissions by age and sex" = "Admissions_AgeSex",
                              "Hospital admissions by deprivation" = "Admissions_SIMD",
                              "Weekly hospital admissions by age" = 'Admissions_AgeBD',
                              "Proportion of weekly cases admitted to hospital within 14 days of a first positive test" = "Cases_Adm",
                              "Proportion of weekly cases admitted to hospital by age group" = "Prop_Adm_AgeGrp",
                              "Hospital admissions by ethnicity" = "Ethnicity",
                              "Length of stay of acute hospital admissions by age group" = "LOS_Data",
                              "ICU admissions" = "ICU",
                              "ICU admissions by age" = "ICU_AgeSex")

surveillance_data_list <- c("NHS24 contacts" = "NHS24",
                            "NHS24 contacts by age and sex" = "NHS24_AgeSex",
                            "NHS24 contacts by deprivation" = "NHS24_SIMD",
                            "NHS Inform hits" = "NHS24_inform",
                            "NHS24 self help guides" = "NHS24_selfhelp",
                            "NHS24 community outcomes"  = "NHS24_community",
                            "Scottish Ambulance Service" = "SAS",
                            "Scottish Ambulance Service by age and sex" = "SAS_AgeSex",
                            "Scottish Ambulance Service by deprivation" = "SAS_SIMD",
                            "Scottish Ambulance Service - all incidents" = "SAS_all")

surveillance_archive_data_list <- c("Community hubs and assessment centres" = "AssessmentHub",
                                    "Community hubs and assessment centres by age" = "AssessmentHub_AgeSex",
                                    "Community hubs and assessment centres by deprivation" = "AssessmentHub_SIMD")



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

# Length of Stay - PHS Blues
phs_blues <- c("#004785", "#00a2e5", "#4c7ea9")

#for contact tracing charts
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


# Functions for Charts ---------------------------------------------

br3 <- function(){tagList(br(),br(),br())}

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


## Functions from ScotPHO dashboard https://github.com/Public-Health-Scotland/scotpho-profiles-tool/

#Creating big boxes for main tabs in the landing page (see ui for formatting css)
lp_main_box <- function(title_box, button_name, description) {
  div(class="landing-page-box",
      div(title_box, class = "landing-page-box-title"),
      div(description, class = "landing-page-box-description"),
      actionButton(button_name, NULL, class="landing-page-button")
  )
}


#Creating small boxes for further information in the landing page (see ui for formatting css)
lp_about_box <- function(title_box, button_name, description) {

  div(class="landing-page-box-about",
      div(title_box, class = "landing-page-box-title"),
      (actionButton(button_name, NULL,
                    class="landing-page-button")))
}

## END

