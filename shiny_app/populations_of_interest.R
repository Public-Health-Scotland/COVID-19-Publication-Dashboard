###### Populations of interest

### Care Home Time series data from RTE ----

output$CareHomeSeriesTable <- DT::renderDataTable({

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
