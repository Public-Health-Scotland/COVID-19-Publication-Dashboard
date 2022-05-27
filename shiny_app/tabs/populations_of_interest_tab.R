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

### Care Home Visitors

output$CareHomeVisitsBoardTable <- DT::renderDataTable({

  byboard_data_table(CareHomeVisitsBoard,
                     board_name_column = "NHS Board",
                     add_separator_cols= c(2:10),
                     add_percentage_cols = c(11,12),
                     rows_to_display=15,
                     flip_order=FALSE)


})

output$CareHomeVisitsOutbreakTable <- DT::renderDataTable({

  datatab_table(CareHomeVisitsOutbreak,
                     add_separator_cols= c(2:10))


})

output$CareHomeVisitsBoardOlderTable <- DT::renderDataTable({

  byboard_data_table(CareHomeVisitsBoardOlder,
                     board_name_column = "NHS Board",
                     add_separator_cols= c(2:10),
                     add_percentage_cols = c(11,12),
                     rows_to_display=15,
                     flip_order=FALSE)


})

output$CareHomeVisitsOutbreakOlderTable <- DT::renderDataTable({

  byboard_data_table(CareHomeVisitsOutbreakOlder,
                     board_name_column = "NHS Board",
                     add_separator_cols= c(2:10),
                     add_percentage_cols = c(11,12),
                     rows_to_display=15,
                     flip_order=FALSE)


})

