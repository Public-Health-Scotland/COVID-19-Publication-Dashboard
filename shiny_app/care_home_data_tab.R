#### Care Home Data Tab

output$care_homes_table <- DT::renderDataTable({
  
  byboard_data_table(Care_Homes, board_name_column="Health Board", rows_to_display=15)
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
