

## Reactive data ----

##reactive data to show in app
CTdata_table <- reactive({  # Change dataset depending on what user selected

  table_data <- switch(input$CTdata_select,
                       "ContactTracing" = ContactTracing,
                       "ContactTime" = ContactTime,
                       "ContactEC" = ContactEC,
                       "ContactWeeklyCases" = ContactWeeklyCases,
                       "ContactTracingWeeklyCumulative" = ContactTracingWeeklyCumulative )

  # if (input$data_select %in% c("ContactTracing")) {
  #   table_data <- table_data
  # 
  # } else if (input$data_select %in% "ContactTime") {
  #   table_data <- table_data
  # }

table_data %>% 
    mutate_if(is.numeric, round, 1) %>% 
    mutate_if(is.character, as.factor)
})

###############################################.
## Table ----

output$CTtable_filtered <- DT::renderDataTable({
  
  # Remove the underscore from column names in the table
  table_colnames  <-  gsub("_", " ", colnames(CTdata_table()))

  DT::datatable(CTdata_table(), style = 'bootstrap',
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
output$CTdownload_table_csv <- downloadHandler(
  filename ="CTdata_extract.csv",
  content = function(file) {
    # This downloads only the data the user has selected using the table filters
    write_csv(CTdata_table()[input[["CTtable_filtered_rows_all"]], ], file) 
  } 
)
