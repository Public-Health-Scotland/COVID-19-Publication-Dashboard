##### Infection levels and cases --------

#output$data_explorer_infcases <- renderUI({ui_contents})
download_infcases_data <- downloadHandler(
  filename ="data_extract.csv",
  content = function(file) {
    write_csv(overall_data_download(),
              file) }
)