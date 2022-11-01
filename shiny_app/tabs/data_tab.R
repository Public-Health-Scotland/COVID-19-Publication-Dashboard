
## Reactive data ----

# This is a reactive which works out what tab the user is on and then takes the
# data choice from the selected button on that page

data_select_combined <- reactive({
  case_when(input$intabset == "SevereIllnessData" ~ input$data_select_severe_illness,
            input$intabset == "InfCasesData" ~ input$data_select_infcases,
            input$intabset == "SurveillanceArchive" ~ input$data_select_surveillance_archive,
            TRUE ~ "LabCases")
})


##reactive data to show in app

data_table <- reactive({  # Change dataset depending on what user selected



  table_data <- switch(data_select_combined(),

                       "LabCases" = LabCases %>%  dplyr::rename (`Number of Cases` = Count,

                                                                 `Cumulative Cases` = Cumulative,

                                                                 `7 day average` = Average7,

                                                                 `Cumulative Rate per 100,000` = CumulativeRatePer100000),


                       "LabCasesReinfections" = LabCasesReinfections %>%  dplyr::rename (`Number of Reinfections` = Count,

                                                                 `Cumulative Reinfections` = Cumulative,

                                                                 `7 day average` = Average7,

                                                                 `Cumulative Rate per 100,000` = CumulativeRatePer100000),


                       "LabCases_AgeSex" = LabCases_AgeSex %>%  dplyr::rename(Sex = sex,

                                                                       `Age Group` = `age_group`,

                                                                       `Number of Cases` = number,

                                                                       `Rate per 100,000 population` = rate),

                       "LabCases_SIMD" = LabCases_SIMD %>% dplyr::rename(`Number of Cases` = cases,
                                                                  Percent = cases_pc),


                       "LabCases_Age_All" = LabCases_Age_All,


                       "Admissions" = Admissions %>%  dplyr::rename (`Number of Admissions` = Count,

                                                                     `7 day average` = Average7),

                       "Admissions_AgeSex" = Admissions_AgeSex %>%  dplyr::rename(Sex = sex,

                                                                                  `Age Group` = `age_group`,

                                                                                  `Number of Cases` = number,

                                                                                  `Rate per 100,000 population` = rate),

                       "Admissions_SIMD" = Admissions_SIMD %>% dplyr::rename(`Number of Cases` = cases,

                                                                             Percent = cases_pc),

                       "Admissions_AgeBD" = Admissions_AgeBD,
                       "Cases_Adm" = Cases_Adm %>% dplyr::rename('Week ending'= 'date',
                                                                 'Percentage of weekly cases'='count'),

                       "LOS_Data" = LOS_Data %>% dplyr::mutate(prop = prop*100) %>%
                         dplyr::select(`Week Ending`,
                                       `Age Group`,
                                       `Length of Stay`,
                                       "Percentage of Age Group"=prop),


                       "Ethnicity" = Ethnicity,

                       "ICU" = ICU %>%  dplyr::rename(`Number of ICU Admissions` = Count,

                                                      `7 day average` = Average7),

                       "ICU_AgeSex" = ICU_AgeSex %>%  dplyr::rename(Sex = sex,

                                                                    `Age Group` = `age_group`,

                                                                    `Number of ICU Admissions` = number,

                                                                    `Rate per 100,000 population` = rate),

                       "NHS24" = NHS24 %>%

                         dplyr::rename(`Number of NHS24 Calls` = Count,

                                       `Number of Corona Virus Helpline Calls` = CoronavirusHelpline),

                       "NHS24_AgeSex" = NHS24_AgeSex %>%  dplyr::rename(Sex = sex,

                                                                        `Age Group` = `age_group`,

                                                                        `Number of Contacts` = number,

                                                                        `Rate per 100,000 population` = rate),

                       "NHS24_SIMD" = NHS24_SIMD %>% dplyr::rename (`Number of Contacts` = cases,

                                                                    Percent = cases_pc),

                       "NHS24_inform" = NHS24_inform %>% dplyr::rename(`Hits to COVID-19 section of NHS Inform` = count,

                                                                       Date = date),

                       "NHS24_selfhelp" = NHS24_selfhelp %>%

                         dplyr::rename(`Self Help guides completed` = selfhelp,

                                       `Advised to self isolate` = isolate),

                       "NHS24_community" = NHS24_community %>%

                         dplyr::rename(Date = date,

                                       `Community Hub Outcome` = outcome,

                                       `Number of Contacts` = count),

                       "AssessmentHub" = AssessmentHub %>%

                         dplyr::rename(`COVID-19 Advice` = CountAdvice,

                                       `COVID-19 Assessments` = CountAssessment,

                                       `Other` = CountOther),

                       "AssessmentHub_AgeSex" = AssessmentHub_AgeSex %>%  dplyr::rename(Sex = sex,

                                                                                        `Age Group` = `age_group`,

                                                                                        `Number of Cases` = number,

                                                                                        `Rate per 100,000 population` = rate),

                       "AssessmentHub_SIMD" = AssessmentHub_SIMD %>% dplyr::rename(`Number of Cases` = cases,

                                                                                   Percent = cases_pc),

                       "SAS" = SAS,

                       "SAS_AgeSex" = SAS_AgeSex %>%  dplyr::rename(Sex = sex,

                                                                    `Age Group` = `age_group`,

                                                                    `Number of Cases` = number,

                                                                    `Rate per 100,000 population` = rate),

                       "SAS_SIMD" = SAS_SIMD %>% dplyr::rename(`Number of Cases` = cases,

                                                               Percent = cases_pc),

                       "SAS_all" = SAS_all %>% dplyr::rename(Date = date,

                                                             `Total SAS Incidents` = count),

                       "ChildCases" = ChildCases,

                       "ChildTests" = ChildTests)



  if (data_select_combined() %in% c("LabData")) {

    table_data <- table_data %>%

      select(Date, `Number of Daily Cases`, Cumulative, `Cumulative Rate per 100,000`) %>%

      mutate(Date = format(Date, "%d %B %y"))



  } else if (data_select_combined() %in% "Admissions") {

    table_data <- table_data %>%

      select(Date, `Number of Admissions`, `7 day average`)



  } else if (data_select_combined() %in% "ICU") {

    table_data <- table_data %>%

      select(Date, `Number of ICU Admissions`, `7 day average`)



  } else if (data_select_combined() %in% "NHS24") {

    table_data <- table_data #%>%

    #select(Date, `Number of Admissions`)



  } else if (data_select_combined() %in% "AssessmentHub") {

    table_data <- table_data #%>%

    # select(Date, `Number of Admissions`)



  } else if (data_select_combined() %in% "SAS") {

    table_data <- table_data #%>%

    #  select(Date, `Number of Admissions`)

  } else if (data_select_combined() %in% "Ethnicity") {

    table_data <- table_data #%>%

    #  select(Date, `Number of Admissions`)

  }



  table_data %>%

    mutate_if(is.numeric, round, 1) %>%

    mutate_if(is.character, as.factor)

})



