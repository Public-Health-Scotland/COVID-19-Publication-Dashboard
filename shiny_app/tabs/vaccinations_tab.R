###### Vaccinations


### Table
output$VaccineWastage_table <- DT::renderDataTable({


  datatab_table(VaccineWastage,
                     add_separator_cols=c(2,3), # Column indices to add thousand separators to
                     add_percentage_cols=c(4),
                     maxrows=16,
                     flip_order=FALSE)

})

### Reasons Table
output$VaccineWastageReason_table <- DT::renderDataTable({


  datatab_table(VaccineWastageReason,
                add_percentage_cols=c(2),
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
           plot_box("", plot_output = "VaccineWastage_trend"),
          downloadButton('download_VaccineWastage_data', 'Download vaccine wastage data'),
          DT::dataTableOutput("VaccineWastage_table"),
          h3("Reasons for wastage for latest month"),
          DT::dataTableOutput("VaccineWastageReason_table")
          )

})

