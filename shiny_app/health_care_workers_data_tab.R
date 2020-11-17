

## Reactive data ----

##reactive data to show in app
HCWdata_table <- reactive({  # Change dataset depending on what user selected
  
  table_data <- switch(input$HCWdata_select,
                       "HealthCareWorkerCancer" = HealthCareWorkerCancer,
                       "HealthCareWorkerElderly" = HealthCareWorkerElderly,
                       "HealthCareWorkerPsychiatry" = HealthCareWorkerPsychiatry)
  
  
  table_data <- table_data
  # table_data %>% 
  #   mutate_if(is.numeric, round, 1) %>% 
  #   mutate_if(is.character, as.factor)
})


###############################################.
## Table ----

output$HCWtable_filtered <- DT::renderDataTable({
  
  # Remove the underscore from column names in the table
  table_colnames  <-  gsub("_", " ", colnames(HCWdata_table()))
  
  DT::datatable(HCWdata_table(), style = 'bootstrap',
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

# Data download of data table. 
output$HCWdownload_table_csv <- downloadHandler(
  filename ="HCWdata_extract.csv",
  content = function(file) {
    # This downloads only the data the user has selected using the table filters
    write_csv(HCWdata_table()[input[["HCWtable_filtered_rows_all"]], ], file) 
  } 
)
