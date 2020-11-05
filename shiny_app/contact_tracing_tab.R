
# Modal -------------------------------------------------------------------

observeEvent(input$btn_dataset_modal2,

               showModal(modalDialog(
                 title = "What is the data source?",
                 p("Case Management System"),
                 p("Contacting Tracing data is extracted from the Case management System on the Sunday at 8pm prior to publication. ") ,
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))


# Chart -------------------------------------------------------------------

output$ContactTracing_explorer <- renderUI({

   tagList(h3("Contact Tracing time performance"),
          actionButton("btn_dataset_modal2", paste0("Data source: Case Management System"), icon = icon('question-circle'))) 
          
  # Charts and rest of UI
  if (input$ContactTracing_select == "Contact Tracing time performance %") { # Contact Tracing % 
    tagList(h3("Contact Tracing"),
            actionButton("btn_dataset_modal2", paste0("Data source: Case Management System"), icon = icon('question-circle')),
      plot_box("Time (hours) between date test sample taken and case created in CMS - Percentage", plot_output = "ContactTracingTestIndexPercentage"),
      plot_box("Time (hours) between date test sample taken and the positive individual being interviewed - Percentage", plot_output = "ContactTracingTestInterviewPercentage"),
      plot_box("Time (hours) between case created in CMS and the positive individual being interviewed - Percentage", plot_output = "ContactTracingCaseInterviewPercentage"),
      plot_box("Time (hours) between case created in CMS and case closed - Percentage", plot_output = "ContactTracingCaseClosePercentage"))

  }  else if (input$ContactTracing_select == "Contact Tracing time performance cases" ) { # Contact Tracing Cases 
    tagList(
    plot_box("Time (hours) between date test sample taken and case created in CMS - Cases", plot_output = "ContactTracingTestIndex"),
    plot_box("Time (hours) between date test sample taken and the positive individual being interviewed - Cases", plot_output = "ContactTracingTestInterview"),
    plot_box("Time (hours) between case created in CMS and the positive individual being interviewed - Cases", plot_output = "ContactTracingCaseInterview"),
    plot_box("Time (hours) between case created in CMS and case closed - Cases", plot_output = "ContactTracingCaseClose"))
  }  
}) 
 
output$ContactTracingTestIndexPercentage <- renderPlotly({plot_contacttrace_Per_chart(ContactTime, data_name = "ContactTime", CTdata = "TestIndex" )})
output$ContactTracingTestInterviewPercentage <- renderPlotly({plot_contacttrace_Per_chart(ContactTime, data_name = "ContactTime", CTdata = "TestInterview" )})
output$ContactTracingCaseInterviewPercentage <- renderPlotly({plot_contacttrace_Per_chart(ContactTime, data_name = "ContactTime", CTdata = "CaseInterview" )})
output$ContactTracingCaseClosePercentage <- renderPlotly({plot_contacttrace_Per_chart(ContactTime, data_name = "ContactTime", CTdata = "CaseClose" )})

output$ContactTracingTestIndex <- renderPlotly({plot_contacttrace_chart(ContactTime, data_name = "ContactTime", CTdata = "TestIndex" )})
output$ContactTracingTestInterview <- renderPlotly({plot_contacttrace_chart(ContactTime, data_name = "ContactTime", CTdata = "TestInterview" )})
output$ContactTracingCaseInterview <- renderPlotly({plot_contacttrace_chart(ContactTime, data_name = "ContactTime", CTdata = "CaseInterview" )})
output$ContactTracingCaseClose <- renderPlotly({plot_contacttrace_chart(ContactTime, data_name = "ContactTime", CTdata = "CaseClose" )})


## Data downloads ----
# For the charts at the moment the data download is for the overall one,
output$download_CT_data <- downloadHandler(
  filename ="data_extract.csv",
  content = function(file) {
    write_csv(ContactTracing(),
              file)
    })
