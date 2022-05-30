###### Vaccinations


### Table
output$VaccineWastage_table <- DT::renderDataTable({


  datatab_table(VaccineWastage,
                     add_separator_cols=c(2,3), # Column indices to add thousand separators to
                     add_percentage_cols=c(4),
                     maxrows=16,
                     flip_order=FALSE)

})

## Graph ----
output$VaccineWastage_trend <- renderPlotly({plot_VaccineWastage(VaccineWastage)})


## Data downloads ----

VaccineWastage_download <- reactive({
  VaccineWastage
})

# For the charts at the moment the data download is for the overall one,
output$download_VaccineWastage_data <- downloadHandler(
  filename ="VaccineWastage.csv",
  content = function(file) {
    write_csv(VaccineWastage_download(),
              file)
  })

output$VaccineWastage_output <-renderUI({

  tagList(br(),
          # tags$li("Given the scale of the Covid-19 vaccination programme, some vaccine wastage has been unavoidable for a variety
          #   of reasons including logistical issues, storage failure and specific clinical situations."),
          # tags$li("The initial planning assumption for the vaccination programme was that there would be around 5% vaccine wastage.
          #   The chart and table below show the trend of the percentage of vaccines wasted by calendar month."),
         # tags$li("The data can be downloaded using the button above the table."),
           plot_box("", plot_output = "VaccineWastage_trend"),
          downloadButton('download_VaccineWastage_data', 'Download vaccine wastage data'),
          DT::dataTableOutput("VaccineWastage_table")#,
          # h4("Data sources and limitations"),
          # tags$li("The single source of vaccination wastage data for Scotland is through an NSS Service Now wastage form,
          #         which is populated by health board clinicians which can impact timeliness and accuracy"),
          # tags$li("Excludes GP practice information"),
          # tags$li("Excludes wastage from clinical trials")
          )

})

