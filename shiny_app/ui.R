
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
         p(""),
         p("Interactive charts on each of the topics are available in the ",
         actionLink("jump_to_summary", "'Trend Charts' tab.")),
         p("The underlying data used to create the interactive charts can be downloaded using the ",
         actionLink("jump_to_table", "'Data' tab."),
          "Note that some numbers may not sum to the total as disclosure control methods have been applied
          to the data in order to protect patient confidentiality."),
         p("The contact tracing data can be downloaded using the ",
           actionLink("jump_to_CTtable", "'Contact Tracing Data' tab.")),
          
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
           p("If you have any questions relating to this data please contact: ",
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
                class = "externallink")),"."),
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
    The data is also hosted in the",
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


#################### Contact Tracing Charts ----

tabPanel(
  title = "Contact Tracing",
  icon = icon("address-book"),
  value = "contacttracing",
  wellPanel(
    # column(4,
    #        div(title = "Select the data you want to explore.", # tooltip
    #            pickerInput("ContactTracing_select",
    #                        label = "Select the NHS Board you want to explore.",
    #                        choices = HB_list))),
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
    (further information available in the metadata). 
    You can use the filters to select the data you are interested in.
    You can also download the data as a csv using the download button."),
  
  column(6,        
         selectInput("CTdata_select", "Select the data you want to explore.",
                     choices = CTdata_list_data_tab)),      
  column(6, downloadButton('CTdownload_table_csv', 'Download data'),
  fluidRow(br()),
  actionButton(inputId='ab1', label='Metadata',
               icon = icon("th"), 
               onclick ="window.open('https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/',
                        '_blank')")),
  
  mainPanel(width = 12,
            DT::dataTableOutput("CTtable_filtered"))
) # tabpanel bracket

## End -----------

) # page bracket
) # taglist bracket
##END