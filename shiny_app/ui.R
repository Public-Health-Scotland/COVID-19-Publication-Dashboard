
#UI
tagList(  #needed for shinyjs
  useShinyjs(),  # Include shinyjs
  navbarPage(
    id = "intabset",# id used for jumping between tabs
    title = div(
      tags$a(img(src = "phs-logo.png", height = 40), href = "https://www.publichealthscotland.scot/"),
      style = "position: relative; top: -5px;"),
    windowTitle = "COVID-19 wider impacts",    #title for browser tab
    header = tags$head(includeCSS("www/styles.css"),  # CSS styles
      tags$link(rel = "shortcut icon", href = "favicon_phs.ico"), #Icon for browser tab     
      includeScript("google-analytics.js")), #Including Google analytics
    
    

## Introduction ----

tabPanel("Introduction",
         icon = icon("info-circle"),
         value = "intro",
         column(4,
             h3("COVID-19 Title goes here")),
         column(8,
                tags$br(), 
          p("Write introduction Stuff here"),
          p("This is a new paragraph"),
          tags$ul(
            tags$li(
            "bullet point 1"),
            tags$li(
            "bullet point 2"),
            tags$li(
            "bullet point 3")),
          
          p(
          "This information tool provides an overview of changes in health and use of healthcare during the COVID-19
          pandemic in Scotland, drawing on a range of national data sources."),
          p(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas nec finibus arcu. 
          Suspendisse vitae nunc velit. Nunc fringilla cursus nunc. Nulla nec neque mauris. Nunc a nisl vitae erat egestas dictum sed tempus tortor. Suspendisse elit urna, tincidunt at mauris in, maximus egestas tellus. Nulla eleifend erat a congue congue. 
          Nunc sed purus sit amet metus cursus egestas at et nunc. "),
          p(
          "Morbi imperdiet nunc odio, non congue lorem efficitur sed. Curabitur gravida ex a tempor vestibulum. 
          Aenean non aliquet nisi, at malesuada nibh. 
          Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut et dictum sapien."),
          p(
          "Interactive charts on each of the topics are available in the ",
          actionLink("jump_summary", "'Summary trends' tab.")),
          p(
          "The underlying data used to create the interactive charts can be downloaded using the ",
          actionLink("jump_table", "'Data' tab."),
          "Note that some numbers may not sum to the total as disclosure control methods have been applied
          to the data in order to protect patient confidentiality."),
          p(
          "This tool will be updated ??weekly?? New releases will be published at the same time as the Public Health Scotland ",
          tags$a(
            href = "https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/",
            "COVID-19 weekly report for Scotland.",
            class = "externallink")),
          p(
          "If you have any questions relating to the data presented please contact us at: ",
          tags$b(
            tags$a(
              href = "mailto:phs.covid19analytics@nhs.net",
              "phs.covid19analytics@nhs.net",
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