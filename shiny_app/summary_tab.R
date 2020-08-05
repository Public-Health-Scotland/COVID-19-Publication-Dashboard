
## Modals ----


#modal to describe dataset
# Link action button click to modal launch 
observeEvent(input$btn_dataset_modal, 
              
             if (input$measure_select == "LabCases") { # Positive Cases MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("ECOSS (Electronic Communication of Surveillance in Scotland) Database"),
                 p(glue("Date extracted: {labcases_extract_date}")),
                 p("For a small number of laboratory results initially reported as positive on 
                    subsequent additional testing the laboratory result may be amended to negative,
                    and the individual no longer managed as a confirmed case.") ,                                   
                  p("Note: Specimen date was not available for historical UK Government Regional 
                    Testing centres data between 15 and 25 April. As a sample date is required 
                    to report in ECOSS these samples were assigned a specimen date in the mid-point
                    within this date range (20 April). Date refers to the date the sample was 
                    received into the PHS Surveillance System."),
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)")))
               
             } else if (input$measure_select == "Admissions") { #Admissions MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("ECOSS (Electronic Communication of Surveillance in Scotland) and 
                   RAPID (Rapid Preliminary Inpatient Data"), 
                p(glue("Data are correct as at the time of data extract at 9am on {admission_extract_date}.
                       Data are reviewed and validated on a continuous basis and 
                       so may be subject to change")),
                  p("Note that there may be a time lag with some data for the most recent days 
                    and some of the above figures may change as more data is submitted. 
                    Data now includes any positive cases from NHS Laboratories or 
                    UK Government regional testing sites."),               
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)")))
               
             } else if (input$measure_select == "ICU") { #ICU MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("Data excludes any patient under the age 15."), 
                 p("Data collection for the SICSAG core dataset is by the bespoke Wardwatcher 
                    data collecting platform. SICSAG data is subject to ongoing validation and 
                    must be regarded as dynamic. Therefore if this analysis was to be to re-run 
                    at a later stage it may be subject to change."), 
                 p("In the first report published (6th May), counts shown included any patient 
                    who had contact with ICU since 1st March 2020 and had a positive COVID-19 
                    test at any time. This definition was adjusted to reflect reports from SICSAG 
                    to only include patients with a positive COVID-19 specimen date prior to 
                    discharge from an intensive care unit. Therefore, current data are only 
                    comparable to figures previously reported by PHS since 13th May 2020."), 
                 p("Counts include any patient with a confirmed positive COVID-19 test 
                    (confirmed by linkage to ECOSS) taken prior to discharge from an ICU in Scotland. 
                    Counts do not include any COVID-19 suspected cases who have not yet been lab 
                    confirmed. Therefore there may be a lag for recent days where patients may 
                    still be awaiting the results of COVID-19 tests. Counts do not include any 
                    re-admissions from COVID-19 patients previously admitted to an ICU and re-admitted 
                    post discharge; counts are unique patients only. Individual patients are 
                    identified using their CHI number as recorded within the ICU admissions system.
                    There may be a very small number of patients where CHI was not recorded, for whom 
                    linkage to ECOSS for COVID-19 status may not have been possible."), 
                    p(glue("Data are correct as at the time of data extract at {ICU_extract_date}. 
                    Data are reviewed and validated on a continuous basis and so may be subject to change. 
                    The COVID-19 pandemic is a rapidly evolving situation.")),
                 
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)")))
               
             } else if (input$measure_select == "NHS24") { #NHS24 MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("Information about NHS24 data source goes here ", 
                   tags$a(href="https://www.isdscotland.org/Health-Topics/Emergency-Care/Emergency-Department-Activity/Hospital-Site-List/",
                          "link text to show.", class="externallink")),
                 p("Additional information relating to NHS24 is available from the ", 
                   tags$a(href="https://beta.isdscotland.org/find-publications-and-data/health-services/hospital-care/nhs-performs-weekly-update-of-emergency-department-activity-and-waiting-time-statistics/", 
                          "link text to show.", 
                          class="externallink")),
                 p("Numbers of NHS24 Contacts will include....." ),                   
                 p("The  dataset is managed by ", 
                   tags$a(href="https://www.isdscotland.org/Health-Topics/Emergency-Care/Emergency-Department-Activity/", 
                          "Public Health Scotland (PHS).", class="externallink")),
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)")))
               
             } else if (input$measure_select == "AssessmentHub") { #NHS24 MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("Information about Assessment Hubs data source goes here ", 
                   tags$a(href="https://www.isdscotland.org/Health-Topics/Emergency-Care/Emergency-Department-Activity/Hospital-Site-List/",
                          "link text to show.", class="externallink")),
                 p("Additional information relating to Assessment Hubs is available from the ", 
                   tags$a(href="https://beta.isdscotland.org/find-publications-and-data/health-services/hospital-care/nhs-performs-weekly-update-of-emergency-department-activity-and-waiting-time-statistics/", 
                          "link text to show.", 
                          class="externallink")),
                 p("Numbers of Assessment Hub Consultations will include....." ),                   
                 p("The  dataset is managed by ", 
                   tags$a(href="https://www.isdscotland.org/Health-Topics/Emergency-Care/Emergency-Department-Activity/", 
                          "Public Health Scotland (PHS).", class="externallink")),
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)")))
               
             } else if (input$measure_select == "SAS") { #SAS MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("Information about SAS data source goes here ", 
                   tags$a(href="https://www.isdscotland.org/Health-Topics/Emergency-Care/Emergency-Department-Activity/Hospital-Site-List/",
                          "link text to show.", class="externallink")),
                 p("Additional information relating to SAS is available from the ", 
                   tags$a(href="https://beta.isdscotland.org/find-publications-and-data/health-services/hospital-care/nhs-performs-weekly-update-of-emergency-department-activity-and-waiting-time-statistics/", 
                          "link text to show.", 
                          class="externallink")),
                 p("Numbers of SAS incidents will include....." ),                   
                 p("The  dataset is managed by ", 
                   tags$a(href="https://www.isdscotland.org/Health-Topics/Emergency-Care/Emergency-Department-Activity/", 
                          "Public Health Scotland (PHS).", class="externallink")),
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)")))
             }
)

###############################################.
# Modal to explain SIMD and deprivation
simd_modal <- modalDialog(
  h5("What is SIMD and deprivation?"),
  p("The", tags$a(href="https://simd.scot/", "Scottish Index of Multiple Deprivation (SIMD).",
                  class="externallink"), "is the Scottish Government's 
    official tool for identifying areas in Scotland with concentrations of deprivation 
    by incorporating several different aspects of deprivation (multiple-deprivations) 
    and combining them into a single index. Concentrations of deprivation are identified 
    in SIMD at Data Zone level and can be analysed using this small geographical unit. 
    The use of data for such small areas helps to identify 'pockets' (or concentrations) 
    of deprivation that may be missed in analyses based on larger areas such as council 
    areas. By identifying small areas where there are concentrations of multiple deprivation, 
    the SIMD can be used to target policies and resources at the places with the greatest need. 
    The SIMD identifies deprived areas, not deprived individuals."),
  p("In this tool we use the concept of quintile, which refers to a fifth of the population. 
    For example when we talk about the most deprived quintile, this means the 20% of the population 
    living in the most deprived areas."),
  size = "l", 
  easyClose = TRUE, fade=TRUE, footer = modalButton("Close (Esc)")
  )
# Link action button click to modal launch 
observeEvent(input$btn_modal_simd, { showModal(simd_modal) }) 

#NHS Inform data sources
inform_modal <- modalDialog(
  title = "What is the data source?",
  p("Some text here"), 
  p("Some more text here"),
  size = "l", 
  easyClose = TRUE, fade=TRUE, footer = modalButton("Close (Esc)")
  )

# Link action button click to modal launch 
observeEvent(input$btn_dataset_inform, { showModal(inform_modal) }) 


###############################################.

## Reactive layout  ----

# The charts and text shown on the app will depend on what the user wants to see
output$data_explorer <- renderUI({
  
  # text for titles of cut charts
  dataset <- case_when(input$measure_select == "LabCases" ~ "Cases",
                       input$measure_select == "Admissions" ~ "Admissions",
                       input$measure_select == "ICU" ~ "ICU admissions", 
                       input$measure_select == "NHS24" ~ "NHS24 contacts", 
                       input$measure_select == "AssessmentHub" ~ "Consultations", 
                       input$measure_select == "SAS"~ "SAS incidents")
  
  total_title <- glue("Daily number of {dataset}")
  agesex_title <- glue("{dataset} per 100,000 population by age")
  simd_title <- glue("{dataset} by deprivation category (SIMD)")
  
  # data sources
  data_source <- case_when(input$measure_select == "LabCases" ~ "ECOSS",
                       input$measure_select == "Admissions" ~ "ECOSS/RAPID",
                       input$measure_select == "ICU" ~ "SICSAG", 
                       input$measure_select == "NHS24" ~ "DATA SOURCE NEEDED", 
                       input$measure_select == "AssessmentHub" ~ "DATA SOURCE NEEDED", 
                       input$measure_select == "SAS"~ "DATA SOURCE NEEDED")
  
  # Function to create the standard layout for all the different charts/sections
  cut_charts <- function(title, source, data_name) {
    tagList(
      h3(title),
      actionButton("btn_dataset_modal", paste0("Data source: ", source), icon = icon('question-circle')),
      plot_box(paste0(total_title), paste0(data_name, "_overall")),
      plot_cut_box(paste0(agesex_title), paste0(data_name, "_AgeSex"),
                   paste0(simd_title), paste0(data_name, "_SIMD")))
  }
  
  #for e.g. ICU admissions where no SIMD data
  cut_charts_missing <- function(title, source, data_name) {
    tagList(
      h3(title),
      actionButton("btn_dataset_modal", paste0("Data source: ", source), icon = icon('question-circle')),
      plot_box(paste0(total_title), paste0(data_name, "_overall")),
      plot_cut_missing(paste0(agesex_title), paste0(data_name, "_AgeSex")))
  }
  
  # Charts and rest of UI
  if (input$measure_select == "LabCases") { #Positive Cases
    cut_charts(title= "Daily number of positive cases", 
               source = data_source, data_name = "LabCases")
    
  } else if (input$measure_select == "Admissions") { #Admissions
    cut_charts(title= "Daily number of Acute Hospital Admissions", 
               source = data_source, data_name = "Admissions")
    
  } else if (input$measure_select == "ICU") {# ICU 
    cut_charts_missing(title= "Daily number of ICU Admissions",
               source = data_source, data_name ="ICU")
    
  } else if (input$measure_select == "NHS24") {# NHS 24 contacts
    tagList(cut_charts(title = "Daily completed contacts with NHS24", 
               source = data_source, data_name ="NHS24"),
    h3("NHS Inform"),
    actionButton("btn_dataset_inform", "Data source: INFORM", icon = icon('question-circle')),
    plot_box("NHS inform hits", "NHS24_inform"),
    plot_box("NHS24 self help guides completed", "NHS24_selfhelp"),
    plot_box("NHS24 community hub outcomes", "NHS24_community")
      )
  } else if (input$measure_select == "AssessmentHub") { # Assessment Hub
    cut_charts(title= "Daily number of consultations", 
               source = data_source, data_name ="AssessmentHub")
    
  } else if (input$measure_select == "SAS") { # SAS data
    c(cut_charts(title= "Daily attended incidents by Scottish Ambulance Service", 
               source = data_source, data_name ="SAS"),
    plot_box("SAS - all incidents", plot_output = "SAS_all")
    )
  } else if (input$measure_select == "deaths") { # Deaths data
    cut_charts(title= "Weekly number of deaths", 
               source = data_source, data_name ="deaths")
  }
}) 

###############################################.
## Charts ----
###############################################.
###############################################.
# Creating plots for each cut and dataset
# Positive Cases
output$LabCases_overall <- renderPlotly({plot_overall_chart(LabCases, data_name = "LabCases")})
output$Admissions_overall <- renderPlotly({plot_overall_chart(Admissions, data_name = "Admissions")})
output$ICU_overall <- renderPlotly({plot_overall_chart(ICU, data_name = "ICU")})
output$NHS24_overall <- renderPlotly({plot_overall_chartNHS24(NHS24, data_name = "NHS24")})
output$AssessmentHub_overall <- renderPlotly({plot_overall_chartAssessmentHub(AssessmentHub, data_name = "AssessmentHub")})
output$SAS_overall <- renderPlotly({plot_overall_chartSAS(SAS, data_name = "SAS")})

#age/sex and SIMD charts
output$LabCases_AgeSex <- renderPlotly({plot_agesex_chart(LabCases_AgeSex, data_name = "LabCases_AgeSex")})
output$LabCases_SIMD <- renderPlotly({plot_simd_chart(LabCases_SIMD, data_name = "LabCases_SIMD")})
output$Admissions_AgeSex <- renderPlotly({plot_agesex_chart(Admissions_AgeSex, data_name = "Admissions_AgeSex")})
output$Admissions_SIMD <- renderPlotly({plot_simd_chart(Admissions_SIMD, data_name = "Admissions_SIMD")})
output$ICU_AgeSex <- renderPlotly({plot_agesex_chart(ICU_AgeSex, data_name = "ICU_AgeSex")})
output$NHS24_AgeSex <- renderPlotly({plot_agesex_chart(NHS24_AgeSex, data_name = "NHS24_AgeSex")})
output$NHS24_SIMD <- renderPlotly({plot_simd_chart(NHS24_SIMD, data_name = "NHS24_SIMD")})
output$AssessmentHub_AgeSex <- renderPlotly({plot_agesex_chart(AssessmentHub_AgeSex, data_name = "AssessmentHub_AgeSex")})
output$AssessmentHub_SIMD <- renderPlotly({plot_simd_chart(AssessmentHub_SIMD, data_name = "AssessmentHub_SIMD")})
output$SAS_AgeSex <- renderPlotly({plot_agesex_chart(SAS_AgeSex, data_name = "SAS_AgeSex")})
output$SAS_SIMD <- renderPlotly({plot_simd_chart(SAS_SIMD, data_name = "SAS_SIMD")})

#extra NHS24/SAS charts
output$NHS24_inform <- renderPlotly({plot_singletrace_chart(NHS24_inform, data_name = "NHS24_inform")})
output$NHS24_selfhelp <- renderPlotly({plot_nhs24_selfhelp_chart(NHS24_selfhelp, data_name = "NHS24_selfhelp")})
output$NHS24_community <- renderPlotly({plot_nhs24_community_chart(NHS24_community, data_name = "NHS24_community")})
output$SAS_all <- renderPlotly({plot_singletrace_chart(SAS_all, data_name = "SAS_all")})


## Data downloads ----


# For the charts at the moment the data download is for the overall one,
# need to think how to allow downloading for each chart
# Reactive dataset that gets the data the user is visualisaing ready to download
overall_data_download <- reactive({
  switch(
    input$measure_select,
    "LabCases" = LabCases,
    "Admissions" = Admissions,
    "ICU" = ICU,
    "NHS24" = NHS24, 
    "AssessmentHub" = AssessmentHub,
    "SAS" = SAS) #%>% 
  #select(area_name, week_ending, count, starts_with("average")) %>% 
  # mutate(week_ending = format(week_ending, "%d %b %y"))
})

output$download_chart_data <- downloadHandler(
  filename ="data_extract.csv",
  content = function(file) {
    write_csv(overall_data_download(),
              file) } 
)

###############################################.
## Commentary tab content  ----
###############################################.


# Summary Commentary ------------------------------------------------------

# output$summary_commentary <- renderUI({
#   tagList(
#     bsButton("jump_to_summary",label = "Go to data"), #this button can only be used once
#     
#     h2("Summary - DATE UPDATED 2020"), 
#     p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas nec finibus arcu. Suspendisse vitae nunc velit. 
#       Nunc fringilla cursus nunc. Nulla nec neque mauris. Nunc a nisl vitae erat egestas dictum sed tempus tortor."),
#     
#     h4("Background"),
#     p("Suspendisse elit urna, tincidunt at mauris in, maximus egestas tellus. Nulla eleifend erat a congue congue. 
#       Nunc sed purus sit amet metus cursus egestas at et nunc. Morbi imperdiet nunc odio, non congue lorem efficitur sed:"),
#     tags$ul( 
#       tags$li("bullet point 1"),
#       tags$li("bullet point 2"),
#       tags$li("bullet point 3")),
#     
#     p("Public Health Scotland aims to provide information and intelligence on the wider 
#       impacts of COVID-19 on health, healthcare and health inequalities that are not directly due to COVID-19."),
#     
#     p("The work to date has made use of the following data sources:"),
#     tags$ul(
#       tags$li("Positive Cases"),
#       tags$li("Admissions"),
#       tags$li("ICU"),
#       tags$li("NHS 24 completed contacts."),
#       tags$li("Scottish Ambulance Service data.")),
#     
#     h4("Header"),
#     tags$ul( 
#       tags$li("bullet point 1"),
#       tags$li("bullet point 2"),
#       tags$li("bullet point 3")),
#     
#     h4("Future work"),
#     p("Work is under way to broaden the range of data sources available – within the next few weeks 
#       we expect to publish information on ...."
#     ))
# })

# Positive Cases Commentary -----------------------------------------------


output$positivecases_commentary <- renderUI({
  tagList(
    h2("Positive Cases - Updated: 10th June 2020"),
    p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas nec finibus arcu. Suspendisse vitae nunc velit. 
      Nunc fringilla cursus nunc. Nulla nec neque mauris. Nunc a nisl vitae erat egestas dictum sed tempus tortor."),
    
    h4("Background"),
    p("Suspendisse elit urna, tincidunt at mauris in, maximus egestas tellus. Nulla eleifend erat a congue congue. 
      Nunc sed purus sit amet metus cursus egestas at et nunc. Morbi imperdiet nunc odio, non congue lorem efficitur sed:"),
    tags$ul( 
      tags$li("bullet point 1"),
      tags$li("bullet point 2"),
      tags$li("bullet point 3"))
    )
})


# Admissions Commentary ---------------------------------------------------

output$admissions_commentary <- renderUI({
  tagList(
    h2("Acute Hospital Admissions - Updated: 10th June 2020"),
    p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas nec finibus arcu. Suspendisse vitae nunc velit. 
      Nunc fringilla cursus nunc. Nulla nec neque mauris. Nunc a nisl vitae erat egestas dictum sed tempus tortor."),
    
    h4("Background"),
    p("Suspendisse elit urna, tincidunt at mauris in, maximus egestas tellus. Nulla eleifend erat a congue congue. 
      Nunc sed purus sit amet metus cursus egestas at et nunc. Morbi imperdiet nunc odio, non congue lorem efficitur sed:"),
    tags$ul( 
      tags$li("bullet point 1"),
      tags$li("bullet point 2"),
      tags$li("bullet point 3"))
    )
})


# ICU Commentary ----------------------------------------------------------

output$ICU_commentary <- renderUI({
  tagList(
    h2("ICU - Updated: 10th June 2020"),
    p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas nec finibus arcu. Suspendisse vitae nunc velit. 
      Nunc fringilla cursus nunc. Nulla nec neque mauris. Nunc a nisl vitae erat egestas dictum sed tempus tortor."),
    
    h4("Background"),
    p("Suspendisse elit urna, tincidunt at mauris in, maximus egestas tellus. Nulla eleifend erat a congue congue. 
      Nunc sed purus sit amet metus cursus egestas at et nunc. Morbi imperdiet nunc odio, non congue lorem efficitur sed:"),
    tags$ul( 
      tags$li("bullet point 1"),
      tags$li("bullet point 2"),
      tags$li("bullet point 3"))
    )
})


# NHS24 Commentary --------------------------------------------------------


output$NHS24_commentary <- renderUI({
  tagList(
    h2("NHS24 Contacts - Updated: 10th June 2020"),
    p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas nec finibus arcu. Suspendisse vitae nunc velit. 
      Nunc fringilla cursus nunc. Nulla nec neque mauris. Nunc a nisl vitae erat egestas dictum sed tempus tortor."),
    
    h4("Background"),
    p("Suspendisse elit urna, tincidunt at mauris in, maximus egestas tellus. Nulla eleifend erat a congue congue. 
      Nunc sed purus sit amet metus cursus egestas at et nunc. Morbi imperdiet nunc odio, non congue lorem efficitur sed:"),
    tags$ul( 
      tags$li("bullet point 1"),
      tags$li("bullet point 2"),
      tags$li("bullet point 3"))
    )
})
# Assessment Hub Commentary --------------------------------------------------------


output$AssessmentHub_commentary <- renderUI({
  tagList(
    h2("Assessment Hubs - Updated: 10th June 2020"),
    p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas nec finibus arcu. Suspendisse vitae nunc velit. 
      Nunc fringilla cursus nunc. Nulla nec neque mauris. Nunc a nisl vitae erat egestas dictum sed tempus tortor."),
    
    h4("Background"),
    p("Suspendisse elit urna, tincidunt at mauris in, maximus egestas tellus. Nulla eleifend erat a congue congue. 
      Nunc sed purus sit amet metus cursus egestas at et nunc. Morbi imperdiet nunc odio, non congue lorem efficitur sed:"),
    tags$ul( 
      tags$li("bullet point 1"),
      tags$li("bullet point 2"),
      tags$li("bullet point 3"))
    )
})
# SAS Commentary ----------------------------------------------------------


output$SAS_commentary <- renderUI({
  tagList(
    h2("SAS - Updated: 10th June 2020"),
    p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas nec finibus arcu. Suspendisse vitae nunc velit. 
      Nunc fringilla cursus nunc. Nulla nec neque mauris. Nunc a nisl vitae erat egestas dictum sed tempus tortor."),
    
    h4("Background"),
    p("Suspendisse elit urna, tincidunt at mauris in, maximus egestas tellus. Nulla eleifend erat a congue congue. 
      Nunc sed purus sit amet metus cursus egestas at et nunc. Morbi imperdiet nunc odio, non congue lorem efficitur sed:"),
    tags$ul( 
      tags$li("bullet point 1"),
      tags$li("bullet point 2"),
      tags$li("bullet point 3"))
    )
})
#END