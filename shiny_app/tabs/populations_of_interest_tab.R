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
                add_separator_cols= c(2:10),
                highlight_column = "Outbreak status",
                flip_order=TRUE
                )


})

output$CareHomeVisitsBoardOlderTable <- DT::renderDataTable({

  byboard_data_table(CareHomeVisitsBoardOlder,
                     board_name_column = "NHS Board",
                     add_separator_cols= c(2:10),
                     add_percentage_cols = c(11,12),
                     rows_to_display=15,
                     flip_order=FALSE)


})

output$CareHomeVisitsNotOlderTable <- DT::renderDataTable({

  byboard_data_table(CareHomeVisitsNotOlder,
                     board_name_column = "NHS Board",
                     add_separator_cols= c(2:10),
                     add_percentage_cols = c(11,12),
                     rows_to_display=15,
                     flip_order=FALSE)


})

## Data downloads ----

# Table 1 download
care_home_visits_data_download <- reactive({
  CareHomeVisitsBoard
})

output$care_home_visits_data_download <- downloadHandler(
  filename ="Care_Home_Visits_by_Board_Data.csv",
  content = function(file) {
    write_csv(care_home_visits_data_download(),
              file)
  })


# Table 2 download
care_home_outbreak_data_download <- reactive({
  CareHomeVisitsOutbreak
})

output$care_home_outbreak_data_download <- downloadHandler(
  filename ="Care_Home_Outbreak_by_Board_Data.csv",
  content = function(file) {
    write_csv(care_home_outbreak_data_download(),
              file)
  })


# Table 3a
care_home_visits_older_data_download <- reactive({
  CareHomeVisitsBoardOlder
})

output$care_home_visits_older_data_download <- downloadHandler(
  filename ="Care_Home_Visits_Older_CH_Data.csv",
  content = function(file) {
    write_csv(care_home_visits_older_data_download(),
              file)
  })


# Table 3b
care_home_visits_not_older_data_download <- reactive({
  CareHomeVisitsNotOlder
})

output$download_care_home_visits_not_older_data <- downloadHandler(
  filename ="Care_Home_Visits_Not_Older_CH_Data.csv",
  content = function(file) {
    write_csv(care_home_visits_not_older_data_download(),
              file)
  })
