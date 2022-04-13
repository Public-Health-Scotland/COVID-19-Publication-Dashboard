#### Care Home Data Tab


### Time series data from RTE ----

output$CareHomeSeriesTable <- DT::renderDataTable({

  #DT::datatable(CareHomeTimeSeries)
  datatab_table(CareHomeTimeSeries,
                add_separator_cols = c(2,3,4) )

})


## Time series chart
output$CareHomeSeriesGraph <- renderPlotly({ care_home_time_series_chart(CareHomeTimeSeries) })

## Data downloads ----

care_home_timeseries_data_download <- reactive({
  CareHomeTimeSeries
})
output$download_care_home_timeseries_data <- downloadHandler(
  filename ="Care_Home_Time_Series_Data.csv",
  content = function(file) {
    write_csv(care_home_timeseries_data_download(),
              file)
  })


### Testing data

output$care_homes_table <- DT::renderDataTable({

  byboard_data_table(Care_Homes,
                     board_name_column="Health Board",
                     rows_to_display=15,
                     add_separator_cols=c(3,4,5))
})


## Data downloads ----

care_home_data_download <- reactive({
  Care_Homes
})

output$download_care_home_data <- downloadHandler(
  filename ="Care_Home_Data.csv",
  content = function(file) {
    write_csv(care_home_data_download(),
              file)
  })


