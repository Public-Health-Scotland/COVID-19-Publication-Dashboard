
# Modal -------------------------------------------------------------------

observeEvent(input$btn_dataset_modal2,

               showModal(modalDialog(
                 title = "What is the data source?",
                 p("xxxxxxxxxxx"),
                 p("xxxxxxxxxxxx") ,
                 p("xxxxxxxxxxxxxxxx"),
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))


# Chart -------------------------------------------------------------------

output$ContactTracing_explorer <- renderUI({

  tagList(h3("Contact Tracing"),
          actionButton("btn_dataset_modal2", paste0("Data source: DATA SOURCE"), icon = icon('question-circle')),
          plot_box("Time (hours) between date test sample taken and case created in CMS ", plot_output = "ContactTracingTestIndex"),
          plot_box("Time (hours) between date test sample taken and the positive individual being interviewed", plot_output = "ContactTracingTestInterview"),
          plot_box("Time (hours) between case created in CMS and the positive individual being interviewed", plot_output = "ContactTracingCaseInterview"),
          plot_box("Time (hours) between case created in CMS and case closed ", plot_output = "ContactTracingCaseClose"))
})

output$ContactTracingTestIndex <- renderPlotly({plot_contacttrace_TestIndex_chart(ContactTime, data_name = "ContactTime")})
output$ContactTracingTestInterview <- renderPlotly({plot_contacttrace_TestInterview_chart(ContactTime, data_name = "ContactTime")})
output$ContactTracingCaseInterview <- renderPlotly({plot_contacttrace_CaseInterview_chart(ContactTime, data_name = "ContactTime")})
output$ContactTracingCaseClose <- renderPlotly({plot_contacttrace_CaseClose_chart(ContactTime, data_name = "ContactTime")})


## Data downloads ----
# For the charts at the moment the data download is for the overall one,
output$download_CT_data <- downloadHandler(
  filename ="data_extract.csv",
  content = function(file) {
    write_csv(ContactTracing(),
              file)
    })
