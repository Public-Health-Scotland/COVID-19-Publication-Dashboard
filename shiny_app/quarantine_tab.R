#### Quarantine Data Tab

output$quarantine_table <- DT::renderDataTable({
  
  # Remove the underscore from column names in the table
  table_colnames  <-  gsub("_", " ", colnames(Quarantine))
  
  DT::datatable(Quarantine, style = 'bootstrap',
                class = 'table-bordered table-condensed',
                rownames = FALSE,
                options = list(pageLength = 15,
                               dom = 'tip',
                               autoWidth = TRUE),
                filter = "top",
                colnames = table_colnames)
})


## Data downloads ----

quarantine_download <- reactive({
  Quarantine
})

# For the charts at the moment the data download is for the overall one,
output$download_quarantine_data <- downloadHandler(
  filename ="Quarantine.csv",
  content = function(file) {
    write_csv(quarantine_download(),
              file)
  })

