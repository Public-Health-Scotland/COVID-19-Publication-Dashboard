
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
      tags$link(rel = "shortcut icon", href = "favicon_phs.ico"), #Icon for browser tab     
      includeScript("//freddy/DEPT/PHIBCS/PHI/Publications/Health Topic/HPS/Covid-19/COVID19_Dashboard/google-analytics.js")), #Including Google analytics
    
    

## Introduction ----

tabPanel("Introduction",
         icon = icon("info-circle"),
         value = "intro",
         column(4,
             h3("COVID-19 Statistical Report")),
         column(8,
                tags$br(),
          h3("Background"),
          p("On 1 March 2020, the first person in Scotland was tested positive for COVID-19. 
            On 17 March NHS Scotland was placed in an emergency footing by the Cabinet Secretary. 
            Schools have been closed since 20 March and the country has been in lockdown since 23 March. 
            Scotland entered phase one of easing out of lockdown on Friday 29 May, phase two on 
            Friday 19 June and phase three on Friday 10 July."),
          p("Since 15 June 2020, Public Health Scotland publishes the total number of results, positive and 
            negative, carried out across any NHSScotland Laboratories and UK Government Regional Testing Centres."),
          p("Since the start of the outbreak Public Health Scotland (PHS) has been working closely with 
            Scottish Government and health and care colleagues in supporting the surveillance and 
            monitoring of COVID-19 amongst the population."),
          p("This report shows the trends of the number of positive COVID-19 tests in Scotland, 
            and looks at some of the wider impacts of the virus on the healthcare system,
            comparing recent trends in activity with historic norms. 
            Since 17 June 2020 the report includes data on Test and Protect."),
          h3("Main Points"),
          tags$ul( 
            tags$li("Between 28 May to 26 July 2020, 1,049 individuals were recorded in the 
                    contact tracing software, from which 3,101 contacts have been traced."),
            tags$li("As at 26 July 2020, there have been 18,554 confirmed COVID-19 cases, 
                    equating to 339.6 confirmed cases per 100,000 population."),
            tags$li("Between 1 March 2020 and 22 July 2020, there had been 5,949 admissions to 
                    hospital with a laboratory confirmed test of COVID-19."),
            tags$li("As at 26 July 2020, 531 confirmed COVID-19 patients have been treated in an 
                    Intensive Care Unit. There have been 3 confirmed COVID-19 patients admitted 
                    to ICU in the last week."),
            tags$li("As at 26 July 2020, 327,701 people in Scotland have tested negative.")),
          
          p(
          "Interactive charts on each of the topics are available in the ",
          actionLink("jump_to_summary", "'Summary trends' tab.")),
          p(
          "The underlying data used to create the interactive charts can be downloaded using the ",
          actionLink("jump_to_table", "'Data' tab."),
          "Note that some numbers may not sum to the total as disclosure control methods have been applied
          to the data in order to protect patient confidentiality."),
          p(
          "This tool will be updated weekly. New releases will be published at the same time as the Public Health Scotland ",
          tags$a(
            href = "https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/",
            "COVID-19 weekly report for Scotland.",
            class = "externallink")),
          p(
          "If you have any questions relating to this data please contact: ",
          tags$b(
            tags$a(
              href = "mailto:phs.statsgov@nhs.net",
              "phs.statsgov@nhs.net",
              class = "externallink")),"."),
          p(
            "If you have a media query please contact: ",
            tags$b(
              tags$a(
                href = "mailto:phs.comms@nhs.net",
                "phs.comms@nhs.net",
                class = "externallink")),"."),
          ".")
         ), #tabPanel bracket

## Commentary ----

tabPanel(title = "Commentary",
  icon = icon("list-ul"),
  value = "comment",
  wellPanel(column(12,
                   p("Select topic areas to find commentary relating to data presented in this tool."))),
  wellPanel(
    column(2,
           p("Select topic:"),
           actionLink("summary_button", "Summary", width = "150px"),
           br(),
           actionLink("positivecases_button", "Positive Cases", width = "150px"),
           br(),
           actionLink("admissions_button", "Admissions", width = "150px"),
           br(),
           actionLink("ICU_button", "ICU", width = "150px"),
           br(),
           actionLink("NHS24_button", "NHS24", width = "150px"),
           br(),           
           actionLink("AssessmentHub_button", "Assessment Hub", width = "150px"),
           br(),
           actionLink("SAS_button", "SAS", width = "150px"))
    ,

    column(10,
           bsCollapse(
             id = "collapse_commentary",
             open = "Panel 1",  ##PanelSet id
             bsCollapsePanel("Summary", uiOutput("summary_commentary")),  ##collapsible panel for summary tab
             bsCollapsePanel("Positive Cases", uiOutput("positivecases_commentary")),  ##collapsible panel for cardiovascular tab
             bsCollapsePanel("Admissions", uiOutput("admissions_commentary")),
             bsCollapsePanel("ICU", uiOutput("ICU_commentary")),
             bsCollapsePanel("NHS24", uiOutput("NHS24_commentary")),
             bsCollapsePanel("Assessment Hubs", uiOutput("AssessmentHub_commentary")),
             bsCollapsePanel("SAS", uiOutput("SAS_commentary"))
             ))

     )#wellPanel bracket
  ),#tab panel
   
## Summary trends ----

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
           actionButton('jump_commentary_summary', 'Go to commentary'))
   
     ), #wellPanel bracket
  
mainPanel(width = 12,
          uiOutput("data_explorer")
          )# mainPanel bracket

),# tabpanel bracket

## Data ----
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
  ) # tabpanel bracket

## End -----------

) # page bracket
) # taglist bracket
##END