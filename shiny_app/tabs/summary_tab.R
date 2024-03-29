## Data explorer selection ---

# This is a reactive which works out what tab the user is on and then takes the
# data choice from the selected button on that page

data_explorer_selection <- reactive({
  case_when(input$intabset == "SevereIllness" ~ input$measure_select_severe_illness,
            input$intabset == "InfCases" ~ input$measure_select_infcases,
            input$intabset == "SurveillanceArchive" ~ input$measure_select_surveillance_archive,
            TRUE ~ "LabCases")
  })


## Modals ----

#modal to describe dataset
# Link action button click to modal launch
observeEvent(input$btn_dataset_modal,

             if (data_explorer_selection() %in% c("LabCases", "LabCasesReinfections")) { # Positive Cases MODAL
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

             } else if (data_explorer_selection() == "Admissions") { #Admissions MODAL
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

             } else if (data_explorer_selection() == "ICU") { #ICU MODAL
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

             } else if (data_explorer_selection() == "NHS24") { #NHS24 MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("NHS24 Systems Applications and Products Business Warehouse",
                   p("In response to COVID-19, NHS 24 adapted their service provision. People who are concerned about COVID-19,
                     or who experience symptoms, are advised to seek advice from NHS Inform website, the COVID-19 advice helpline
                     or to contact NHS 24's 111 service if their symptoms worsen and they need clinical advice, following which they may be;"),
                   tags$li("provided with self-care advice or be asked to contact their own GP"),
                   tags$li("referred to a COVID-19 community hub for further clinical telephone triage, they may then be asked to attend assessment centre or receive a home visit by a Nurse or Doctor"),
                   tags$li("referred to acute services via the Scottish Ambulance Service or advised to attend hospital, depending on their symptoms."),
                   size = "m",
                   easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))

             } else if (data_explorer_selection() == "AssessmentHub") { #NHS24 MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("GP Out of Hours (OOH) ",
                   p("People may have multiple consultations with a COVID-19 Community Hub and Assessment Centre depending
                     on their pathway of care. For example, upon referral by NHS 24 (or other services) they will be
                     clinically triaged over the telephone by the community hub and they may then go on to have a
                     consultation in person at an assessment centre; this would result in one person having two consultations." ),
                   size = "m",
                   easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))

             } else if (data_explorer_selection() == "SAS") {
               #SAS MODAL
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
                   It is in the patients' best interest to get the care they require as close to their own home as is feasible."),
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)")))

             } else if (data_explorer_selection() == "Child") {
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("ECOSS (Electronic Communication of Surveillance in Scotland) Database",
                   p(""),
                   size = "m",
                   easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))

             } else if (data_explorer_selection() == "Ethnicity_Chart") {
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("RAPID (Rapid Preliminary Inpatient Data)"),
                 p("Extract Date: 11/02/2021"),
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
###############################################.
## Charts ----

# Creating plots for each cut and dataset
# Overall

# Creating list of reactiveValues to store the plots in so that they can be accessed when needed.
# Note that these CANNOT be stored as output$ instead, because they are used in a uiOutput in ui.R
# And it is bad practice to call output$ objects from within another output$. In this case it leads
# to mysterious rendering errors due to breaking the reactive dependency tree.
values <- reactiveValues()

values$LabCases_overall <- renderPlotly({plot_overall_chart(LabCases, data_name = "LabCases", include_vline=T)})
values$LabCasesReinfections_overall <- renderPlotly({plot_overall_chart(LabCasesReinfections, data_name = "LabCasesReinfections", include_vline=T)})
values$Admissions_overall <- renderPlotly({plot_overall_chart(Admissions, data_name = "Admissions", include_vline=T)})
values$ICU_overall <- renderPlotly({plot_overall_chart(ICU, data_name = "ICU")})
values$NHS24_overall <- renderPlotly({plot_overall_chartNHS24(NHS24, data_name = "NHS24")})
values$AssessmentHub_overall <- renderPlotly({plot_overall_chartAssessmentHub(AssessmentHub, data_name = "AssessmentHub")})
values$SAS_overall <- renderPlotly({plot_overall_chartSAS(SAS, data_name = "SAS")})

# Age/sex and SIMD charts
values$LabCases_AgeSex <- renderPlotly({plot_agesex_chart(LabCases_AgeSex, data_name = "LabCases_AgeSex")})
values$LabCases_SIMD <- renderPlotly({plot_simd_chart(LabCases_SIMD, data_name = "LabCases_SIMD")})
values$Admissions_AgeSex <- renderPlotly({plot_agesex_chart(Admissions_AgeSex, data_name = "Admissions_AgeSex")})
values$Admissions_SIMD <- renderPlotly({plot_simd_chart(Admissions_SIMD, data_name = "Admissions_SIMD")})
values$Admissions_SimdTrend <- renderPlotly({make_simd_trend_plot(data = Admissions_SimdTrend)})
values$ICU_AgeSex <- renderPlotly({plot_agesex_chart(ICU_AgeSex, data_name = "ICU_AgeSex")})
values$NHS24_AgeSex <- renderPlotly({plot_agesex_chart(NHS24_AgeSex, data_name = "NHS24_AgeSex")})
values$NHS24_SIMD <- renderPlotly({plot_simd_chart(NHS24_SIMD, data_name = "NHS24_SIMD")})
values$AssessmentHub_AgeSex <- renderPlotly({plot_agesex_chart(AssessmentHub_AgeSex, data_name = "AssessmentHub_AgeSex")})
values$AssessmentHub_SIMD <- renderPlotly({plot_simd_chart(AssessmentHub_SIMD, data_name = "AssessmentHub_SIMD")})
values$SAS_AgeSex <- renderPlotly({plot_agesex_chart(SAS_AgeSex, data_name = "SAS_AgeSex")})
values$SAS_SIMD <- renderPlotly({plot_simd_chart(SAS_SIMD, data_name = "SAS_SIMD")})

# Extra infections and cases charts
values$ReinfectionsBarchart <- renderPlotly({plot_reinfections_barchart(LabCases, LabCasesReinfections)})
values$labcases_age_groups <- renderPlotly({cases_age_chart_3_week(LabCases_Age, data_name = "LabCases_Age", type="cases")})

# Extra severe illness charts
values$admissions_age_groups <- renderPlotly({cases_age_chart_3_week(Admissions_AgeGrp, data_name = "Admissions_AgeGrp", type = "admissions")})
values$EthnicityChart <- renderPlotly({plot_overall_chartEthnicity(Ethnicity_Chart, data_name = "Ethnicity_Chart")})
values$EthnicityChartPercentage <- renderPlotly({plot_overall_chartEthnicityPercent(Ethnicity_Chart, data_name = "Ethnicity_Chart")})
values$LOSChart <- renderPlotly({los_chart_fn(LOS_Data)})

# Extra surveillance charts
values$NHS24_inform <- renderPlotly({plot_singletrace_chart(NHS24_inform, data_name = "NHS24_inform")})
values$NHS24_selfhelp <- renderPlotly({plot_nhs24_selfhelp_chart(NHS24_selfhelp, data_name = "NHS24_selfhelp")})
values$NHS24_community <- renderPlotly({plot_nhs24_community_chart(NHS24_community, data_name = "NHS24_community")})
values$SAS_all <- renderPlotly({plot_singletrace_chart(SAS_all, data_name = "SAS_all")})
values$LabCasesRate <- renderPlotly({plot_singlerate_chart(LabCases, data_name = "LabCases", include_vline=T)})
values$LabCasesReinfectionsRate <- renderPlotly({plot_singlerate_chart(LabCasesReinfections, data_name = "LabCasesReinfections", include_vline=T)})


## Data downloads ----

# For the charts at the moment the data download is for the overall one,
# need to think how to allow downloading for each chart
# Reactive dataset that gets the data the user is visualisaing ready to download
overall_data_download <- reactive({
  switch(
    data_explorer_selection(),
    "LabCases" = LabCases,
    "LabCasesReinfections" = LabCasesReinfections,
    "Admissions" = Admissions,
    "ICU" = ICU,
    "NHS24" = NHS24,
    "AssessmentHub" = AssessmentHub,
    "SAS" = SAS,
    "Ethnicity_Chart" = Ethnicity_Chart) #%>%
  #select(area_name, week_ending, count, starts_with("average")) %>%
  # mutate(week_ending = format(week_ending, "%d %b %y"))
})

# Note that we have to pass the downloadHandler through to multiple different objects
# because we can't repeat the same object in shiny ui as this will lead to
# corrupted HTML
output$download_infcases_data <- output$download_severe_illness_data <- output$download_surveillance_data <- output$download_surveillance_archive_data <- downloadHandler(
  filename ="data_extract.csv",
  content = function(file) {
    write_csv(overall_data_download(),
              file) }
)


## Reactive Charts  ----
# The charts and text shown on the app will depend on what the user wants to see
# Note that we have to pass the renderUI through to multiple different objects
# because we can't repeat the same object in shiny ui as this will lead to
# corrupted HTML

ui_content <-  reactive({

  # text for titles of cut charts
  datasettrend <- case_when(data_explorer_selection() == "LabCases" ~ "Positive COVID-19 cases",
                            data_explorer_selection() == "LabCasesReinfections" ~ "COVID-19 Reinfections",
                            data_explorer_selection() == "Admissions" ~ "COVID-19 hospital admissions",
                            data_explorer_selection() == "ICU" ~ "COVID-19 admissions to ICU",
                            data_explorer_selection() == "NHS24" ~ "NHS 24 111 COVID-19 Contacts and COVID-19 Advice Helpline calls",
                            data_explorer_selection() == "AssessmentHub" ~ "Consultations",
                            data_explorer_selection() == "SAS" ~ "SAS incidents (suspected COVID-19)")

  # text for titles of cut charts
  dataset <- case_when(data_explorer_selection() == "LabCases" ~ "Positive COVID-19 cases",
                       data_explorer_selection() == "LabCasesReinfections" ~ "COVID-19 Reinfections",
                       data_explorer_selection() == "Admissions" ~ "COVID-19 hospital admissions",
                       data_explorer_selection() == "ICU" ~ "COVID-19 admissions to ICU",
                       data_explorer_selection() == "NHS24" ~ "COVID-19 related NHS24 contacts",
                       data_explorer_selection() == "AssessmentHub" ~ "Individuals",
                       data_explorer_selection() == "SAS" ~ "SAS incidents (suspected COVID-19)")

  start_date <- case_when(data_explorer_selection() == "LabCases" ~ "28 February 2020",
                          data_explorer_selection() == "LabCasesReinfections" ~ "28 February 2020",
                          data_explorer_selection() == "Admissions" ~ "1 March 2020",
                          data_explorer_selection() == "ICU" ~ "11 March 2020",
                          data_explorer_selection() == "NHS24" ~ "13 February 2020",
                          data_explorer_selection() == "AssessmentHub" ~ "23 March 2020",
                          data_explorer_selection() == "SAS" ~ "22 January 2020")

  end_date <- case_when(data_explorer_selection() == "LabCases" ~ Labcases_date,
                        data_explorer_selection() == "LabCasesReinfections" ~ Labcases_date,
                        data_explorer_selection() == "Admissions" ~ Admissions_date,
                        data_explorer_selection() == "ICU" ~ ICU_date,
                        data_explorer_selection() == "NHS24" ~ NHS24_date,
                        data_explorer_selection() == "AssessmentHub" ~ AssessmentHub_date,
                        data_explorer_selection() == "SAS" ~ SAS_date)

  total_title <- glue("Daily number of {datasettrend}")
  agesex_title <- paste0(dataset, " per 100,000 population by age \n(", start_date, " to ", end_date, ")")
  simd_title <- paste0(dataset, " by deprivation category (SIMD) \n(", start_date, " to ", end_date, ")")

  subheading <- case_when(#data_explorer_selection() == "Admissions" ~ "These admissions are identified from Rapid and Preliminary Inpatient Data (RAPID) and defined as the following: A positive PCR or LFD test of the episode of infection (including reinfections at 90 days or more after their last positive test) for COVID-19 up to 14 days prior to admission to hospital, on the day of their admission or during their stay in hospital. If a patient's first positive PCR or LFD test of the episode of infection is after their date of discharge from hospital, they are not included in the analysis.",
                          #data_explorer_selection() == "NHS24" ~ paste0("The launch of the Redesign of Urgent Care programme will see an increase in NHS 24 activity from the 1st December 2020 onwards as a result of the launch of the programme. For more information see: https://www.gov.scot/policies/healthcare-standards/unscheduled-care/
                          #                   Since 15th September 2020, figures for the COVID helpline include calls made to the new flu helpline.
                          #                   In late September, the first batch of flu vaccination letters sent to those eligible by NHS Health Boards included the coronavirus number.
                           #                  The peaks in calls are consistent with the timing of those letters being sent."),
                         # data_explorer_selection() == "AssessmentHub" ~  paste0("Please note that data are provisional and may be updated in future publications as further information is supplied and validated from health boards."),
                         # data_explorer_selection() == "SAS" ~ paste0(""),
                          TRUE ~ paste0(""))

  notes <- case_when(#data_explorer_selection() %in% c("NHS24", "AssessmentHub")~ paste0("As of the 31st of March 2022 the COVID-19 Community Pathway will be closed. From this date patients who contact NHS24 with COVID-19 symptoms during the in-hours period will be advised to contact their own GP practice.",
                  # " For the out of hours period, the Out of Hours services will continue to manage COVID-19 patients directed by NHS 24 as a matter of course. This will have an impact on the NHS 24 data and COVID Hub/Assessment data contained in the dashboard."),
                   TRUE ~ paste0(""))

  # data sources
  data_source <- case_when(data_explorer_selection() == "LabCases" ~ "ECOSS",
                           data_explorer_selection() == "LabCasesReinfections" ~ "ECOSS",
                           data_explorer_selection() == "Admissions" ~ "ECOSS/RAPID",
                           data_explorer_selection() == "ICU" ~ "SICSAG",
                           data_explorer_selection() == "NHS24" ~ "NHS 24 SAP BW",
                           data_explorer_selection() == "AssessmentHub" ~ "GP Out of Hours (OOH)",
                           data_explorer_selection() == "SAS"~ "SAS and Unscheduled Care Datamart")

# Set up Charts for each section ------------------------------------------

# Charts and rest of UI
if (data_explorer_selection() == "LabCases") { #Positive Cases

  tagList(h3("Daily number of positive COVID-19 cases"),
          # p("On 05 January 2022, the Scottish Government",
          #   tags$a(href= "https://www.gov.scot/news/self-isolation-and-testing-changes/",
          #          "announced",
          #          class = "externallink"),
          #   "that asymptomatic people who return a positive lateral flow device (LFD) no longer have to confirm their positive result with a PCR test."),
          # p(strong(style="color:black", "From 01 March 2022, PHS now include episodes of reinfection within COVID-19 reporting.
          #           Prior to this date COVID-19 cases were based on an individual’s first positive test result only.
          #           The new daily calculation includes both new infections and possible reinfections.
          #           Possible reinfections are defined as individuals who test positive, by PCR (polymerase chain reaction) or LFD (lateral flow device), 90 days or more after their last positive test.",
          #          "More information available on the Public Health Scotland website",
          #   tags$a(href="https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/",
          #          "here.", class="externallink"))),
          actionButton("btn_dataset_modal", paste0("Data source: ", "ECOSS"), icon = icon('question-circle')),
          actionButton("btn_modal_simd", "What is SIMD?", icon = icon('question-circle')),
          plot_box_values("Daily number of Positive COVID-19 cases", valuename = "LabCases_overall"),
          plot_box_values("Cumulative rate per 100,000", valuename = "LabCasesRate"),
          plot_box_values("Weekly COVID-19 cases by age group",
                   valuename="labcases_age_groups"),
          plot_cut_box_values(paste0("Positive COVID-19 cases per 100,000 population by age \n(28 February 2020 to ", Labcases_date, ")"), "LabCases_AgeSex",
                       paste0("Positive COVID-19 cases by deprivation category (SIMD) \n(28 February 2020 to ", Labcases_date, ")"), "LabCases_SIMD"))

}else if (data_explorer_selection() == "LabCasesReinfections"){ #Reinfections
  tagList(h3("Daily number of COVID-19 reinfections"),
          # p("On 05 January 2022, the Scottish Government",
          #   tags$a(href= "https://www.gov.scot/news/self-isolation-and-testing-changes/",
          #          "announced",
          #          class = "externallink"),
          #   "that asymptomatic people who return a positive lateral flow device (LFD) no longer have to confirm their positive result with a PCR test."),
          # p(strong(style="color:black", "From 01 March 2022, PHS now include episodes of reinfection within COVID-19 reporting.
          #           Prior to this date COVID-19 cases were based on an individual’s first positive test result only.
          #           The new daily calculation includes both new infections and possible reinfections.
          #           Possible reinfections are defined as individuals who test positive, by PCR (polymerase chain reaction) or LFD (lateral flow device), 90 days or more after their last positive test.",
          #          "More information available on the Public Health Scotland website",
          #          tags$a(href="https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/",
          #                 "here.", class="externallink"))),
          actionButton("btn_dataset_modal", paste0("Data source: ", "ECOSS"), icon = icon('question-circle')),
          actionButton("btn_modal_simd", "What is SIMD?", icon = icon('question-circle')),
          plot_box_values("Daily number of COVID-19 reinfections", valuename = "LabCasesReinfections_overall"),
          plot_box_values("Cumulative rate per 100,000", valuename = "LabCasesReinfectionsRate"),
          plot_box_values("Percentage of cases that are reinfections", valuename = "ReinfectionsBarchart"))

  }else if (data_explorer_selection() == "Admissions") { #Admissions
  tagList(actionButton("btn_modal_simd", "What is SIMD?", icon = icon('question-circle')),
          br(),
          # p("On 05 January 2022, the Scottish Government",
          #   tags$a(href= "https://www.gov.scot/news/self-isolation-and-testing-changes/",
          #          "announced",
          #          class = "externallink"),
          #   "that asymptomatic people who return a positive lateral flow device (LFD) no longer have to confirm their positive result with a PCR test."),
          # p(strong(style="color:black", "From 01 March 2022, PHS now include episodes of reinfection within COVID-19 reporting.
          #                 Prior to this date COVID-19 cases were based on an individual’s first positive test result only.
          #                 The new daily calculation includes both new infections and possible reinfections.
          #                 Possible reinfections are defined as individuals who test positive, by PCR (polymerase chain reaction) or LFD (lateral flow device), 90 days or more after their last positive test.",
          #          "More information available on the Public Health Scotland website",
          #          tags$a(href="https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/",
          #                 "here.", class="externallink"))),
    cut_charts_subheading(title = "Daily number of COVID-19 hospital admissions",
                        source = data_source, data_name = "Admissions",
                        notes = notes,
                        subheading = subheading,
                        total_title = total_title,
                        agesex_title = agesex_title,
                        simd_title = simd_title),

    h3("Trend of COVID-19 hospital admissions by deprivation category (SIMD)"),
    fluidRow(
             plot_box_values("", "Admissions_SimdTrend")
    ),

     h3("Length of stay of acute COVID-19 hospital admissions"),
    p("Use the drop-down menu to select an age group of interest."),
    p("Please note that in cases where there are no hospital admissions, there will be a gap in the chart."),
    fluidRow(
      column(3,
             selectInput("los_age",
                         label = "Select Age Group",
                         choices = unique(LOS_Data$`Age Group`),
                         selected = "All Ages") %>%
               config(displaylogo = F,
                      displayModeBar = TRUE,
                      modeBarButtonsToRemove = bttn_remove )),
      column(9,
             plot_box_values("", "LOSChart")
             )

      ),

  plot_box_values("Weekly cases admitted to hospital within 14 days of a first positive test, by age group",
           valuename="admissions_age_groups")
)

} else if (data_explorer_selection() == "ICU") {# ICU
  cut_charts_missing(title = "Daily number of COVID-19 admissions to ICU",
                     source = data_source, data_name ="ICU",
                     agesex_title = agesex_title,
                     total_title = total_title)

} else if (data_explorer_selection() == "NHS24") {# NHS 24 contacts
  NHS_Inform_title <- paste0("NHS Inform hits to COVID-19 section (",start_date, " to ", end_date, ")" )
  SelfHelpTitle <- paste0("NHS24 COVID-19 self help guides completed (",start_date, " to ", end_date, ")" )
  OutcomesTitle <- paste0("NHS24 COVID-19 outcomes (",start_date, " to ", end_date, ")" )

  tagList(actionButton("btn_modal_simd", "What is SIMD?", icon = icon('question-circle')),
          cut_charts_subheading(title = "Daily number of COVID-19 related NHS24 contacts",
                                subheading = subheading,
                                notes = notes,
                                source = data_source,
                                total_title = total_title,
                                data_name ="NHS24",
                                agesex_title = agesex_title,
                                simd_title = simd_title),
          p(strong("As of the 31st of March 2022 the COVID-19 Community Pathway will be closed. From this date patients who contact NHS24 with COVID-19 symptoms during the in-hours period will be advised to contact their own GP practice.",
                   "For the out of hours period, the Out of Hours services will continue to manage COVID-19 patients directed by NHS 24 as a matter of course. This will have an impact on the NHS 24 data and COVID Hub/Assessment data contained in the dashboard.")),
          h3("NHS Inform"),
          # actionButton("btn_dataset_inform", "Data source: INFORM", icon = icon('question-circle')),

          plot_box_values(NHS_Inform_title, "NHS24_inform"),
          plot_box_values(SelfHelpTitle, "NHS24_selfhelp"),
          plot_box_values(OutcomesTitle, "NHS24_community"))

} else if (data_explorer_selection() == "AssessmentHub") { # Assessment Hub
 tagList( actionButton("btn_modal_simd", "What is SIMD?", icon = icon('question-circle')),
  cut_charts_subheading(title= "Daily number of COVID-19 consultations",
                        source = data_source, data_name = "AssessmentHub",
                        notes = notes,
                        subheading = subheading,
                        total_title = total_title,
                        agesex_title = agesex_title,
                        simd_title = simd_title
                        ))

} else if (data_explorer_selection() == "SAS") { # SAS data
  tagList(h3("Scottish Ambulance Service"),
    p("SAS currently publish weekly unscheduled care operational statistics at the following location:",
    tags$a(
      href = "https://www.scottishambulance.com/publications/unscheduled-care-operational-statistics/",
      "(Unscheduled Care Operational Statistics).",
      class = "externallink"),
    "This details unscheduled care demand, response times and turnaround times."),
  # p("Please note that the data published by SAS are sourced from a different operational ",
  #   "system than that used for the PHS reporting. This means that the data published by SAS will at times ",
  #   " be slightly different to those reported by PHS source. The data published by PHS are less timely than the ",
  #   "data used for the SAS publication, however the PHS data here can be linked in order to gain further insight ",
  #   "into patient flow through unscheduled care."
  #),
  actionButton("btn_modal_simd", "What is SIMD?", icon = icon('question-circle')),
    cut_charts_subheading(title= "Daily attended incidents by Scottish Ambulance Service (suspected COVID-19)",
                          source = data_source, data_name ="SAS",
                          notes = notes,
                          subheading = subheading,
                          total_title = total_title,
                          agesex_title = agesex_title,
                          simd_title = simd_title),
    plot_box_values("SAS - all incidents", valuename = "SAS_all"))
}  else if (data_explorer_selection() == "Ethnicity_Chart") { # Ethnicity data
  tagList(h3("Admissions to hospital 'with' COVID-19 by ethnicity"),
          # p("COVID-19 related admissions have been identified as the following: A patient may have tested positive for COVID-19 14 days prior to admission to hospital,
          #   on the day of their admission or during their stay in hospital."),
          # p("Please note that the data on hospital admissions by ethnicity only refers to laboratory confirmed (PCR) COVID-19 tests."),
          p("These data will next be updated in March 2023."),
          p("Click on legend to select or deselect categories: "),
          tags$li("Single click on an item in the legend to remove it from the plot"),
          tags$li("Double click on an item in the legend to view only that line"),
          actionButton("btn_dataset_modal", paste0("Data source: ", "RAPID"), icon = icon('question-circle')),
          plot_box_values("Admissions to hospital 'with' COVID-19 by ethnicity - Cases", valuename = "EthnicityChart"),
          plot_box_values("Admissions to hospital 'with' COVID-19 by ethnicity - Percentage", valuename = "EthnicityChartPercentage"))
}

})

output$data_explorer_severe_illness <- renderUI({ui_content()})
output$data_explorer_infcases <-  renderUI({ui_content()})
output$data_explorer_surveillance <- renderUI({ui_content()})
output$data_explorer_surveillance_archive <- renderUI({ui_content()})

