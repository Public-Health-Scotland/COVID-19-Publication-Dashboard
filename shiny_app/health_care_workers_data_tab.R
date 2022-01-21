

## Reactive data ----

##reactive data to show in app
HCWdata_table <- reactive({  # Change dataset depending on what user selected
  
  table_data <- switch(input$HCWdata_select,
                       "HealthCareWorkerCancer" = HealthCareWorkerCancer,
                       "HealthCareWorkerElderly" = HealthCareWorkerElderly,
                       "HealthCareWorkerPsychiatry" = HealthCareWorkerPsychiatry)
  
  
  table_data <- table_data

})


###############################################.
## Table ----

output$HCWtable_filtered <- DT::renderDataTable({
  
  byboard_data_table(HCWdata_table(), board_name_column="NHS Board",
                     add_separator_cols=c(3,4,5,6))


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
