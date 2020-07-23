

## Reactive data ----

##reactive data to show in app
data_table <- reactive({  # Change dataset depending on what user selected
  
  table_data <- switch(input$data_select,
                       "LabCases" = LabCases %>%  rename (`Number of Cases` = Count), 
                       "Admissions" = Admissions %>%  rename (`Number of Admissions` = Count),
                       "ICU" = ICU %>%  rename(`Number of ICU Admissions` = Count),
                       "NHS24" = NHS24 %>% rename(`Number of NHS Calls` = Count,
                                                  `Number of Corona Virus Helpline` = CoronavirusHelpline),
                       "AssessmentHub" = AssessmentHub %>% rename(`COVID-19 Advice` = CountAdvice,
                                                                  `COVID-19 Assessments` = CountAssessment,
                                                                  `Other` = CountOther),
                       "SAS" = SAS %>% 
    
    mutate_if(is.character, as.factor))  # Note: character variables are converted to factors in each dataset for use in the table
    # This is because dropdown prompts on the table filters only appear for factors

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
    #select(sort(current_vars())) %>%  # order columns alphabetically
    mutate_if(is.numeric, round, 1)
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
