#UI
tagList(  #needed for shinyjs
  useShinyjs(),  # Include shinyjs
  # specify most recent fontawesome library
  tags$style("@import url(https://use.fontawesome.com/releases/v6.1.1/css/all.css);"),
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
                       #includeHTML("www/google-analytics.html"), #Including Google analytics
                       HTML("<html lang='en'>")
                       ),

    #################### Introduction ----
    tabPanel("Introduction",
             icon = icon("info-circle"),
             value = "intro",
             h2("Welcome to the COVID-19 statistical report dashboard"),
             p("Since the start of the COVID-19 outbreak Public Health Scotland (PHS) has been working closely
               with Scottish Government and health and care colleagues in supporting the surveillance and monitoring
               of COVID-19 amongst the population."),
             h3("What's on the dashboard?"),
             p("You can navigate around the dashboard using the tabs on the top banner, or by clicking one of the boxes below."),
             # 1st row of boxes
             fluidRow(
               br(),
               # Cases and infection levels
               column(8, style = "padding-left: 0px; padding-right: 0px;",
                        column(6, class="landing-page-column",
                               lp_main_box(button_name = 'jump_to_inf_cases', title_box = "Cases and infection levels",
                                           description = 'Reported cases and reinfections')),
               # LFDs
               column(6, class="landing-page-column",
                               lp_main_box(button_name = 'jump_to_LFD', title_box = "Lateral Flow Devices",
                                           description = 'Trends in LFD testing and demographic breakdown'))
                      ),
               # Severe illness
               column(4, class="landing-page-column",
                      lp_main_box(button_name = 'jump_to_severe_illness', title_box = "Severe illness",
                                    description = 'Hospital and ICU admissions'))
             ), # fluid row close
             # End of first row
             # 2nd row of boxes
             fluidRow(
               br(),
               # Populations of interest
               column(8, style = "padding-left: 0px; padding-right: 0px;",
                        column(6, class="landing-page-column",
                               lp_main_box(button_name = 'jump_to_pop_interest', title_box = "Populations of Interest",
                                           description = 'Care home testing and visiting status')),
               # Vaccinations
               column(6, class="landing-page-column",
                               lp_main_box(button_name = 'jump_to_vaccinations', title_box = "Vaccinations",
                                           description = 'Vaccine certification and wastage information'))
                      ),
               # Surveillance
               column(4, class="landing-page-column",
                     lp_main_box(button_name = 'jump_to_surveillance', title_box = "Surveillance",
                                    description = 'Statistics from NHS24 and Scottish Ambulance Service'))
             ), # fluid row close
             # End of second row
             br(),
             br(),
             h3("Archived information (no longer updated)"),
             br(),
             # 3rd row is split into two boxes per space
             fluidRow(
                        column(3, class="landing-page-column",
                               lp_about_box(button_name = 'jump_to_CT',
                                            title_box = "Contact tracing"),
                               lp_about_box(button_name = 'jump_to_CTtable',
                                            title_box = "Contact tracing data")),
                        column(3, class="landing-page-column",
                               lp_about_box(button_name = 'jump_to_HCW',
                                            title_box = "Healthcare workers"),
                               lp_about_box(button_name = 'jump_to_CH',
                                            title_box = "Care homes archive")),
                        column(3, class="landing-page-column",
                               lp_about_box(button_name = 'jump_to_quarantine',
                                            title_box = "Quarantine statistics"),
                               lp_about_box(button_name = 'jump_to_mtu',
                                            title_box = "Targeted community testing")),
                        column(3, class="landing-page-column",
                               lp_about_box(button_name = 'jump_to_surveillance_archive',
                                            title_box = "Community hubs and assessment"),
                               lp_about_box(button_name = 'jump_to_travel',
                                            title_box = "Travel outside Scotland"))
             ), #Fluidrow bracket
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
                class = "externallink")),".")
             ), #tabPanel bracket
    #################### Notes  ----
    tabPanel("Notes",
             icon = icon("file-lines", verify_fa=F),
             value = "Notes",
             h3("Notes and additional information"),
             wellPanel(
                       column(12,
                              p("Select a tab topic to see notes on the data."),
                              bsCollapse(id = "collapse_notes", open = "Panel 1",
                                         bsCollapsePanel("Cases & infection levels", uiOutput("cases_inf_notes")),
                                         bsCollapsePanel("Changes in COVID-19 testing policy", uiOutput("timeline_notes")),
                                         bsCollapsePanel("Lateral Flow Devices (LFDs)", uiOutput("LFD_notes")),
                                         bsCollapsePanel("Severe illness", uiOutput("severe_illness_notes")),
                                         bsCollapsePanel("Populations of interest", uiOutput("population_int_notes")),
                                         bsCollapsePanel("Surveillance", uiOutput("surveillance_notes")),
                                         bsCollapsePanel("Vaccinations", uiOutput("vaccinations_notes"))
                                         )))

             ), #tabPanel bracket


    #################### Infection levels and cases -----
    navbarMenu(
      title = "Cases & infection levels",
      icon = icon("virus-covid", verify_fa=FALSE),
      tabPanel(
        title = "Charts",
        icon = icon("chart-area"),
        value = "InfCases",
        wellPanel(
          column(4,
                 div(title = "Select the data you want to explore.",
                     radioGroupButtons("measure_select_infcases",
                                       status="btn",
                                       label = "Select the data you want to explore.",
                                       choices = inf_levels_cases_list,
                                       selected = inf_levels_cases_list[[1]],
                                       direction = "vertical",
                                       justified = T)
                     )
                 ),
          column(4,
                 downloadButton('download_infcases_data', 'Download data', class="down"),
                 fluidRow(br()),
                 actionButton(inputId='ab1', label='Metadata',
                              icon = icon("th"),
                              onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                              '_blank')"),
                 fluidRow(br()),
                 actionButton('jump_to_notes_inf_cases', 'Go to data notes'))

          ), #wellPanel bracket

        mainPanel(width = 12,
                  uiOutput("data_explorer_infcases")
        )# mainPanel bracket

      ),

      #################### Data ----
      tabPanel(
        title = "Data",
        icon = icon("table"),
        value = "InfCasesData",
        p("This section allows you to view the data in table format.
          You can use the filters to select the data you are interested in.
          You can also download the data as a csv using the download button.
          The data are also hosted in the",
          tags$a(href = "https://www.opendata.nhs.scot/dataset?groups=covid-19",
                 "Scottish Health and Social Care Open Data portal",
                 class = "externallink"),"."),

        # tags$li("On 05 January 2022, the Scottish Government",
        #         tags$a(href= "https://www.gov.scot/news/self-isolation-and-testing-changes/",
        #                "announced",
        #                class = "externallink"),
        #         "that asymptomatic people who return a positive lateral flow device (LFD) no longer have to confirm their positive result with a PCR test."),
        # tags$li(strong(style="color:black", "From 01 March 2022, PHS now include episodes of reinfection within COVID-19 reporting.
        #                Prior to this date COVID-19 cases were based on an individual’s first positive test result only.
        #                The new daily calculation includes both new infections and possible reinfections.
        #                Possible reinfections are defined as individuals who test positive, by PCR (polymerase chain reaction) or LFD (lateral flow device), 90 days or more after their last positive test.",
        #                "More information available on the Public Health Scotland website",
        #                tags$a(href="https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/",
        #                       "here.", class="externallink"))),
        #  tags$li("Please note that the data on hospital admissions by ethnicity only refers to laboratory confirmed (PCR) COVID-19 tests."),
        # br(),
        br(),
        column(6,
               selectInput("data_select_infcases", "Select the data you want to explore.",
                           choices = inf_levels_cases_data_list)),
        column(6, downloadButton('download_infcases_table_csv', 'Download data', class="down")),
        mainPanel(width = 12,
                  uiOutput("infcases_table"))
      )# tabpanel bracket

      ), # page bracket

    #################### LFDs -----

    navbarMenu(
      title = "LFDs",
      icon = icon("vial-virus", verify_fa=F),

      tabPanel(
        title = "LFD testing",
        icon = icon("vial-circle-check", verify_fa=F),
        value = "LFDData",

        h3("Lateral Flow Device testing"),
        # tags$li("Across Scotland, there are numerous testing pathways being rolled out using Lateral Flow Devices (LFD) - a clinically validated swab antigen test taken that does not require a laboratory for processing."),
        # tags$li(" This test can produce rapid results within 45 minutes at the location of the test. "),
        # tags$li("Some of the areas using LFD tests are: schools, health and social care workers, care homes and more."),
        # tags$li(" Public Health Scotland has collected the information on the number of LFD tests carried out across Scotland and will now publish this information weekly. "),
        # tags$li("LFD testing in Scotland expanded from 26 April 2021, with everyone able to access rapid COVID-19 testing even if they had no symptoms."),
        # tags$li(" Any individual who receives a positive test result using a Lateral Flow Device is advised to self-isolate and arrange for a confirmatory PCR test."),
        # tags$li("The PCR result will determine the number of cases of COVID-19 in Scotland."),
        # hr(),
        downloadButton('download_LFD_weekly_data', 'Download weekly totals', class="down"),
        downloadButton('download_LFD_data', 'Download cumulative Health Board data', class="down"),
        downloadButton('download_LFD_testgroup', 'Download test group data', class="down"),
        fluidRow(br()),
        actionButton('jump_to_notes_LFD', 'Go to data notes'),
        mainPanel(width = 12,
                  uiOutput("LFD_output"),
                  br3(), br3(), br3()
        )),

      tabPanel(
        title = "LFD demographic",
        icon = icon("vials"),
        value = "LFDdemoData",


        h3("Lateral Flow Device demographics"),
        p("This section allows you to view the total number of individuals tested and the
          number of individuals testing positive at least once within Scotland. Data available by
          age & gender and Scottish Index of Multiple Deprivation (SIMD) quintile (where SIMD 1 is the most deprived and SIMD 5 is the least deprived - see",
          tags$a(
            href = "https://www.gov.scot/collections/scottish-index-of-multiple-deprivation-2020/?utm_source=redirect&utm_medium=shorturl&utm_campaign=simd",
            "here for more information.)",
            class = "externallink") ),
       # p(glue("Data were extracted on {LFD_demo_date}. The data in this tab only cover submissions with a valid CHI.")),
       fluidRow(br()),
       actionButton('jump_to_notes_LFD', 'Go to data notes'),

        hr(),
        fluidRow(
          column(width = 6,
                 div(title = "people_output_select", # tooltip
                     selectInput("people_output_selection", label = "Demographic Selection",
                                 choices = people_output_selection))),
          column(width = 6,
                 div(title = "plot_output_select", # tooltip
                     selectInput("plot_output_selection", label = "Output Selection",
                                 choices = plot_output_selection)))
        ), #fluidRow bracket

        hr(),
        uiOutput("people_tab"),

        br3(), br3(), br3()

        )
    ),

    #################### Severe illness -----
    navbarMenu(
      title = "Severe illness",
      icon = icon("bed-pulse", verify_fa=F),
      tabPanel(
        title = "Charts",
        icon = icon("chart-area"),
        value = "SevereIllness",
        wellPanel(
          column(4,
                 div(title = "Select the data you want to explore.", # tooltip
                     radioGroupButtons("measure_select_severe_illness",
                                       label = "Select the data you want to explore.",
                                       choices = severe_illness_list,
                                       status = "btn",
                                       selected = severe_illness_list[[1]],
                                       direction = "vertical",
                                       justified = T))),
          column(4,
                 downloadButton('download_severe_illness_data', 'Download data', class="down"),
                 fluidRow(br()),
                 actionButton(inputId='ab1', label='Metadata',
                              icon = icon("th"),
                              onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                              '_blank')"),
                 fluidRow(br()),
                 actionButton('jump_to_notes_severe_illness', 'Go to data notes')
                 )

        ), #wellPanel bracket

        mainPanel(width = 12,
                  uiOutput("data_explorer_severe_illness")
        )# mainPanel bracket

      ),
      #################### Data ----
      tabPanel(
        title = "Data",
        icon = icon("table"),
        value = "SevereIllnessData",
        p("This section allows you to view the data in table format.
          You can use the filters to select the data you are interested in.
          You can also download the data as a csv using the download button.
          The data are also hosted in the",
          tags$a(href = "https://www.opendata.nhs.scot/dataset?groups=covid-19",
                 "Scottish Health and Social Care Open Data portal",
                 class = "externallink"),"."),

        # tags$li("On 05 January 2022, the Scottish Government",
        #         tags$a(href= "https://www.gov.scot/news/self-isolation-and-testing-changes/",
        #                "announced",
        #                class = "externallink"),
        #         "that asymptomatic people who return a positive lateral flow device (LFD) no longer have to confirm their positive result with a PCR test."),
        # tags$li(strong(style="color:black", "From 01 March 2022, PHS now include episodes of reinfection within COVID-19 reporting.
        #                Prior to this date COVID-19 cases were based on an individual’s first positive test result only.
        #                The new daily calculation includes both new infections and possible reinfections.
        #                Possible reinfections are defined as individuals who test positive, by PCR (polymerase chain reaction) or LFD (lateral flow device), 90 days or more after their last positive test.",
        #                "More information available on the Public Health Scotland website",
        #                tags$a(href="https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/",
        #                       "here.", class="externallink"))),
        # tags$li("Please note that the data on hospital admissions by ethnicity only refers to laboratory confirmed (PCR) COVID-19 tests."),
        br(),
        br(),
        column(6,
               selectInput("data_select_severe_illness", "Select the data you want to explore.",
                           choices = severe_illness_data_list)),
        column(6, downloadButton('download_severe_illness_table_csv', 'Download data', class="down")),
        mainPanel(width = 12,
                  uiOutput("severe_illness_table"))
      )# tabpanel bracket
      ## End -----------

    ), # page bracket
    #################### Populations of interest -----
    navbarMenu(
      title = "Populations of interest",
      icon = icon("people-group", verify_fa=F),
      tabPanel(
        title = "Care homes COVID-19 cases",
        icon = icon("home"),
        value = "PopInterest",
        fluidRow(br()),
        actionButton('jump_to_notes_pop_interest', 'Go to data notes'),

        h3('Number of COVID-19 cases for care home residents and staff'),
        # tags$li('As of 06 April 2022, Public Health Scotland are reporting weekly data on COVID-19 ',
        #         'cases in adult Care Homes in Scotland, previously reported by the ',
        #         tags$a(href="https://www.gov.scot/publications/coronavirus-covid-19-daily-data-for-scotland/",
        #                "Scottish Government.",
        #                class = "externallink")),
        # tags$li(' A positive case includes both new infections and ',
        #         'possible reinfections.'),
        # tags$li('Possible reinfections are defined as individuals who test positive ',
        #         'by PCR (polymerase chain reaction) or LFD (lateral flow device), 90 or more clear days ',
        #         'after their last positive test. '),
        # tags$li('Data Sources: PCR - UK Gov and NHS Labs; LFD – Self ',
        #         'reporting NSS portal and UK Gov.'),
        # tags$li(' The source data are dynamic, and additional test results ',
        #         'received will be reflected in future calculations of cases, which may affect figures ',
        #         'retrospectively.'),
        downloadButton('download_care_home_timeseries_data', 'Download time series data', class="down"),
        mainPanel(width = 12,
                  withSpinner(DT::dataTableOutput('CareHomeSeriesTable')),
                  plot_box("", 'CareHomeSeriesGraph')


        )# mainPanel bracket

      ),
       tabPanel(
         title = "Care homes visiting status by Health Board and outbreak status",
         icon = icon("user", verify_fa=F),
         value = "CareHomesVisitors",

         h3("Care homes visiting status in Scotland, by Health Board and Outbreak Status"),

         tags$li("PHS now report on the visiting status of Care Homes in Scotland, previously reported by the ",
           tags$a(href = "https://www.gov.scot/publications/coronavirus-covid-19-additional-data-about-adult-care-homes-in-scotland/",
                  "Scottish Government",
                  class = "externallink")),
         tags$li("These data are updated every 4 weeks."),
         tags$li("The following data tables provide a snapshot of care home visiting status. For all caveats, please refer to the notes page"),
         actionButton('jump_to_notes_pop_interest_outbreak', 'Go to data notes'),

         mainPanel(width = 12,
                   h3("Table 1: Visiting status of adult care homes by NHS board, week ending ", CareHomeVisitsDate),
                   downloadButton('care_home_visits_data_download', 'Download by visiting status by health board data'),
                   withSpinner(DT::dataTableOutput('CareHomeVisitsBoardTable')),

                   h3("Table 2: Visiting status of adult care homes by COVID-19 outbreak status, week ending ", CareHomeVisitsDate),
                   downloadButton('care_home_outbreak_data_download', 'Download visiting status by outbreak data', class="down"),
                   withSpinner(DT::dataTableOutput('CareHomeVisitsOutbreakTable')),

                   h3("Table 3a: Visiting status of care homes registered as for older adults by NHS Board, week ending ", CareHomeVisitsDate),
                   downloadButton('care_home_visits_older_data_download', 'Download older adult care home data', class="down"),
                   withSpinner(DT::dataTableOutput('CareHomeVisitsBoardOlderTable')),

                   h3("Table 3b: Visiting status of care homes NOT registered as for older adults by NHS Board, week ending ", CareHomeVisitsDate),
                   downloadButton('download_care_home_visits_not_older_data', 'Download not older adult care home data'),
                   withSpinner(DT::dataTableOutput('CareHomeVisitsNotOlderTable'))


         )

       ) #,


      # tabPanel(
      #   title = "Healthcare workers",
      #   icon = icon("user-doctor", verify_fa=F),
      #   value = "HCW",
      #
      #   h3('Number of COVID-19 cases for healthcare workers')
      #
      # )
      ## End -----------

    ), # page bracket
    #################### Surveillance -----
    navbarMenu(
      title = "Surveillance",
      icon = icon("desktop"),
      tabPanel(
        title = "Charts",
        icon = icon("chart-area"),
        value = "Surveillance",
        wellPanel(
          column(4,
                 div(title = "Select the data you want to explore.", # tooltip
                     radioGroupButtons("measure_select_surveillance",
                                       label = "Select the data you want to explore.",
                                       choices = surveillance_list,
                                       status = "btn",
                                       selected = surveillance_list[[1]],
                                       direction = "vertical",
                                       justified = T))),
          column(4,
                 downloadButton('download_surveillance_data', 'Download data', class="down"),
                 fluidRow(br()),
                 actionButton(inputId='ab1', label='Metadata',
                              icon = icon("th"),
                              onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                              '_blank')"),
                 fluidRow(br()),
                 actionButton('jump_to_notes_surveillance', 'Go to data notes')
          )

        ), #wellPanel bracket

        mainPanel(width = 12,
                  uiOutput("data_explorer_surveillance")
        )# mainPanel bracket

      ),
      #################### Data ----
      tabPanel(
        title = "Data",
        icon = icon("table"),
        value = "SurveillanceData",
        p("This section allows you to view the data in table format.
          You can use the filters to select the data you are interested in.
          You can also download the data as a csv using the download button.
          The data are also hosted in the",
          tags$a(href = "https://www.opendata.nhs.scot/dataset?groups=covid-19",
                 "Scottish Health and Social Care Open Data portal",
                 class = "externallink"),"."),

        # tags$li("On 05 January 2022, the Scottish Government",
        #         tags$a(href= "https://www.gov.scot/news/self-isolation-and-testing-changes/",
        #                "announced",
        #                class = "externallink"),
        #         "that asymptomatic people who return a positive lateral flow device (LFD) no longer have to confirm their positive result with a PCR test."),
        # tags$li(strong(style="color:black", "From 01 March 2022, PHS now include episodes of reinfection within COVID-19 reporting.
        #                Prior to this date COVID-19 cases were based on an individual’s first positive test result only.
        #                The new daily calculation includes both new infections and possible reinfections.
        #                Possible reinfections are defined as individuals who test positive, by PCR (polymerase chain reaction) or LFD (lateral flow device), 90 days or more after their last positive test.",
        #                "More information available on the Public Health Scotland website",
        #                tags$a(href="https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/",
        #                       "here.", class="externallink"))),
        # tags$li("Please note that the data on hospital admissions by ethnicity only refers to laboratory confirmed (PCR) COVID-19 tests."),
        br(),
        br(),
        column(6,
               selectInput("data_select_surveillance", "Select the data you want to explore.",
                           choices = surveillance_data_list)),
        column(6, downloadButton('download_surveillance_table_csv', 'Download data', class="down")),
        mainPanel(width = 12,
                  uiOutput("surveillance_table"))
      )# tabpanel bracket
      ## End -----------

    ), # page bracket
    #################### Vaccinations -----
    navbarMenu(
      title = "Vaccinations",
      icon = icon("syringe"),
      ### Vaccines
      tabPanel(
        title = "Vaccine certification",
        icon = icon("passport"),
        value = "vaccinetab",

        h3("COVID-19 vaccine certification"),
        # tags$li("The NHS Covid Status App was launched on 30 September 2021. It is free and offers digital proof of vaccination via a QR code for each vaccination received."),
        # tags$li("You can request a vaccine certificate if you are aged 12 and over and have been vaccinated in Scotland. The record will not show any vaccinations given outside of Scotland."),
        # tags$li("You can show your COVID-19 vaccine status by using the", tags$a(href= "https://www.nhsinform.scot/covid-status", "NHS Scotland Covid Status app,", class ="externallink"),
        #         " download a PDF copy of your status from the app or ", tags$a(href="https://www.nhsinform.scot/nhs-scotland-covid-status/", "get a paper record of your vaccine status from NHS Inform.", class="externallink")),
        # tags$li("Vaccine certifications are no longer legally required in Scotland. The app will remain available so any business that wishes to continue certification on a voluntary basis to reassure customers will be able to do so."),
        # tags$li("Check the vaccine certification scheme guidance for ", tags$a(href="https://www.gov.scot/publications/coronavirus-covid-19-certification-businesses-event-organisers/", "businesses and event organisers", class="externallink"),  " and for ",
        #         tags$a(href="https://www.gov.scot/publications/coronavirus-covid-19-certification-information-for-customers/", "customers.", class="externallink")),
        # tags$li("For further information, you can refer to ", tags$a(href="https://www.gov.scot/news/living-safely-with-covid/", "https://www.gov.scot/news/living-safely-with-covid/.", class="externallink")),
        tags$li(glue("The figures in the table below are for up to midnight on {vaccine_cert_date}.")),
        hr(),
        actionButton('jump_to_notes_vaccinations_cert', 'Go to data notes'),
        downloadButton('download_vaccine_cert_data', 'Download data', class="down"),
        mainPanel(width = 12,
                  DT::dataTableOutput("vaccine_cert_table"))
      ),
      tabPanel(
        title = "Vaccine wastage",
        icon = icon("dumpster", verify_fa=F),
        value = "Vaccinations",

        h3("COVID-19 vaccine wastage"),
        fluidRow(br()),
        actionButton('jump_to_notes_vaccinations_waste', 'Go to data notes'),
        mainPanel(width = 12,
                  uiOutput("VaccineWastage_output"),
                  br3(), br3(), br3()
        )

      )
      ## End -----------

    ), # page bracket
    #################### Archive -----
    navbarMenu(
      title = "Archive",
      icon = icon("floppy-disk", verify_fa=F),
      #################### Surveillance -----
        tabPanel(
          title = "Community hubs & assessment",
          icon = icon("chart-area"),
          value = "SurveillanceArchive",
          wellPanel(
            column(4,
                   div(title = "Select the data you want to explore.", # tooltip
                       radioGroupButtons("measure_select_surveillance_archive",
                                         label = "Select the data you want to explore.",
                                         choices = surveillance_archive_list,
                                         status = "primary",
                                         selected = surveillance_archive_list[[1]],
                                         direction = "vertical",
                                         justified = T))),
            column(4,
                   downloadButton('download_surveillance_archive_data', 'Download data'),
                   fluidRow(br()),
                   actionButton(inputId='ab1', label='Metadata',
                                icon = icon("th"),
                                onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                                '_blank')"))

            ), #wellPanel bracket

          mainPanel(width = 12,
                    uiOutput("data_explorer_surveillance_archive")
          )# mainPanel bracket

        ),
        #################### Data ----
        tabPanel(
          title = "Community hubs & assessment data",
          icon = icon("table"),
          value = "SurveillanceArchiveData",
          p("This section allows you to view the data in table format.
          You can use the filters to select the data you are interested in.
          You can also download the data as a csv using the download button.
          The data are also hosted in the",
            tags$a(href = "https://www.opendata.nhs.scot/dataset?groups=covid-19",
                   "Scottish Health and Social Care Open Data portal",
                   class = "externallink"),"."),

          tags$li("On 05 January 2022, the Scottish Government",
                  tags$a(href= "https://www.gov.scot/news/self-isolation-and-testing-changes/",
                         "announced",
                         class = "externallink"),
                  "that asymptomatic people who return a positive lateral flow device (LFD) no longer have to confirm their positive result with a PCR test."),
          tags$li(strong(style="color:black", "From 01 March 2022, PHS now include episodes of reinfection within COVID-19 reporting.
                       Prior to this date COVID-19 cases were based on an individual’s first positive test result only.
                       The new daily calculation includes both new infections and possible reinfections.
                       Possible reinfections are defined as individuals who test positive, by PCR (polymerase chain reaction) or LFD (lateral flow device), 90 days or more after their last positive test.",
                         "More information available on the Public Health Scotland website",
                         tags$a(href="https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/",
                                "here.", class="externallink"))),
          tags$li("Please note that the data on hospital admissions by ethnicity only refers to laboratory confirmed (PCR) COVID-19 tests."),
          br(),
          br(),
          column(6,
                 selectInput("data_select_surveillance_archive", "Select the data you want to explore.",
                             choices = surveillance_archive_data_list)),
          column(6, downloadButton('download_surveillance_archive_table_csv', 'Download data')),
          mainPanel(width = 12,
                    uiOutput("surveillance_archive_table"))
        ), # tabpanel bracket
      tabPanel(
        title = "Contact tracing",
        icon = icon("address-book"),
        value = "CT",
        p("Scotland’s approach to contact tracing has continued to adapt throughout the pandemic to reflect changing circumstances, variability in cases, and increasing proportion of the population fully
          vaccinated since the roll out of the vaccination programme. The most recent",
          tags$a(href = "https://www.gov.scot/publications/coronavirus-covid-19-scotlands-strategic-framework-update-november-2021/",
                 "Strategic Framework",
                 class = "externallink"),
          "issued by the Scottish Government in November 2021 sets out how Scotland will continue to adapt now that we are in the phase described as “beyond level zero”. That will require a constant review
          of the associated management information compiled in the weekly report. The information we produce will change over time to reflect the most critical information to help understand, plan and deliver
          contact tracing at any given point in time."),
        p("On 05 January 2022, the Scottish Government",
          tags$a(href= "https://www.gov.scot/news/self-isolation-and-testing-changes/",
                 "announced",
                 class = "externallink"),
          "that asymptomatic people who return a positive lateral flow device (LFD) no longer have to confirm their positive result with a PCR test."),
        p(strong(style="color:black", "From 01 March 2022, PHS now include episodes of reinfection within COVID-19 reporting.
                 Prior to this date COVID-19 cases were based on an individual’s first positive test result only.
                 The new daily calculation includes both new infections and possible reinfections.
                 Possible reinfections are defined as individuals who test positive, by PCR (polymerase chain reaction) or LFD (lateral flow device), 90 days or more after their last positive test.",
                 "More information available on the Public Health Scotland website",
                 tags$a(href="https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/",
                        "here.", class="externallink"))),
        p(),
        strong(''),
        p(),

        wellPanel(
          column(4,
                 div(title = "Select the measure you want to view.", # tooltip
                     radioGroupButtons("ContactTracing_select",
                                       label = "Select the measure you want to view.",
                                       choices = CTdata_list_chart_tab,
                                       status = "btn",
                                       direction = "vertical",
                                       justified = T))),

          column(4,
                 downloadButton('download_CT_data', 'Download data', class="down"),
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
        title = "Contact tracing data",
        icon = icon("address-book"),
        value = "CTtable",
        p(strong("Information: ")),
        tags$li("This section allows you to view the contact tracing data and time performance indicators
                in a table format."),
        tags$li("Please note that during a data quality exercise some historic figures have been revised."),
        tags$li("You can use the filters to select the data you are interested in.
                You can also download the data as a csv using the download button."),
        br(),
        p(strong("Timeline: ")),
        tags$li("On 05 January 2022, the Scottish Government",
                tags$a(href= "https://www.gov.scot/news/self-isolation-and-testing-changes/",
                       "announced",
                       class = "externallink"),
                "that asymptomatic people who return a positive lateral flow device (LFD) no longer have to confirm their positive result with a PCR test."),
        tags$li(strong(style="color:black", "From 01 March 2022, PHS now include episodes of reinfection within COVID-19 reporting.
                       Prior to this date COVID-19 cases were based on an individual’s first positive test result only.")),
        tags$li(strong("The new daily calculation includes both new infections and possible reinfections.
                       Possible reinfections are defined as individuals who test positive, by PCR (polymerase chain reaction) or LFD (lateral flow device), 90 days or more after their last positive test.")),
        tags$li(strong(" Currently hospital admissions do not include reinfections, although this will be updated in coming weeks.")),
        tags$li(strong("More information available on the Public Health Scotland website",
                       tags$a(href="https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/",
                              "here.", class="externallink"))),
        p(),
        strong(''),
        br(),
        p(),


        column(8,
               selectInput("CTdata_select", "Select the data you want to explore.",
                           choices = CTdata_list_data_tab)),
        column(4, downloadButton('CTdownload_table_csv', 'Download data', class="down"),
               fluidRow(br()),
               actionButton(inputId='ab1', label='Metadata',
                            icon = icon("th"),
                            onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                                     '_blank')")),

        mainPanel(width = 12,
                  uiOutput("CT_Data_Tab_table"))

        ), # tabpanel bracket

      tabPanel(
        title = "Travel outside Scotland",
        icon = icon("plane-departure"),
        value = "travelData",

        h3("Travel outside of Scotland cases"),
        p("Since 28 September 2020 fields have been available to record information about whether a case has travelled outside of Scotland.",
          "The information in the chart and table below is collected on the contact tracing interview and is where outside of Scotland travel information is recorded.",
          strong("Please note we are aware of an undercount for those travelled outside Scotland."),
          strong("This is a data quality issue due to recording of the travel information."),
          strong("From 16 February 2022 these data resources are no longer updated.")
        ),
        hr(),
        downloadButton('download_travel_data', 'Download data', class="down"),
        mainPanel(width = 12,
                  plot_box("", "travel_chart"),
                  DT::dataTableOutput("travel_table"))

      ),
      #################### Health Care Worker Data ----
      tabPanel(
        title = "Healthcare worker data",
        icon = icon("user-nurse"),
        value = "HCWtable",
        h3("Health Care Workers"),
        p("This section shows weekly trend data, broken down by health board"),
        p("In July 2020, the Scottish Government expanded COVID-19 testing (PCR) to include key healthcare workers in oncology and haemato-oncology in wards and
          day patient areas including radiotherapy; staffing wards caring for people over 65 years of age where the length of stay for the area is over three months,
          and wards within mental health services where the anticipated length of stay is also over three months.
          A data collection was initially set up to monitor the expansion of testing starting in July 2020. "),
        p(strong("Please note: ")),
        tags$li("This management information must be treated with caution as it may be subject to change as the quality of the data improves"),
        tags$li("Work was undertaken with Boards to improve the quality of the data and this collection has moved over to Public Health Scotland"),
        #  tags$li("Public Health Scotland is working closely with SG and Boards to improve data definitions and quality to ensure consistency across Scotland.
        #    As a result, data may be revised in subsequent weeks and any changes will be clearly signposted. "),
        tags$li("Some of the data are suppressed due to disclosure methodology being applied to protect patient/staff confidentiality"),
        br(),
        p(strong("Information from specific health boards:")),
        tags$li("NHS Borders, NHS Fife and NHS Forth Valley advised they do not have any Long Stay Care of the Elderly units
                that meet the 3 month criteria"),
        tags$li("NHS Highland, NHS Tayside, NHS Orkney, NHS Shetland, and NHS Western Isles advised they do not have any long stay care of the elderly wards."),
        tags$li("NHS Greater Glasgow & Clyde advised that over recent years they have significantly reduced the number of long stay beds for older people and invested in care at home and care homes
                hence the low number of wards affected compared to other NHS Boards."),
        tags$li("NHS Lanarkshire include one of the Care of the Elderly Units for reporting purposes.
                NHS Lanarkshire confirmed this does not represent a full week of testing since some was done after the reporting period."),
        p("You can use the filters to select the data you are interested in.
          You can also download the data as a csv using the download button."),
        p(strong("From 13 April, due to changes in testing policy, these data resources are no longer updated.")),
        br(),

        column(8,
               selectInput("HCWdata_select", "Select the data you want to explore.",
                           choices = HCWdata_list_data_tab)),
        column(4, downloadButton('HCWdownload_table_csv', 'Download data', class="down"),
               fluidRow(br()),
               actionButton(inputId='ab4', label='Metadata',
                            icon = icon("th"),
                            onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                            '_blank')")),

        mainPanel(width = 12,
                  DT::dataTableOutput("HCWtable_filtered"))
        ),# tabpanel bracket

      tabPanel(
        title = "Care homes data",
        icon = icon("home"),
        value = "CHData",

        h3("Numbers of staff and residents tested in care homes with (and without) confirmed COVID-19 cases"),
        tags$li("As of 20 January 2021, Public Health Scotland reports weekly data on COVID-19 in adult Care Homes in Scotland, previously reported by the Scottish Government."),
        tags$li(" Data prior to 11 January 2021 can be found on the ", a(href = "https://www.gov.scot/publications/coronavirus-covid-19-additional-data-about-adult-care-homes-in-scotland/", "Scottish Government website.")),
        tags$li(
          "These data are provisional management information submitted to the Turas Care Home Management system by Care Homes, and details numbers of people (i.e. staff and residents) tested in the last week. "),
        tags$li("The numbers capture both those tests undertaken via NHS routes and those done via ",
                "the Scottish Social Care portal and include the number of staff eligible for ",
                "testing with an outbreak; the number of residents required for testing in homes ",
                "without an outbreak; and the number of staff eligible for testing in homes without ",
                "an outbreak."),
        tags$li("
              Figures are an undercount in some cases as complete data were not collected for all Care Homes."),
        tags$li("
              It is the responsibility of Boards to work with care homes as part of their oversight arrangements to quality assure these data. The role of PHS is to collate and publish only."),
        br(),
        p(strong("Please use this information with caution.")),
        hr(),
        downloadButton('download_care_home_data', 'Download testing data', class="down"),
        mainPanel(width = 12,
                  DT::dataTableOutput("care_homes_table"))
      ),

      ### Quarantine
      tabPanel(
        title = "Quarantine data",
        icon = icon("user-lock"),
        value = "QData",

        h3("Quarantining statistics"),
        tags$li("These statistics provide a summary of the number of people entering Scotland from outside the UK, those required to quarantine, and the numbers contacted by the National Contact Centre (NCC). "),
        tags$li(" Passenger arrivals into Scotland are provided by the Home Office to PHS."),
        tags$li("
              PHS take a sample of those who are required to quarantine and pass the data to NHS National Services Scotland, which runs the NCC on PHS’s behalf."),
        tags$li("
              Those arriving into Scotland who have been in a country on the red list (high risk) at any point in the 10 days before arriving in Scotland are required to quarantine in a hotel for a minimum of 10 days (further information available on the Scottish Government website)."),
        tags$li("Those arriving in Scotland who have been in a country on the amber list (non-high risk) are required to quarantine at home."),
        tags$li("Up to 23 June 2021, a sample of those individuals quarantining at home were contacted by the NCC. These calls were paused in order to prioritise contact tracing.  Since 13 July 2021, these calls have resumed."),
        tags$li("All travellers (except those exempt and those under 18 years of age) will receive an email, providing them with appropriate public health information on self-isolation and testing. "),
        tags$li(" Unvaccinated travellers arriving from an Amber country are also called by the NCC."),
        tags$li("Fully vaccinated travellers arriving from an Amber country, or travellers arriving from a Green country, receive a SMS and email.  Arrivals from a Red country receive an email and continue to be managed via quarantine.  Travellers under the age of 18 are not contacted."
        ),
        br(),
        p(strong(style = "color:black", "From 09 February these data resources are no longer updated. ")),
        hr(),
        downloadButton('download_quarantine_data', 'Download data', class="down"),
        mainPanel(width = 12,
                  DT::dataTableOutput("quarantine_table"))

      ## End -----------

      ),
      ### Mobile Testing Units
      tabPanel(title = "Targeted community testing",
               icon = icon("hospital-user"),
               value = "MTUtab",

               h3("Targeted community testing"),
               p("The Community Testing Programme is ongoing across Scotland.  This is targeted at areas where there are concerns around community transmission levels, and offer testing to any member of that community.",
                 "Use the dropdown to explore the outputs which detail the numbers of tests carried out by the Community Testing Programme."),


               selectInput(inputId = "MTU_select", width = "100%",
                           label = "Use the Dropdown Menu to Select an Output",
                           choices =  list("Key Points" = "summary",
                                           #  "Test Centre Details" = "details",
                                           "Community Testing Over Time" = "heatmap",
                                           "Cumulative Totals" = "cumul_totals",
                                           "Data" = "data")),

               mainPanel(width = 12,
                         uiOutput("MTUOutputs")
               )),

      #################### Setting Charts ----

      tabPanel(
        title = "Setting",
        icon = icon("landmark"),
        value = "settingchart",

        h3("Setting"),
        tags$li("Public Health Scotland has been able to present information on settings and events that contact tracing index cases have attended over the previous 7 days. This is based on interviews conducted with cases identified in the Case Management System (CMS) and involves cases recalling where they have been in the 7 days prior to symptom onset (or date of test if asymptomatic)."),
        tags$li("However,", strong("Public Health Scotland cannot infer from the figures whether a specific setting or an event indicates where the COVID-19 transmission took place."), "This is because cases may have attended multiple settings or events within a short space of time. In addition, it is possible that even though a case visited a few settings and events, transmission may have taken place elsewhere."),
        tags$li(strong("Therefore, users of these data must exercise caution and cannot make inferences about the rank of settings and events where cases visited. The data presented below were analysed using data from the CMS which was designed for contact tracing purposes and not for identifying where transmission took place."), "This information is collected to help identify close contacts and to understand potential identification of source of exposure."),
        tags$li("More information on event groupings can be found in the accompanying metadata document available on the",
                tags$a(
                  href = "https://publichealthscotland.scot/publications/covid-19-statistical-report",
                  "weekly statistical report page.",
                  class = "externallink") ),
        br(),
        p(strong(style = "color:black", "From 28 August due to changes in contact tracing, these data resources are no longer updated.")),
        br(),
        p(strong(" ")),

        hr(),

        column(4,
               selectInput("Setting_select", "Select the setting type you want to view.",
                           choices = SettingList)),
        column(4,
               downloadButton('download_setting_data', 'Download data', class="down"),
               fluidRow(br()),
               actionButton(inputId='ab3', label='Metadata',
                            icon = icon("th"),
                            onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                          '_blank')")),

        mainPanel(width = 12,
                  uiOutput("Setting_explorer")
        )# mainPanel bracket


      )# tabpanel bracket


    )
###########################################################################
  ) # taglist bracket

)
##END