


##############################################.
## Table ----  

output$ETHtable <- DT::renderDataTable({
  
  # Remove the underscore from column names in the table
  table_colnames  <-  gsub("_", " ", colnames(Ethnicity))
  
  DT::datatable(Ethnicity, style = 'bootstrap',
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
output$ETHdownload_table_csv <- downloadHandler(
  filename ="ETHdata_extract.csv",
  content = function(file) {
    # This downloads only the data the user has selected using the table filters
    write_csv(Ethnicity()[input[["ETHtable_filtered_rows_all"]], ], file)
  }
)
