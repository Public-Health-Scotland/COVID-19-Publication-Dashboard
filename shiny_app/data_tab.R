

## Reactive data ----

##reactive data to show in app
data_table <- reactive({  # Change dataset depending on what user selected
  
  table_data <- switch(input$data_select,
                       "LabCases" = LabCases %>%  rename (`Number of Cases` = Count),
                       "LabCases_AgeSex" = LabCases_AgeSex,
                       "LabCases_SIMD" = LabCases_SIMD %>% rename(Percent = cases_pc),
                       "Admissions" = Admissions %>%  rename (`Number of Admissions` = Count),
                       "Admissions_AgeSex" = Admissions_AgeSex,
                       "Admissions_SIMD" = Admissions_SIMD %>% rename(Percent = cases_pc),
                       "ICU" = ICU %>%  rename(`Number of ICU Admissions` = Count),
                       "ICU_AgeSex" = ICU_AgeSex,
                       "NHS24" = NHS24 %>% rename(`Number of NHS Calls` = Count,
                                                  `Number of Corona Virus Helpline` = CoronavirusHelpline),
                       "NHS24_AgeSex" = NHS24_AgeSex,
                       "NHS24_SIMD" = NHS24_SIMD %>% rename(Percent = cases_pc),
                       "NHS24_inform" = NHS24_inform %>% rename(Hits = count),
                       "NHS24_selfhelp" = NHS24_selfhelp %>% 
                                            rename(`Self Help guides completed` = selfhelp,
                                                   `Advised to self isolate` = isolate),
                       "NHS24_community" = NHS24_community %>% 
                                            rename(`Community hub outcome` = outcome,
                                                   Count = count),
                       "AssessmentHub" = AssessmentHub %>% rename(`COVID-19 Advice` = CountAdvice,
                                                                  `COVID-19 Assessments` = CountAssessment,
                                                                  `Other` = CountOther),
                       "AssessmentHub_AgeSex" = AssessmentHub_AgeSex,
                       "AssessmentHub_SIMD" = AssessmentHub_SIMD %>% rename(Percent = cases_pc),
                       "SAS" = SAS,
                       "SAS_AgeSex" = SAS_AgeSex,
                       "SAS_SIMD" = SAS_SIMD %>% rename(Percent = cases_pc),
                       "SAS_all" = SAS_all %>% rename(Incidents = count)) 
  
#not sure if this if/else section is needed?
  if (input$data_select %in% c("LabData")) {
    table_data <- table_data %>% 
      select(Date, `Number of Daily Cases`, Cumulative) %>% 
      mutate(Date = format(Date, "%d %B %y"))

  } else if (input$data_select %in% "Admissions") { 
    table_data <- table_data %>%
      select(Date, `Number of Admissions`) 
    
  } else if (input$data_select %in% "ICU") {
    table_data <- table_data %>%
      select(Date, `Number of ICU Admissions`)

  } else if (input$data_select %in% "NHS24") {
    table_data <- table_data #%>%
      #select(Date, `Number of Admissions`)

  } else if (input$data_select %in% "AssessmentHub") {
    table_data <- table_data #%>%
     # select(Date, `Number of Admissions`)

  } else if (input$data_select %in% "SAS") {
    table_data <- table_data #%>%
    #  select(Date, `Number of Admissions`)
  } 
  
table_data %>% 
    rename_all(list(~str_to_sentence(.))) %>% # initial capital letter
    #rename_with(.fn = toupper, .cols = matches("Simd")) %>% #make SIMD all caps
    rename_with(.cols = matches("Simd"),
                .fn = str_replace, 
                pattern = "Simd", 
                replacement = "Deprivation category (SIMD)") %>% #change SIMD
    mutate_if(is.numeric, round, 1) %>% 
    mutate_if(is.character, as.factor)

})

###############################################.
## Table ----
###############################################.

output$table_filtered <- DT::renderDataTable({
  
  # Remove the underscore from column names in the table
  table_colnames  <-  gsub("_", " ", colnames(data_table()))

  DT::datatable(data_table(), style = 'bootstrap',
                class = 'table-bordered table-condensed',
                rownames = FALSE,
                options = list(pageLength = 20,
                               dom = 'tip',
                               autoWidth = TRUE),
                filter = "top",
                colnames = table_colnames)
})

###############################################.
## Data downloads ----
###############################################.
# Data download of data table. 
output$download_table_csv <- downloadHandler(
  filename ="data_extract.csv",
  content = function(file) {
    # This downloads only the data the user has selected using the table filters
    write_csv(data_table()[input[["table_filtered_rows_all"]], ], file) 
  } 
)
