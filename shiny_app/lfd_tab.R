#### LFD Data Tab


### Chart
output$LFD_trend <- renderPlotly({plot_LFDs(LFD_Weekly)}) #plot_LFDs

### Data
output$LFD_table <- DT::renderDataTable({
  
  
  byboard_data_table(LFD,
                     "NHS Board of Residence",  # Name of the column with board names e.g. "NHS Board"
                     add_separator_cols=c(2,3), # Column indices to add thousand separators to
                     rows_to_display=16,
                     flip_order=TRUE)
  
})


## Data downloads ----

LFD_download <- reactive({
  LFD
})

LFD_weekly_download <- reactive({
  LFD_Weekly
})

# For the charts at the moment the data download is for the overall one,
output$download_LFD_data <- downloadHandler(
  filename ="LFD_Board.csv",
  content = function(file) {
    write_csv(LFD_download(),
              file)
  })
output$download_LFD_weekly_data <- downloadHandler(
  filename ="LFD_Weekly.csv",
  content = function(file) {
    write_csv(LFD_weekly_download(),
              file)
  })


output$LFD_output <-renderUI({
  
    tagList(h3("Number of LFD Tests Week Ending"),
            p("The chart below shows the number of LFD tests each week, the data for which can be downloaded by clicking the button above."),
            plot_box("", plot_output = "LFD_trend"),
            h3("Number of LFD Tests by Health Board"),
            p(glue("The table below shows the number of LFD tests up to {LFD_date} by NHS Board of Residence (based on the postcode provided by the individual taking the test). You can download the data by clicking the button above.")),
            DT::dataTableOutput("LFD_table"))

})

