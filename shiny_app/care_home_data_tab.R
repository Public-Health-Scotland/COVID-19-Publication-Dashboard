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
  
  CareHomeGraph <- plot_ly( CareHomeTimeSeries, x = ~`Week Ending` ) %>% 
    add_trace( y = ~Staff, name= 'Staff', mode = 'lines' ) %>% 
    add_trace( y = ~Resident, name = 'Residents', mode = 'lines' )
  
})