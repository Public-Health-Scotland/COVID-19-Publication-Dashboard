
#UI
tagList(  #needed for shinyjs
  useShinyjs(),  # Include shinyjs
  navbarPage(
    id = "intabset",# id used for jumping between tabs
    title = div(
      tags$a(img(src = "phs-logo.png", height = 40), href = "https://www.publichealthscotland.scot/"),
      style = "position: relative; top: -5px;"),
    windowTitle = "PHS Weekly COVID-19 report",    #title for browser tab
    header = tags$head(includeCSS("www/styles.css"),  # CSS styles
                       tags$link(rel = "shortcut icon", href = "favicon_phs.ico")), #Icon for browser tab     
    # includeScript("data/google-analytics.js")), #Including Google analytics
    
    #################### Introduction ----
    tabPanel("Introduction",
             icon = icon("info-circle"),
             value = "intro",
             h3("COVID-19 Statistical Report"),
             h3("Background"),
             p("Since the start of the COVID-19 outbreak Public Health Scotland (PHS) has been working closely 
               with Scottish Government and health and care colleagues in supporting the surveillance and monitoring 
               of COVID-19 amongst the population. This interactive dashboard contains charts and data on the following topics:"),
             tags$li("Positive Cases"),
             tags$li("Acute Hospital Admissions"),
             tags$li("ICU Admissions"),
             tags$li("NHS24 Contacts"),
             tags$li("Community Hubs and Assessment Centres"),
             tags$li("Scottish Ambulance Service"),
             tags$li("COVID-19 in children and young people"),
             tags$li("Contact Tracing"),
             tags$li("Health Care Workers"),
             tags$li("Care Homes"),
             p(""),
             p("Interactive charts on each of the topics are available in the ",
               actionLink("jump_to_summary", "'Trend Charts' tab.")),
             p("The underlying data used to create the interactive charts can be downloaded using the ",
               actionLink("jump_to_table", "'Data' tab."),
               "Note that some numbers may not sum to the total as disclosure control methods have been applied
               to the data in order to protect patient confidentiality."),
             p("The contact tracing data can be downloaded using the ",
               actionLink("jump_to_CTtable", "'Contact Tracing Data' tab.")),
             p("The Health Care Worker Data can be downloaded using the ",
               actionLink("jump_to_HCW", "'Health Care Worker Data' tab.")),
             p("The Care Homes Data can be downloaded using the ",
               actionLink("jump_to_CH", "'Care Home Data' tab.")),
             
             h3("Further information"),
             
             p("Metadata for this dashboard can be downloaded from the ",
               tags$a(
                 href = "https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/",
                 "weekly statistical report page.",
                 class = "externallink")),
             
             p("There is a large amount of data being regularly published regarding COVID-19. 
               This dashboard complements the range of existing data currently available."),
             
             p("New releases will be published at the same time as the Public Health Scotland ",
               tags$a(
                 href = "https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/",
                 "COVID-19 weekly report for Scotland.",
                 class = "externallink")),
             
             p("Information on the wider impacts on the health care system from COVID-19 are available on the ",
               tags$a(
                 href = "https://scotland.shinyapps.io/phs-covid-wider-impact/",
                 "Wider Impacts dashboard.",
                 class = "externallink")),
             
             p("Information and support on a range of topics in regards to COVID-19 are available on the ",
               tags$a(
                 href = "https://www.gov.scot/coronavirus-covid-19/",
                 "Scottish Government website.",
                 class = "externallink")),
             
             p("Information on deaths involving COVID-19 is available on the ",
               tags$a(
                 href = "https://www.nrscotland.gov.uk/statistics-and-data/statistics/statistics-by-theme/vital-events/general-publications/weekly-and-monthly-data-on-births-and-deaths/deaths-involving-coronavirus-covid-19-in-scotland/",
                 "National Records Scotland website.",
                 class = "externallink")),
             
             h3("Contact"),         
             p("If you have any questions relating to these data please contact: ",
               tags$b(
                 tags$a(
                   href = "mailto:phs.covidweeklyreport@phs.scot",
                   "phs.covidweeklyreport@phs.scot",
                   class = "externallink")),"."),
             p("If you have a media query please contact: ",
               tags$b(
                 tags$a(
                   href = "mailto:phs.comms@nhs.net",
                   "phs.comms@nhs.net",
                   class = "externallink")),".")#,
             # ".")
             ), #tabPanel bracket
    
    
    #################### Trend Charts ----
    
    tabPanel(
      title = "Trend Charts",
      icon = icon("area-chart"),
      value = "summary",
      wellPanel(
        column(4,
               div(title = "Select the data you want to explore.", # tooltip
                   radioGroupButtons("measure_select",
                                     label = "Select the data you want to explore.",
                                     choices = data_list,
                                     status = "primary",
                                     direction = "vertical",
                                     justified = T))),
        column(4,
               downloadButton('download_chart_data', 'Download data'),
               fluidRow(br()),
               actionButton(inputId='ab1', label='Metadata',
                            icon = icon("th"), 
                            onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                            '_blank')"))
        
        ), #wellPanel bracket
      
      mainPanel(width = 12,
                uiOutput("data_explorer")
      )# mainPanel bracket
      
    ),# tabpanel bracket
    
    #################### Data ----
    tabPanel(
      title = "Data",
      icon = icon("table"),
      value = "table",
      p("This section allows you to view the data in table format.
        You can use the filters to select the data you are interested in.
        You can also download the data as a csv using the download button.
        The data are also hosted in the",
        tags$a(href = "https://www.opendata.nhs.scot/dataset?groups=covid-19",
               "Scottish Health and Social Care Open Data portal",
               class = "externallink"),"."),
      column(6,        
             selectInput("data_select", "Select the data you want to explore.",
                         choices = data_list_data_tab)),      
      column(6, downloadButton('download_table_csv', 'Download data')),
      mainPanel(width = 12,
                DT::dataTableOutput("table_filtered"))
    ),# tabpanel bracket
    
    
    ##################### Contact Tracing Charts ----
    
    navbarMenu("Contact Tracing",
               icon = icon("address-book"),
               tabPanel(
      title = "Contact Tracing",
      icon = icon("address-book"),
      value = "contacttracing",
      wellPanel(
        column(4,
               div(title = "Select the measure you want to view.", # tooltip
                   radioGroupButtons("ContactTracing_select",
                                     label = "Select the measure you want to view.",
                                     choices = CTdata_list_chart_tab,
                                     status = "primary",
                                     direction = "vertical",
                                     justified = T))),
        
        column(4,
               downloadButton('download_CT_data', 'Download data'),
               fluidRow(br()),
               actionButton(inputId='ab2', label='Metadata',
                            icon = icon("th"),
                            onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                            '_blank')"))
        
        ), #wellPanel bracket
      
      mainPanel(width = 12,
                uiOutput("ContactTracing_explorer")
      )# mainPanel bracket
      
      ),# tabpanel bracket
    
    #################### Contact Tracing Data ----
    tabPanel(
      title = "Contact Tracing Data",
      icon = icon("table"),
      value = "CTtable",
      p("This sections allow you to view the contact tracing data and time performance indicators 
        in a table format. This section is being developed and will show further information/graphics 
        on these statistics. Please note these are developmental statistics and ongoing work is in place 
        to improve recording and use of fields within the CMS to increase accuracy 
        (further information available in the metadata)."),
      p("Please note that during a data quality exercise some historic figures have been revised."),
      p("You can use the filters to select the data you are interested in.
        You can also download the data as a csv using the download button."),
      
      column(8,        
             selectInput("CTdata_select", "Select the data you want to explore.",
                         choices = CTdata_list_data_tab)),      
      column(4, downloadButton('CTdownload_table_csv', 'Download data'),
             fluidRow(br()),
             actionButton(inputId='ab1', label='Metadata',
                          icon = icon("th"), 
                          onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                          '_blank')")),
      p("Please note this includes individuals with no information on their Health Board of residence and from elsewhere in the UK.  
        We are aware of a higher number of these records in week ending 20th December.  
        This is under investigation, and any revision will be updated in subsequent publications."),
      
      mainPanel(width = 12,
                DT::dataTableOutput("CTtable_filtered"))
      ) # tabpanel bracket
    ), # navbar menu bracket
    
    
    #################### Setting Charts ----
    
    tabPanel(
      title = "Setting",
      icon = icon("address-book"),
      value = "settingchart",
      
      h3("Setting"),
      p("Public Health Scotland has been able to present information on settings and events that contact tracing index cases have attended over the previous 7 days. This is based on interviews conducted with cases identified in the Case Management System (CMS) and involves cases recalling where they have been in the 7 days prior to symptom onset (or date of test if asymptomatic). The data in this section relate to the number of cases added to CMS over the past 7 days."),
      p("Therefore, users of these data must exercise caution and cannot make inferences about the rank of settings and events where cases visited. The data presented below were analysed using data from the CMS which was designed for contact tracing purposes and not for identifying where transmission took place."),
      p("However,", strong("Public Health Scotland cannot infer from the figures whether a specific setting or an event indicates where the COVID-19 transmission took place."), "This is because cases may have attended multiple settings or events within a short space of time. In addition, it is possible that even though a case visited a few settings and events, transmission may have taken place elsewhere."),
      p(strong("Therefore, users of these data must exercise caution and cannot make inferences about the rank of settings and events where cases visited. The data presented below were analysed using data from the CMS which was designed for contact tracing purposes and not for identifying where transmission took place."), "This information is collected to help identify close contacts and to understand potential identification of source of exposure."),
      
      hr(),
      
      column(4,        
             selectInput("Setting_select", "Select the setting type you want to view.",
                         choices = SettingList)),  
      column(4,
             downloadButton('download_setting_data', 'Download data'),
             fluidRow(br()),
             actionButton(inputId='ab3', label='Metadata',
                          icon = icon("th"),
                          onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                          '_blank')")), 
      
      mainPanel(width = 12,
                uiOutput("Setting_explorer")  
      )# mainPanel bracket
      
      ),# tabpanel bracket
    
    #################### Health Care Worker Data ----
    tabPanel(
      title = "Health Care Worker Data",
      icon = icon("table"),
      value = "HCWtable",
      p("This sections allow you to view data on the number of health care workers being tested* each week within
        each Health Board. This section is being developed and will show further information/graphics 
        on these statistics. Please note these are developmental statistics and ongoing work is in place 
        to improve recording of data to increase accuracy (further information available in the metadata)." ),
      p("*the number of staff tested excludes those who have declined to test and those who have not been tested for operational reasons."),
      p("Please note some of the data are suppressed due to disclosure methodology being applied to protect patient/staff confidentiality"),
      p("Please note NHS Borders, NHS Fife and NHS Forth Valley advised they do not have any Long Stay Care of the Elderly units 
        that meet the 3 month criteria NHS Highland, NHS Tayside, NHS Orkney, NHS Shetland, and NHS Western Isles advised they do not have any long stay care of the elderly wards. 
        NHS Greater Glasgow & Clyde advised that over recent years they have significantly reduced the number of long stay beds for older people and invested in care at home and care homes 
        hence the low number of wards affected compared to other NHS Boards. NHS Lanarkshire include one of the Care of the Elderly Units for reporting purposes. 
        NHS Lanarkshire confirmed this does not represent a full week of testing since some was done after the reporting period."),
       p("You can use the filters to select the data you are interested in.
        You can also download the data as a csv using the download button."),
      
      column(8,        
             selectInput("HCWdata_select", "Select the data you want to explore.",
                         choices = HCWdata_list_data_tab)),      
      column(4, downloadButton('HCWdownload_table_csv', 'Download data'),
             fluidRow(br()),
             actionButton(inputId='ab4', label='Metadata',
                          icon = icon("th"), 
                          onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                          '_blank')")),
      
      mainPanel(width = 12,
                DT::dataTableOutput("HCWtable_filtered"))
    ),# tabpanel bracket
    
    tabPanel(
      title = "Care Homes Data",
      icon = icon("home"),
      value = "CHData",
      
      h3("Number of Staff and Residents in Care Homes with Confirmed COVID-19"),
      p("As of 20 January 2021, Public Health Scotland took over reporting of weekly data on COVID-19 in adult Care Homes in Scotland – data prior to 11 January 2021 can be found on the ", a(href = "https://www.gov.scot/publications/coronavirus-covid-19-additional-data-about-adult-care-homes-in-scotland/", "Scottish Government website."),
        "These data are provisional management information submitted to the Turas Care Home Management system by Care Homes, and details numbers of people (i.e. staff and residents) tested in the last week. The numbers capture both those tests undertaken via NHS routes and those done via the Scottish Social Care portal.
        Figures are an undercount in some cases as complete data were not collected for all Care Homes.
        It is the responsibility of Boards to work with care homes as part of their oversight arrangements to quality assure these data. The role of PHS is to collate and publish only. Please use this information with caution."),
      hr(),
      downloadButton('download_care_home_data', 'Download data'),
      mainPanel(width = 12,
                DT::dataTableOutput("care_homes_table")))
    
    #################### Ethnicity Chart ----
    
    # tabPanel(
    #   title = "Ethnicity",
    #   icon = icon("address-book"),
    #   value = "Ethnicity_Chart",
    #   
    #   column(4,
    #          downloadButton('download_ethnicity_data', 'Download data'),
    #          fluidRow(br()),
    #          actionButton(inputId='ab6', label='Metadata',
    #                       icon = icon("th"),
    #                       onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
    #                       '_blank')")),
    #   
    #   mainPanel(width = 12,
    #             uiOutput("Ethnicity_explorer"))
    #   
    # )# tabpanel bracket
   
 
    

    ## End -----------
    
      ) # page bracket
             ) # taglist bracket
##END