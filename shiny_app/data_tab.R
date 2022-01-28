
## Reactive data ----



##reactive data to show in app

data_table <- reactive({  # Change dataset depending on what user selected



  table_data <- switch(input$data_select,

                       "LabCases" = LabCases %>%  dplyr::rename (`Number of Cases` = Count,

                                                                 `Cumulative Cases` = Cumulative,

                                                                 `7 day average` = Average7,

                                                                 `Cumulative Rate per 100,000` = CumulativeRatePer100000),

                       "LabCases_AgeSex" = LabCases_AgeSex %>%  dplyr::rename(Sex = sex,
                                                                       
                                                                       `Age Group` = `age_group`,
                                                                       
                                                                       `Number of Cases` = number,
                                                                       
                                                                       `Rate per 100,000 population` = rate),
                       
                       "LabCases_SIMD" = LabCases_SIMD %>% mutate(cases_pc = cases_pc/100) %>% 
                                                           dplyr::rename(`Number of Cases` = cases,
                                                                  Percent = cases_pc),
                                                                  

                       "Cases_AgeGrp" = Cases_AgeGrp %>% dplyr::rename('Week ending' = 'Date',
                                                                       'Percentage of weekly cases' = 'Percent'),

                       "Prop_Adm_AgeGrp" = Prop_Adm_AgeGrp,

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


                       "Ethnicity" = Ethnicity,

                       "ICU" = ICU %>%  dplyr::rename(`Number of ICU Admissions` = Count,

                                                      `7 day average` = Average7),

                       "ICU_AgeSex" = ICU_AgeSex %>%  dplyr::rename(Sex = sex,

                                                                    `Age Group` = `age_group`,

                                                                    `Number of Cases` = number,

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



  if (input$data_select %in% c("LabData")) {

    table_data <- table_data %>%

      select(Date, `Number of Daily Cases`, Cumulative, `Cumulative Rate per 100,000`) %>%

      mutate(Date = format(Date, "%d %B %y"))

  } else if (input$data_select %in% "Admissions") {

    table_data <- table_data %>%

      select(Date, `Number of Admissions`, `7 day average`)



  } else if (input$data_select %in% "ICU") {

    table_data <- table_data %>%

      select(Date, `Number of ICU Admissions`, `7 day average`)



  } else if (input$data_select %in% "NHS24") {

    table_data <- table_data #%>%

    #select(Date, `Number of Admissions`)



  } else if (input$data_select %in% "AssessmentHub") {

    table_data <- table_data #%>%

    # select(Date, `Number of Admissions`)



  } else if (input$data_select %in% "SAS") {

    table_data <- table_data #%>%

    #  select(Date, `Number of Admissions`)

  } else if (input$data_select %in% "Ethnicity") {

    table_data <- table_data #%>%

    #  select(Date, `Number of Admissions`)

  }



  table_data %>%

    mutate_if(is.numeric, round, 1) %>%

    mutate_if(is.character, as.factor)

})



###############################################.

## Table ----



output$data_tab_table <- renderUI({

  if(input$data_select %in% c("ChildCases", "ChildTests")){

    tagList(

      p(strong("Information on COVID-19 in children and young people of educational age, education staff and educational settings is now presenting in the",

               tags$a(href ="https://publichealthscotland.scot/our-areas-of-work/covid-19/covid-19-data-and-intelligence/enhanced-surveillance-of-covid-19-in-education-settings/covid-19-education-surveillance-dashboard/",

                      "COVID-19 Education Surveillance dashboard.", target = "_blank")))

    )

  } else {

    DT::dataTableOutput("table_filtered")

  }

})


output$table_filtered <- DT::renderDataTable({
  
  datatab_table(data_table(), 
                add_separator_cols = table_params_data()$separator_cols,
                add_separator_cols_1dp = table_params_data()$separator_cols_1dp,
                add_percentage_cols = table_params_data()$percentage_cols,
                maxrows = table_params_data()$maxrows
                ) # from functions_tables.R
  
})

table_params_data <- reactive({
  
  # Columns to add 1,000 comma separator to for each table
  separator_cols = switch(input$data_select,
                           
                           "LabCases" = c(2,3),
                           "LabCases_AgeSex" = c(3),
                           "LabCases_SIMD" = c(2),
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
  separator_cols_1dp = switch(input$data_select,
                               "LabCases" = c(4,5),
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
  percentage_cols = switch(input$data_select,
                            
                            "LabCases_SIMD" = c(3),
                            "Cases_AgeGrp" = c(3),
                            "Cases_Adm" = c(2),
                            "Admissions_SIMD" = c(3),
                            "Ethnicity" = c(4),
                            "NHS24_SIMD" = c(3),
                            "AssessmentHub_SIMD" = c(3),
                            "SAS_SIMD" = c(3),
                            c() # default
  )
  
  maxrows = switch(input$data_select,
                    
                    "LabCases_AgeSex" = 44,
                    "Cases_AgeGrp" = 11,
                    "Admissions_AgeSex" = 30,
                    "Ethnicity" = 6,
                    "NHS24_community" = 6,
                    "ICU_AgeSex" = 18,
                    "NHS24_AgeSex" = 32,
                    "AssessmentHub_AgeSex" = 32,
                    "SAS_AgeSex" = 36,
                    14 #default
                    
  )
  
  list("separator_cols" = separator_cols, 
       "separator_cols_1dp" = separator_cols_1dp, 
       "percentage_cols" = percentage_cols, 
       "maxrows" = maxrows)
  
  
})


# Number of max rows per page for each table (default is 10 if unlisted)
maxrows <- reactive({
  maxrows <- switch(input$data_select,
                           
                         "LabCases_AgeSex" = 44,
                         "Cases_AgeGrp" = 11,
                         "Admissions_AgeSex" = 30,
                         "Ethnicity" = 6,
                         "NHS24_community" = 6,
                         "ICU_AgeSex" = 18,
                         "NHS24_AgeSex" = 32,
                         "AssessmentHub_AgeSex" = 32,
                         "SAS_AgeSex" = 36,
                          14 #default
                    
  )
  
})

###############################################.

## Data downloads ----



# Data download of data table.

output$download_table_csv <- downloadHandler(

  filename ="data_extract.csv",

  content = function(file) {

    # This downloads only the data the user has selected using the table filters

    write_csv(data_table()[input[["table_filtered_rows_all"]], ], file)

  }

)

