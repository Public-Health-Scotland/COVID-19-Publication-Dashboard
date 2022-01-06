
# Modal -------------------------------------------------------------------

observeEvent(input$btn_dataset_modal3,
             
             showModal(modalDialog(
               title = "What is the data source?",
               p("BLANK"),
               p("BLANK ") ,
               size = "m",
               easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))


# Chart -------------------------------------------------------------------
output$Ethnicity_explorer <- renderUI({
  
  tagList(h3("Ethnicity"),
          actionButton("btn_dataset_modal3", paste0("Data source: Data source: Case Management System"), icon = icon('question-circle')),
          plot_box("Inpatient Admissions by Ethnicity", plot_output = "EthnicityChart"))} )

output$EthnicityChart <- renderPlotly({plot_overall_chartEthnicity(Ethnicity_Chart, data_name = "Ethnicity_Chart")})




## Data downloads ----
# For the charts at the moment the data download is for the overall one,
output$download_ethnicity_data <- downloadHandler(
  filename ="Ethnicity_extract.csv",
  content = function(file) {
    write_csv(Ethnicity,
              file)
  })


