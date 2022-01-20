

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
  
  brks <-seq()
  
  DT::datatable(HCWdata_table(), style = 'bootstrap',
                class = 'table-bordered table-condensed',
                rownames = FALSE,
                options = list(pageLength = 14, # Health Boards and total
                               order = list(list(0, "desc")), # Most recent week first
                               dom = 'tip',
                               autoWidth = TRUE,
                               initComplete = JS(
                                 "function(settings, json) {",
                                 "$(this.api().table().header()).css({'background-color': '#3F3685', 'color': 'white'});",
                                 "}")
                               ),
                filter = "top",
                colnames = table_colnames) %>% 
    formatStyle(
      "NHS Board", target="row", 
      backgroundColor = styleEqual("Scotland", phs_colours("phs-magenta")),
      fontWeight = styleEqual("Scotland", "bold"),
      color = styleEqual("Scotland", "white")
        )

  
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
