
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
                   and some of the above figures may change as more data are submitted. 
                   Data now includes any positive cases from NHS Laboratories or 
                   UK Government regional testing sites."),               
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)")))
               
             } else if (input$measure_select == "ICU") { #ICU MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("SICSAG"),
                 p("Data excludes any patient under the age 15."), 
                 p("Data collection for the SICSAG core dataset is by the bespoke Wardwatcher 
                   data collecting platform. SICSAG data are subject to ongoing validation and 
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
                 p("NHS24 Systems Applications and Products Business Warehouse", 
                   p("In response to COVID-19, NHS 24 adapted their service provision. People who are concerned about COVID-19, 
                     or who experience symptoms, are advised to seek advice from NHS Inform website, the COVID-19 advice helpline 
                     or to contact NHS 24âs 111 service if their symptoms worsen and they need clinical advice, following which they may be;"),
                   tags$li("provided with self-care advice or be asked to contact their own GP"),
                   tags$li("referred to a COVID-19 community hub for further clinical telephone triage, they may then be asked to attend assessment centre or receive a home visit by a Nurse or Doctor"),
                   tags$li("referred to acute services via the Scottish Ambulance Service or advised to attend hospital, depending on their symptoms."),
                   size = "m",
                   easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))
               
             } else if (input$measure_select == "AssessmentHub") { #NHS24 MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("GP Out of Hours (OOH) ", 
                   p("People may have multiple consultations with a COVID-19 Community Hub and Assessment Centre depending 
                     on their pathway of care. For example, upon referral by NHS 24 (or other services) they will be 
                     clinically triaged over the telephone by the community hub and they may then go on to have a 
                     consultation in person at an assessment centre; this would result in one person having two consultations." ),                   
                   size = "m",
                   easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))
               
             } else if (input$measure_select == "SAS") { #SAS MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("SAS and Unscheduled Care Datamart"),
                 p("When someone telephones 999 and requests an ambulance, the Scottish Ambulance Service (SAS) record 
                   this as an incident. In some cases, multiple phone calls can be received for one incident. 
                   The total number of incidents includes:"),
                 tags$li("redirecting and referring suitable people to alternative pathways, following telephone triage and advanced triage through a SAS practitioner."),
                 tags$li("attended incidents, where a SAS resource (e.g. ambulance, paramedic in a car, specialist paramedic) has arrived at the scene of the incident. Some incidents may be attended by more than one resource."),
                 
                 p("Following assessment and treatment by SAS crews some patients do not require to be taken to hospital. 
                   These patients can be safely left at home with follow up provided by other services including their own GP or GP OOH Services. 
                   It is in the patientâs best interest to get the care they require as close to their own home as is feasible."),
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)")))
               
             } else if (input$measure_select == "Child") { #NHS24 MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("ECOSS (Electronic Communication of Surveillance in Scotland) Database", 
                   p(""),
                   size = "m",
                   easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))
               
             } else if (input$measure_select == "EthnictyChart") { #NHS24 MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("BLANK"),
                 p("BLANK ") ,
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

# Link action button click to modal launch 
observeEvent(input$btn_dataset_inform, { showModal(inform_modal) }) 


###############################################.

## Reactive Charts  ---- 
# The charts and text shown on the app will depend on what the user wants to see
output$data_explorer <- renderUI({
  
  # text for titles of cut charts
  datasettrend <- case_when(input$measure_select == "LabCases" ~ "Positive COVID-19 cases",
                            input$measure_select == "Admissions" ~ "COVID-19 admissions to hospital",
                            input$measure_select == "ICU" ~ "COVID-19 admissions to ICU", 
                            input$measure_select == "NHS24" ~ "NHS 24 111 COVID-19 Contacts and COVID-19 Advice Helpline calls", 
                            input$measure_select == "AssessmentHub" ~ "Consultations", 
                            input$measure_select == "SAS" ~ "SAS incidents (suspected COVID-19)")
  
  # text for titles of cut charts
  dataset <- case_when(input$measure_select == "LabCases" ~ "Positive COVID-19 cases",
                       input$measure_select == "Admissions" ~ "COVID-19 admissions to hospital",
                       input$measure_select == "ICU" ~ "COVID-19 admissions to ICU", 
                       input$measure_select == "NHS24" ~ "COVID-19 related NHS24 contacts", 
                       input$measure_select == "AssessmentHub" ~ "Individuals", 
                       input$measure_select == "SAS" ~ "SAS incidents (suspected COVID-19)")
  
  start_date <- case_when(input$measure_select == "LabCases" ~ "28 February",
                          input$measure_select == "Admissions" ~ "1 March",
                          input$measure_select == "ICU" ~ "11 March",
                          input$measure_select == "NHS24" ~ "13 February",
                          input$measure_select == "AssessmentHub" ~ "23 March",
                          input$measure_select == "SAS" ~ "22 January")
  
  end_date <- case_when(input$measure_select == "LabCases" ~ Labcases_date,
                        input$measure_select == "Admissions" ~ Admissions_date,
                        input$measure_select == "ICU" ~ ICU_date,
                        input$measure_select == "NHS24" ~ NHS24_date,
                        input$measure_select == "AssessmentHub" ~ AssessmentHub_date,
                        input$measure_select == "SAS" ~ SAS_date)
  
  total_title <- glue("Daily number of {datasettrend}")
  agesex_title <- paste0(dataset, " per 100,000 population by age \n(", start_date, " to ", end_date, ")")
  simd_title <- paste0(dataset, " by deprivation category (SIMD) \n(", start_date, " to ", end_date, ")")
  
  subheading <- case_when(input$measure_select == "Admissions" ~ "COVID-19 related admissions have been identified as the following: A patient may have tested positive 
                                                  for COVID-19 14 days prior to admission to hospital, on the day of their admission or during their stay in hospital.",
                          input$measure_select == "NHS24" ~ paste0("The launch of the Redesign of Urgent Care programme will see an increase in NHS 24 activity from the 1st of December onwards as a result of the launch of the programme. For more information see: https://www.gov.scot/policies/healthcare-standards/unscheduled-care/ 
                                             Since 15 September figures for the COVID helpline include calls made to the new flu helpline. 
                                             In late September, the first batch of flu vaccination letters sent to those eligible by NHS Health Boards included the coronavirus number. 
                                             The peaks in calls are consistent with the timing of those letters being sent."),
                          input$measure_select == "AssessmentHub" ~  paste0("Please note that data are provisional and may be updated in future publications as further information is supplied and validated from health boards."),
                          input$measure_select == "SAS" ~ " ")

# data sources
data_source <- case_when(input$measure_select == "LabCases" ~ "ECOSS",
                         input$measure_select == "Admissions" ~ "ECOSS/RAPID",
                         input$measure_select == "ICU" ~ "SICSAG", 
                         input$measure_select == "NHS24" ~ "NHS 24 SAP BW", 
                         input$measure_select == "AssessmentHub" ~ "GP Out of Hours (OOH)", 
                         input$measure_select == "SAS"~ "SAS and Unscheduled Care Datamart")



# Functions for Chart Layouts ---------------------------------------------
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
    p("SICSAG data are stored in a dynamic database and subject to ongoing validations therefore on a week to week basis the data may change."),
    p("On 30 October 2020, Public Health Scotland became aware of an ongoing issue when linking ICU data to laboratory data for COVID-19 test results. 
      Any COVID-19 positive patients with a missing a CHI number that had a first positive test in the community are unable to be linked to ICU data. 
      As a result, the COVID-19 positive ICU patients could be underreported by up to 10%. This is currently being investigated and figures may change in future reports."),
    actionButton("btn_dataset_modal", paste0("Data source: ", source), icon = icon('question-circle')),
    plot_box(paste0(total_title), paste0(data_name, "_overall")),
    plot_cut_missing(paste0(agesex_title), paste0(data_name, "_AgeSex")))
}

# Function to create the standard layout for all the different charts/sections
cut_charts_subheading <- function(title, source, data_name) {
  tagList(
    h3(title),
    p(subheading),
    actionButton("btn_dataset_modal", paste0("Data source: ", source), icon = icon('question-circle')),
    plot_box(paste0(total_title), paste0(data_name, "_overall")),
    plot_cut_box(paste0(agesex_title), paste0(data_name, "_AgeSex"),
                 paste0(simd_title), paste0(data_name, "_SIMD")))
}


# Set up Charts for each section ------------------------------------------

# Charts and rest of UI
if (input$measure_select == "LabCases") { #Positive Cases
  
  tagList(h3("Daily number of positive COVID-19 cases"),
          actionButton("btn_dataset_modal", paste0("Data source: ", "ECOSS"), icon = icon('question-circle')),
          plot_box("Daily number of Positive COVID-19 cases", plot_output = "LabCases_overall"),
          plot_box("Cumulative rate per 100,000", plot_output = "LabCasesRate"),
          plot_cut_box(paste0("Positive COVID-19 cases per 100,000 population by age \n(28 February to ", Labcases_date, ")"), "LabCases_AgeSex",
                       paste0("Positive COVID-19 cases by deprivation category (SIMD) \n(28 February to ", Labcases_date, ")"), "LabCases_SIMD"))
         
} else if (input$measure_select == "Admissions") { #Admissions
  cut_charts_subheading(title= "Daily number of COVID-19 admissions to hospital", 
                        source = data_source, data_name = "Admissions")
  
} else if (input$measure_select == "ICU") {# ICU 
  cut_charts_missing(title= "Daily number of COVID-19 admissions to ICU",
                     source = data_source, data_name ="ICU")
  
} else if (input$measure_select == "NHS24") {# NHS 24 contacts
  NHS_Inform_title <- paste0("NHS Inform hits to COVID-19 section (",start_date, " to ", end_date, ")" )
  SelfHelpTitle <- paste0("NHS24 COVID-19 self help guides completed (",start_date, " to ", end_date, ")" )
  OutcomesTitle <- paste0("NHS24 COVID-19 outcomes (",start_date, " to ", end_date, ")" )
  
  tagList(cut_charts_subheading(title = "Daily number of COVID-19 related NHS24 contacts", 
                                source = data_source, data_name ="NHS24"),
          h3("NHS Inform"),
          # actionButton("btn_dataset_inform", "Data source: INFORM", icon = icon('question-circle')),
          
          plot_box(NHS_Inform_title, "NHS24_inform"),
          plot_box(SelfHelpTitle, "NHS24_selfhelp"),
          plot_box(OutcomesTitle, "NHS24_community"))
  
} else if (input$measure_select == "AssessmentHub") { # Assessment Hub
  cut_charts_subheading(title= "Daily number of COVID-19 consultations", 
                        source = data_source, data_name = "AssessmentHub")
  
} else if (input$measure_select == "SAS") { # SAS data
  c(cut_charts_subheading(title= "Daily attended incidents by Scottish Ambulance Service (suspected COVID-19)", 
                          source = data_source, data_name ="SAS"),
    plot_box("SAS - all incidents", plot_output = "SAS_all"))
  
}  else if (input$measure_select == "Child") { # Child data
  tagList(h3("COVID-19 cases and testing among children and young people"),
          p("Please note due to the data being based on specimen date of the COVID-19 test the latest week is provisional and may be subject to change."),
          actionButton("btn_dataset_modal", paste0("Data source: ", "ECOSS"), icon = icon('question-circle')),
          plot_box("Number of positive COVID-19 tests in children and young people", plot_output = "ChildDataPositives"),
          plot_box("Number of negative COVID-19 tests in children and young people", "ChildDataNegatives"),
          plot_box("Percentage of children and young people testing positive for COVID-19", plot_output = "ChildDataCases"))
  
}  else if (input$measure_select == "Ethnicity_Chart") { # Ethnicity data
  tagList(h3("COVID-19 admissions to hospital by ethnicity"),
          p("COVID-19 related admissions have been identified as the following: A patient may have tested positive for COVID-19 14 days prior to admission to hospital, 
            on the day of their admission or during their stay in hospital."),
          p("Click on legend to select or deselect categories "),
          actionButton("btn_dataset_modal", paste0("Data source: ", "RAPID"), icon = icon('question-circle')),
          plot_box("COVID-19 admissions to hospital by ethnicity - Cases", plot_output = "EthnicityChart"),
          plot_box("COVID-19 admissions to hospital by ethnicity - Percentage", plot_output = "EthnicityChartPercentage"))
} 

}) 

###############################################.
## Charts ----

# Creating plots for each cut and dataset
# Trend Charts
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
output$ChildDataPositives <- renderPlotly({plot_overall_chartChild(Child, data_name = "Child", childdata = "ChildPositive")})
output$ChildDataNegatives <- renderPlotly({plot_overall_chartChild(Child, data_name = "Child", childdata = "ChildNegative")})
output$ChildDataCases <- renderPlotly({plot_overall_chartChild(Child, data_name = "Child", childdata = "ChildPer")})
output$LabCasesRate <- renderPlotly({plot_singlerate_chart(LabCases, data_name = "LabCases")})


output$EthnicityChart <- renderPlotly({plot_overall_chartEthnicity(Ethnicity_Chart, data_name = "Ethnicity_Chart")})
output$EthnicityChartPercentage <- renderPlotly({plot_overall_chartEthnicityPercent(Ethnicity_Chart, data_name = "Ethnicity_Chart")})
# output$ChildDataPositives <- renderPlotly({plot_overall_chartChildPositive(Child, data_name = "Child")})
# output$ChildDataNegatives <- renderPlotly({plot_overall_chartChildNegative(Child, data_name = "Child")})
# output$ChildDataCases <- renderPlotly({plot_overall_chartChildCases(Child, data_name = "Child")})

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
    "SAS" = SAS,
    "Child" = Child,
    "Ethnicity_Chart" = Ethnicity_Chart) #%>%
  #select(area_name, week_ending, count, starts_with("average")) %>%
  # mutate(week_ending = format(week_ending, "%d %b %y"))
})

output$download_chart_data <- downloadHandler(
  filename ="data_extract.csv",
  content = function(file) {
    write_csv(overall_data_download(),
              file) }
)
