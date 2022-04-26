#UI
tagList(  #needed for shinyjs
  useShinyjs(),  # Include shinyjs
  navbarPage(
    id = "intabset",# id used for jumping between tabs
    title = div(
      tags$a(img(src = "phs-logo.png", height = 40),
             href = "https://www.publichealthscotland.scot/",
             target = "_blank"),
      style = "position: relative; top: -5px;"),
    windowTitle = "PHS Weekly COVID-19 report",    #title for browser tab
    header = tags$head(includeCSS("www/styles.css"),  # CSS styles
                       tags$link(rel = "shortcut icon", href = "favicon_phs.ico"), #Icon for browser tab
                       includeHTML("www/google-analytics.html"),
                       HTML("<html lang='en'>")), #Including Google analytics

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
             tags$li("Contact Tracing"),
             tags$li("Protect Scotland App"),
             tags$li("Travel outside Scotland"),
             tags$li("Setting"),
             tags$li("Health Care Workers"),
             tags$li("Care Homes"),
             tags$li("Quarantine data"),
             tags$li("Lateral Flow Device Testing"),
             tags$li("Targeted Community Testing"),
             tags$li("Vaccine Certification"),
             br(),
          h3("Information"),
          tags$li("Metadata for this dashboard can be downloaded from the ",
               tags$a(
                 href = "https://publichealthscotland.scot/publications/covid-19-statistical-report",
                 "weekly statistical report page.",
                 class = "externallink")),

          tags$li("There is a large amount of data being regularly published regarding COVID-19.
               This dashboard complements the range of existing data currently available."),

          tags$li("New releases will be published at the same time as the Public Health Scotland ",
               tags$a(
                 href = "https://publichealthscotland.scot/publications/covid-19-statistical-report",
                 "COVID-19 weekly report for Scotland.",
                 class = "externallink")),

          tags$li("Information on the wider impacts on the health care system from COVID-19 are available on the ",
               tags$a(
                 href = "https://scotland.shinyapps.io/phs-covid-wider-impact/",
                 "Wider Impacts dashboard.",
                 class = "externallink")),

          tags$li("Information and support on a range of topics in regards to COVID-19 are available on the ",
               tags$a(
                 href = "https://www.gov.scot/coronavirus-covid-19/",
                 "Scottish Government website.",
                 class = "externallink")),

          tags$li("Information on deaths involving COVID-19 is available on the ",
               tags$a(
                 href = "https://www.nrscotland.gov.uk/statistics-and-data/statistics/statistics-by-theme/vital-events/general-publications/weekly-and-monthly-data-on-births-and-deaths/deaths-involving-coronavirus-covid-19-in-scotland/",
                 "National Records Scotland website.",
                 class = "externallink")),

             h3("Contact"),
          tags$li("If you have any questions relating to these data please contact: ",
               tags$b(
                 tags$a(
                   href = "mailto:PHS.Covid19Data&Analytics@phs.scot",
                   "PHS.Covid19Data&Analytics@phs.scot",
                   class = "externallink")),"."),
          tags$li("If you have a media query please contact: ",
               tags$b(
                 tags$a(
                   href = "mailto:phs.comms@phs.scot",
                   "phs.comms@phs.scot",
                   class = "externallink")),"."),

          tags$li("The GitHub repository supporting this dashboard can be found ",
            tags$b(
              tags$a(
                href = "https://github.com/Public-Health-Scotland/COVID-19-Publication-Dashboard",
                "at this location",
                class = "externallink")),".")#,
             # ".")
             ), #tabPanel bracket


    #################### Infection levels and cases -----
    navbarMenu(
      title = "Cases & Infection Levels",
      icon = icon("chart-area"),
      tabPanel(
        title = "Cases and Infection Levels",
        icon = icon("chart-area"),
        value = "InfCases",
        wellPanel(
          column(4,
                 div(title = "Select the data you want to explore.", # tooltip
                     radioGroupButtons("measure_select",
                                       label = "Select the data you want to explore.",
                                       choices = inf_levels_cases_list,
                                       status = "primary",
                                       direction = "vertical",
                                       justified = T))),
          column(4,
                 downloadButton('download_infcases_data', 'Download data'),
                 fluidRow(br()),
                 actionButton(inputId='ab1', label='Metadata',
                              icon = icon("th"),
                              onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                              '_blank')"))

          ), #wellPanel bracket

        mainPanel(width = 12,
                  uiOutput("data_explorer")
        )# mainPanel bracket

      )
    ## End -----------

      ) # page bracket
  ) # taglist bracket

)
##END