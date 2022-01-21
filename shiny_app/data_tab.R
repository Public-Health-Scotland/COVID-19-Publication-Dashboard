
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
                       
                       "LabCases_SIMD" = LabCases_SIMD %>% dplyr::rename(`Number of Cases` = cases,
                                                                  
                                                                  Percent = cases_pc),
                       "Cases_AgeGrp" = Cases_AgeGrp %>% dplyr::rename('Week ending' = 'Date',
                                                                'Percentage of weekly cases' = 'Percent'),
                       
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
  
  data_tab_table(data_table()) # from functions_tables.R
  
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

