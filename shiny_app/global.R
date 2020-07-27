
setwd("//freddy/DEPT/PHIBCS/PHI/Publications/Health Topic/HPS/Covid-19/COVID19_Dashboard/")


# Global

###############################################.
## Packages ----
###############################################.

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
library(flextable)
library(shinyBS) #for collapsible panels in commentary
library(glue) #for pasting strings

###############################################.
## Functions ----
###############################################.
plot_box <- function(title_plot, plot_output) {
  tagList(h4(title_plot),
          withSpinner(plotlyOutput(plot_output)))
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
###############################################.
LabCases <-readRDS("data/LabCases.rds")
Admissions <-readRDS("data/Admissions.rds")
ICU <- readRDS("data/ICU.rds")
NHS24 <- readRDS("data/NHS24.rds")
AssessmentHub <- readRDS("data/AssessmentHub.rds")
SAS <- readRDS("data/SAS.rds")
NHSInform <- readRDS("data/NHSInform.rds")
SelfHelp <- readRDS("data/SelfHelp.rds")

LabCases_AgeSex <- read_csv("data/LabCases_AgeSex.csv")
LabCases_SIMD <- read_csv("data/LabCases_SIMD.csv") %>% mutate(cases_pc = cases_pc * 100)
Admissions_AgeSex <- read_csv("data/Admissions_AgeSex.csv")
Admissions_SIMD <- read_csv("data/Admissions_SIMD.csv") %>% mutate(cases_pc = cases_pc * 100)
ICU_AgeSex <- read_csv("data/ICU_AgeSex.csv")
NHS24_AgeSex <- read_csv("data/NHS24_AgeSex.csv")
AssessmentHub_AgeSex <- read_csv("data/AssessmentHub_AgeSex.csv")
AssessmentHub_SIMD <- read_csv("data/AssessmentHub_SIMD.csv") %>% mutate(cases_pc = cases_pc * 100)
SAS_AgeSex <- read_csv("data/SAS_AgeSex.csv")
SAS_SIMD <- read_csv("data/SAS_SIMD.csv") %>% mutate(cases_pc = cases_pc * 100)

data_list <- c("Positive Cases" = "LabCases", 
               "Admissions" = "Admissions", 
               "ICU Admissions" = "ICU",
               "NHS24 Calls" = "NHS24", 
               "Assessment Hubs" = "AssessmentHub", 
               "Scottish Ambulance Service" = "SAS")



data_list_data_tab <- c(data_list)

###############################################.
## Palettes and plot parameters ----
# ###############################################.

pal_overall <- c('#000000', '#009900','#59144c', '#bdbdbd', '#bdbdbd', '#bdbdbd', '#7fcdbb')

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