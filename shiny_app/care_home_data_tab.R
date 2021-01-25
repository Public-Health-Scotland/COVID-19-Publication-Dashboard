#### Care Home Data Tab

caption <- paste("Please note: there were an additional 12 staff tested at",
                 "homes where the COVID status was not specified.")

output$care_homes_table <- DT::renderDataTable({
  
  # Remove the underscore from column names in the table
  table_colnames  <-  gsub("_", " ", colnames(Care_Homes))
  
  DT::datatable(Care_Homes, style = 'bootstrap',
                class = 'table-bordered table-condensed',
                rownames = FALSE,
                options = list(pageLength = 15,
                               dom = 'tic',
                               autoWidth = TRUE),
                filter = "top",
                caption = caption,
                colnames = table_colnames)
})


## Data downloads ----

care_home_data_download <- reactive({
  Care_Homes
})

# For the charts at the moment the data download is for the overall one,
output$download_care_home_data <- downloadHandler(
  filename ="Care_Home_Data.csv",
  content = function(file) {
    write_csv(care_home_data_download(),
              file)
  })
