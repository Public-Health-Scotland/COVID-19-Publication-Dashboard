#### Care Home Data Tab

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

# For the charts at the moment the data download is for the overall one,
output$download_care_home_data <- downloadHandler(
  filename ="Care_Home_Data.csv",
  content = function(file) {
    write_csv(care_home_data_download(),
              file)
  })



### Time series data from RTE ----

output$CareHomeSeriesTable <- DT::renderDataTable({

  #DT::datatable(CareHomeTimeSeries)
  datatab_table(CareHomeTimeSeries,
                add_separator_cols = c(2,3,4) )

})



### Time series

output$CareHomeSeriesGraph <- renderPlotly({

  tooltip_trend <- c(paste0("Week Ending: ", format(CareHomeTimeSeries$`Week Ending`, "%d %b %y"),
                            "<br>", "Staff: ", format(as.numeric(CareHomeTimeSeries$Staff), big.mark=","),
                            "<br>", "Residents: ", format(as.numeric(CareHomeTimeSeries$Resident), big.mark=",")))

  yaxis_plots[["title"]] <- "Tests"
  xaxis_plots[["title"]] <- "Week Ending"

  CareHomeGraph <- CareHomeTimeSeries %>%
    select( `Week Ending`, Resident, Staff ) %>%
    mutate( Resident = as.numeric(Resident), Staff = as.numeric(Staff) ) %>%
    plot_ly( x = ~`Week Ending` ) %>%
    add_trace(
      y = ~Staff, line=list(color=phs_colours('phs-magenta-80')), name='Staff', mode='lines',
      text = tooltip_trend, hoverinfo="text"
      ) %>%
    add_trace(
      y = ~Resident, line=list(color=phs_colours('phs-blue-80')), name='Residents', mode='lines',
      text = tooltip_trend, hoverinfo="text"
      ) %>%
    layout(margin = list(b = 80, t = 5),
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>%
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )



})



## Data downloads ----

care_home_timeseries_data_download <- reactive({
  CareHomeTimeSeries
})

# For the charts at the moment the data download is for the overall one,
output$download_care_home_timeseries_data <- downloadHandler(
  filename ="Care_Home_Time_Series_Data.csv",
  content = function(file) {
    write_csv(care_home_timeseries_data_download(),
              file)
  })
