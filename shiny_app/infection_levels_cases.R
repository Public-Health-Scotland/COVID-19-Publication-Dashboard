###### Infection levels and cases


## Modals ----

#modal to describe dataset
# Link action button click to modal launch
observeEvent(input$btn_dataset_modal,

             if (input$measure_select %in% c("LabCases", "LabCasesReinfections")) { # Positive Cases MODAL
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

             } )

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
                            input$measure_select == "LabCasesReinfections" ~ "COVID-19 Reinfections")

  # text for titles of cut charts
  dataset <- case_when(input$measure_select == "LabCases" ~ "Positive COVID-19 cases",
                       input$measure_select == "LabCasesReinfections" ~ "COVID-19 Reinfections")

  start_date <- case_when(input$measure_select == "LabCases" ~ "28 February 2020",
                          input$measure_select == "LabCasesReinfections" ~ "28 February 2020")

  end_date <- case_when(input$measure_select == "LabCases" ~ Labcases_date,
                        input$measure_select == "LabCasesReinfections" ~ Labcases_date)

  total_title <- glue("Daily number of {datasettrend}")
  agesex_title <- paste0(dataset, " per 100,000 population by age \n(", start_date, " to ", end_date, ")")
  simd_title <- paste0(dataset, " by deprivation category (SIMD) \n(", start_date, " to ", end_date, ")")

  subheading <- paste0("")
  notes <- paste0("")

  # data sources
  data_source <- case_when(input$measure_select == "LabCases" ~ "ECOSS",
                           input$measure_select == "LabCasesReinfections" ~ "ECOSS")


  # Set up Charts for each section ------------------------------------------

  # Charts and rest of UI
  if (input$measure_select == "LabCases") { #Positive Cases

    tagList(h3("Daily number of positive COVID-19 cases"),
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
            actionButton("btn_dataset_modal", paste0("Data source: ", "ECOSS"), icon = icon('question-circle')),
            actionButton("btn_modal_simd", "What is SIMD?", icon = icon('question-circle')),
            plot_box("Daily number of Positive COVID-19 cases", plot_output = "LabCases_overall"),
            plot_box("Cumulative rate per 100,000", plot_output = "LabCasesRate"),
            plot_box("Weekly COVID-19 cases by age group",
                     plot_output="labcases_age_groups"),
            plot_cut_box(paste0("Positive COVID-19 cases per 100,000 population by age \n(28 February 2020 to ", Labcases_date, ")"), "LabCases_AgeSex",
                         paste0("Positive COVID-19 cases by deprivation category (SIMD) \n(28 February 2020 to ", Labcases_date, ")"), "LabCases_SIMD"))

  }else if (input$measure_select == "LabCasesReinfections"){ #Reinfections
    tagList(h3("Daily number of COVID-19 reinfections"),
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
            actionButton("btn_dataset_modal", paste0("Data source: ", "ECOSS"), icon = icon('question-circle')),
            actionButton("btn_modal_simd", "What is SIMD?", icon = icon('question-circle')),
            plot_box("Daily number of COVID-19 reinfections", plot_output = "LabCasesReinfections_overall"),
            plot_box("Cumulative rate per 100,000", plot_output = "LabCasesReinfectionsRate"),
            plot_box("Percentage of cases that are reinfections", plot_output = "ReinfectionsBarchart"))

  }

})

###############################################.
## Charts ----

# Creating plots for each cut and dataset
# Trend Charts
output$LabCases_overall <- renderPlotly({plot_overall_chart(LabCases, data_name = "LabCases", include_vline=T)})
output$LabCasesReinfections_overall <- renderPlotly({plot_overall_chart(LabCasesReinfections, data_name = "LabCasesReinfections", include_vline=T)})
output$labcases_age_groups <- renderPlotly({cases_age_chart_3_week(LabCases_Age, data_name = "LabCases_Age")})

#age/sex and SIMD charts
output$LabCases_AgeSex <- renderPlotly({plot_agesex_chart(LabCases_AgeSex, data_name = "LabCases_AgeSex")})
output$LabCases_SIMD <- renderPlotly({plot_simd_chart(LabCases_SIMD, data_name = "LabCases_SIMD")})
output$LabCasesRate <- renderPlotly({plot_singlerate_chart(LabCases, data_name = "LabCases", include_vline=T)})
output$LabCasesReinfectionsRate <- renderPlotly({plot_singlerate_chart(LabCasesReinfections, data_name = "LabCasesReinfections", include_vline=T)})

# Reinfections bar chart
output$ReinfectionsBarchart <- renderPlotly({plot_reinfections_barchart(LabCases, LabCasesReinfections)})

## Data downloads ----


# For the charts at the moment the data download is for the overall one,
# need to think how to allow downloading for each chart
# Reactive dataset that gets the data the user is visualisaing ready to download
overall_data_download <- reactive({
  switch(
    input$measure_select,
    "LabCases" = LabCases,
    "LabCasesReinfections" = LabCasesReinfections
  )
})

output$download_infcases_data <- downloadHandler(
  filename ="data_extract.csv",
  content = function(file) {
    write_csv(overall_data_download(),
              file) }
)
