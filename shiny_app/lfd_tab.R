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

### Graph

# data prep
LFD_tests <- LFD_TestGroup %>%
  select(`Week Ending`, `Test Group`, `Number of Tests`) %>%
  pivot_wider(names_from = `Test Group`,
              values_from = `Number of Tests`)

LFD_positives <- LFD_TestGroup %>%
  select(`Week Ending`, `Test Group`, `Number of Positive Tests`) %>%
  pivot_wider(names_from = `Test Group`,
              values_from = `Number of Positive Tests`)

output$LFD_TestGroup_trend <- renderPlotly({LFD_time_series_chart(LFD_tests)})

output$LFD_grouptable <- DT::renderDataTable({


  datatab_table(LFD_TestGroup,
                add_separator_cols=c(3,4), # Column indices to add thousand separators to
                add_percentage_cols = 5, # with % symbol and 2dp
                maxrows=16,
                flip_order=FALSE)

})


## Data downloads ----

LFD_download <- reactive({
  LFD
})

LFD_weekly_download <- reactive({
  LFD_Weekly
})

LFD_testgroup_download <- reactive({
  LFD_TestGroup
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

output$download_LFD_testgroup <- downloadHandler(
  filename = "LFD_TestGroup.csv",
  content= function(file) {
    write_csv(LFD_testgroup_download(),
              file)
  })

output$LFD_output <-renderUI({

  tagList(h3("Number of LFD Tests Week Ending"),
          p("The chart below shows the number of LFD tests each week, the data for which can be downloaded
              by clicking the button at the top of the page."),
          plot_box("", plot_output = "LFD_trend"),
          h3("Number of LFD Tests by Health Board"),
          p(glue("The table below shows the number of LFD tests up to {LFD_date} by NHS Board of Residence
                   (based on the postcode provided by the individual taking the test). You can download the
                   data by clicking the button at the top of the page.")),
          DT::dataTableOutput("LFD_table"),
          h3("Number of LFD Tests by Test Group"),
          p(glue("The graph and table below show the number of LFD tests from 19 November 2020 to {LFD_date} by test group"),
            "(based on self-reported reason for testing by the individual registering the test). You can download the
              data by clicking the button at the top of the page." #,
            #"Data from 03 March 2022 have been re-categorised accordingly into two new categories:
            #‘Checking Covid-19 Status During Isolation’ and ‘Close Contact Eligible for Daily Testing’"
          ),
          plot_box("", plot_output = "LFD_TestGroup_trend"),
          DT::dataTableOutput("LFD_grouptable"))

})
