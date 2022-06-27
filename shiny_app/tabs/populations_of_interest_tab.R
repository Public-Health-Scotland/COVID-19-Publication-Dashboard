###### Populations of interest

### Care Home Time series data from RTE ----

output$CareHomeSeriesTable <- DT::renderDataTable({

  datatab_table(CareHomeTimeSeries,
                add_separator_cols = c(2,3,4),
                order_by_firstcol="desc")

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

  col_select <- paste0("date_", format(as.Date(input$care_home_visits_date_table1, format="%d %B %Y")+1, "%Y%m%d"))

  byboard_data_table(CareHomeVisitsBoard[[col_select]],
                     board_name_column = "NHS Board",
                     add_separator_cols= c(2:10),
                     add_percentage_cols = c(11,12),
                     rows_to_display=15)


})

output$CareHomeVisitsOutbreakTable <- DT::renderDataTable({

  col_select <- paste0("date_", format(as.Date(input$care_home_visits_date_table2, format="%d %B %Y")+1, "%Y%m%d"))

  datatab_table(CareHomeVisitsOutbreak[[col_select]],
                add_separator_cols= c(2:10),
                highlight_column = "Outbreak status"
                )


})

output$CareHomeVisitsBoardOlderTable <- DT::renderDataTable({

  col_select <- paste0("date_", format(as.Date(input$care_home_visits_date_table3a, format="%d %B %Y")+1, "%Y%m%d"))

  byboard_data_table(CareHomeVisitsBoardOlder[[col_select]],
                     board_name_column = "NHS Board",
                     add_separator_cols= c(2:10),
                     add_percentage_cols = c(11,12),
                     rows_to_display=15)


})

output$CareHomeVisitsNotOlderTable <- DT::renderDataTable({

  col_select <- paste0("date_", format(as.Date(input$care_home_visits_date_table3b, format="%d %B %Y")+1, "%Y%m%d"))

  byboard_data_table(CareHomeVisitsOutbreakOlder[[col_select]],
                     board_name_column = "NHS Board",
                     add_separator_cols= c(2:10),
                     add_percentage_cols = c(11,12),
                     rows_to_display=15)


})

## Data downloads ----

# Table 1 download
care_home_visits_data_download <- reactive({

  col_select <- paste0("date_", format(as.Date(input$care_home_visits_date_table1, format="%d %B %Y")+1, "%Y%m%d"))
  CareHomeVisitsBoard[[col_select]]
})

output$care_home_visits_data_download <- downloadHandler(
  filename ="Care_Home_Visits_by_Board_Data.csv",
  content = function(file) {
    write_csv(care_home_visits_data_download(),
              file)
  })


# Table 2 download
care_home_outbreak_data_download <- reactive({

  col_select <- paste0("date_", format(as.Date(input$care_home_visits_date_table2, format="%d %B %Y")+1, "%Y%m%d"))
  CareHomeVisitsOutbreak[[col_select]]
})

output$care_home_outbreak_data_download <- downloadHandler(
  filename ="Care_Home_Outbreak_by_Board_Data.csv",
  content = function(file) {
    write_csv(care_home_outbreak_data_download(),
              file)
  })


# Table 3a
care_home_visits_older_data_download <- reactive({

  col_select <- paste0("date_", format(as.Date(input$care_home_visits_date_table3a, format="%d %B %Y")+1, "%Y%m%d"))
  CareHomeVisitsBoardOlder[[col_select]]
})

output$care_home_visits_older_data_download <- downloadHandler(
  filename ="Care_Home_Visits_Older_CH_Data.csv",
  content = function(file) {
    write_csv(care_home_visits_older_data_download(),
              file)
  })


# Table 3b
care_home_visits_not_older_data_download <- reactive({

  col_select <- paste0("date_", format(as.Date(input$care_home_visits_date_table3b, format="%d %B %Y")+1, "%Y%m%d"))
  CareHomeVisitsOutbreakOlder[[col_select]]
})

output$download_care_home_visits_not_older_data <- downloadHandler(
  filename ="Care_Home_Visits_Not_Older_CH_Data.csv",
  content = function(file) {
    write_csv(care_home_visits_not_older_data_download(),
              file)
  })
