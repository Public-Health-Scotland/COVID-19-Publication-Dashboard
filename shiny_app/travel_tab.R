#### Travel outside Scotland

### Chart
output$travel_chart <- renderPlotly({travel_outside_scotland_chart(ContactTracingRegions)})

output$travel_table <- DT::renderDataTable({
  
  # Remove the underscore from column names in the table
  table_colnames  <-  gsub("_", " ", colnames(ContactTracingRegions))
  
  DT::datatable(ContactTracingRegions, style = 'bootstrap',
                class = 'table-bordered table-condensed',
                rownames = FALSE,
                options = list(pageLength = 15,
                               dom = 'tip',
                               autoWidth = TRUE),
                filter = "top",
                colnames = table_colnames)
})


## Data downloads ----

travel_download <- reactive({
  ContactTracingRegions
})

# For the charts at the moment the data download is for the overall one,
output$download_travel_data <- downloadHandler(
  filename ="ContactTracingRegions.csv",
  content = function(file) {
    write_csv(travel_download(),
              file)
  })

