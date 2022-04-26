##### Severe illness --------

#output$data_explorer_severe_illness <- renderUI({ui_contents})
download_severe_illness_data <- downloadHandler(
                                            filename ="data_extract.csv",
                                            content = function(file) {
                                                          write_csv(overall_data_download(),
                                                          file) }
)