###############################################.

## Table ----



ui_content_data <- reactive({

  DT::renderDataTable({

    datatab_table(data_table(),
                  add_separator_cols = table_params_data()$separator_cols,
                  add_separator_cols_1dp = table_params_data()$separator_cols_1dp,
                  add_percentage_cols = table_params_data()$percentage_cols,
                  maxrows = table_params_data()$maxrows,
                  order_by_firstcol = table_params_data()$order_by_firstcol
    ) # from functions_tables.R

})

})


output$infcases_table <- renderUI({ui_content_data()})
output$severe_illness_table <- renderUI({ui_content_data()})
output$surveillance_table <- renderUI({ui_content_data()})
output$surveillance_archive_table <- renderUI({ui_content_data()})


table_params_data <- reactive({

  # Columns to add 1,000 comma separator to for each table
  separator_cols = switch(data_select_combined(),
                           "LabCases" = c(2,3),
                           "LabCasesReinfections" = c(2,3),
                           "LabCases_AgeSex" = c(3),
                           "LabCases_SIMD" = c(2),
                           "LabCases_Age_All" = c(3),
                           "Admissions" = c(2),
                           "Admissions_AgeSex" = c(3),
                           "Admissions_SIMD" = c(2),
                           "Admissions_AgeBD" = c(2:13),
                           "Ethnicity" = c(3),
                           "ICU_AgeSex" = c(3),
                           "NHS24" = c(2,3),
                           "NHS24_AgeSex" = c(3),
                           "NHS24_SIMD" = c(2),
                           "NHS24_inform" = c(2),
                           "NHS24_selfhelp" = c(2,3),
                           "NHS24_community" = c(3),
                           "AssessmentHub" = c(2:5),
                           "AssessmentHub_AgeSex" = c(3),
                           "AssessmentHub_SIMD" = c(2),
                           "SAS" = c(2:4),
                           "SAS_AgeSex" = c(3),
                           "SAS_SIMD" = c(2),
                           "SAS_all" = c(2),
                           c() # default
  )

  # Columns to add 1,000 comma separator with 1dp to for each table
  separator_cols_1dp = switch(data_select_combined(),
                               "LabCases" = c(4,5),
                               "LabCasesReinfections" = c(4,5),
                               "LabCases_AgeSex" = c(4),
                               "Admissions" = c(3),
                               "Admissions_AgeSex" = c(4),
                               "ICU" = c(3),
                               "ICU_AgeSex" = c(4),
                               "NHS24_AgeSex" = c(4),
                               "AssessmentHub_AgeSex" = c(4),
                               "AssessmentHub_SIMD" = c(2),
                               "SAS_AgeSex" = c(4),
                               "SAS_SIMD" = c(2),
                               c() #default
  )

  # Columns to add percentage formatting to for each table
  percentage_cols = switch(data_select_combined(),

                            "LabCases_SIMD" = c(3),
                            "Cases_Adm" = c(2),
                            "Admissions_SIMD" = c(3),
                            "Ethnicity" = c(4),
                            "NHS24_SIMD" = c(3),
                            "AssessmentHub_SIMD" = c(3),
                            "SAS_SIMD" = c(3),
                            "LOS_Data" = c(4),
                            c() # default
  )

  maxrows = switch(data_select_combined(),

                    "LabCases_AgeSex" = 44,
                    "LabCases_Age_All" = 10,
                    "Admissions_AgeSex" = 30,
                    "Ethnicity" = 7,
                    "NHS24_community" = 6,
                    "ICU_AgeSex" = 18,
                    "NHS24_AgeSex" = 32,
                    "AssessmentHub_AgeSex" = 32,
                    "SAS_AgeSex" = 36,
                    "LOS_Data" = 36,
                    14 #default

  )

  order_by_firstcol = switch(data_select_combined(),
                             "LabCases_AgeSex" = NULL,
                             "LabCases_SIMD" = NULL,
                             "Admissions_AgeSex" = NULL,
                             "Admissions_SIMD" = NULL,
                             "ICU" = "desc",
                             "ICU_AgeSex" = "asc",
                             "NHS24_AgeSex" = "asc",
                             "NHS24_SIMD" = "asc",
                             "SAS_AgeSex" = "asc",
                             "SAS_SIMD" = "asc",
                             "desc")

  list("separator_cols" = separator_cols,
       "separator_cols_1dp" = separator_cols_1dp,
       "percentage_cols" = percentage_cols,
       "maxrows" = maxrows,
       "order_by_firstcol" = order_by_firstcol)


})



###############################################.

## Data downloads ----



# Data download of data table.

output$download_infcases_table_csv <- output$download_severe_illness_table_csv <- output$download_surveillance_table_csv <- output$download_surveillance_archive_table_csv <- downloadHandler(

  filename ="data_extract.csv",

  content = function(file) {

    # This downloads only the data the user has selected using the table filters

    write_csv(data_table()[input[["table_filtered_rows_all"]], ], file)

  }

)

