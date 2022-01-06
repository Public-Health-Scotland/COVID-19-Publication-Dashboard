
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
      #plot_box("Time (hours) between date test sample taken and case created in CMS - Percentage", plot_output = "ContactTracingTestIndexPercentage"),
      plot_box("Time (hours) between date test sample taken and the positive individual being interviewed - Percentage", plot_output = "ContactTracingTestInterviewPercentage"),
      plot_box("Time (hours) between case created in CMS and the positive individual being interviewed - Percentage", plot_output = "ContactTracingCaseInterviewPercentage"),
      plot_box("Time (hours) between case created in CMS and case closed - Percentage", plot_output = "ContactTracingCaseClosePercentage"))

  }  else if (input$ContactTracing_select == "Contact Tracing time performance cases") { # Contact Tracing Cases 
    tagList(
    #plot_box("Time (hours) between date test sample taken and case created in CMS - Cases", plot_output = "ContactTracingTestIndex"),
    plot_box("Time (hours) between date test sample taken and the positive individual being interviewed - Cases", plot_output = "ContactTracingTestInterview"),
    plot_box("Time (hours) between case created in CMS and the positive individual being interviewed - Cases", plot_output = "ContactTracingCaseInterview"),
    plot_box("Time (hours) between case created in CMS and case closed - Cases", plot_output = "ContactTracingCaseClose"))
  }  else if (input$ContactTracing_select == "Average number of contacts per case"){
    tagList(
      plot_box("Average number of contacts per case","ContactTracingAveragePlot")
    )
  }  else if (input$ContactTracing_select == "Protect Scotland App"){
    tagList(h3("Protect Scotland App"),
            renderText("The Protect Scotland App was launched on 10 September 2020. It is free and designed to protect individuals and reduce the spread of coronavirus. The app alerts individuals if they have been in close contact with another app user who tests positive for coronavirus. If they test positive, it can help in determining contacts that may have otherwise been missed while keeping individual’s information private and anonymous. "),
      plot_box("Number of contact notifications sent to the Protect Scotland App","ProximityAppContacts"),
      plot_box("Number of exposure key uploads to the Protect Scotland App","ProximityAppUploads")
    )
  }
}) 
 
#output$ContactTracingTestIndexPercentage <- renderPlotly({plot_contacttrace_Per_chart(ContactTime, data_name = "ContactTime", CTdata = "TestIndex" )})
output$ContactTracingTestInterviewPercentage <- renderPlotly({plot_contacttrace_Per_graph(ContactTime, data_name = "ContactTime", CTdata = "TestInterview" )})
output$ContactTracingCaseInterviewPercentage <- renderPlotly({plot_contacttrace_Per_graph(ContactTime, data_name = "ContactTime", CTdata = "CaseInterview" )})
output$ContactTracingCaseClosePercentage <- renderPlotly({plot_contacttrace_Per_graph(ContactTime, data_name = "ContactTime", CTdata = "CaseClose" )})

#output$ContactTracingTestIndex <- renderPlotly({plot_contacttrace_chart(ContactTime, data_name = "ContactTime", CTdata = "TestIndex" )})
output$ContactTracingTestInterview <- renderPlotly({plot_contacttrace_graph(ContactTime, data_name = "ContactTime", CTdata = "TestInterview" )})
output$ContactTracingCaseInterview <- renderPlotly({plot_contacttrace_graph(ContactTime, data_name = "ContactTime", CTdata = "CaseInterview" )})
output$ContactTracingCaseClose <- renderPlotly({plot_contacttrace_graph(ContactTime, data_name = "ContactTime", CTdata = "CaseClose" )})

output$ContactTracingAveragePlot <- renderPlotly({plot_average_CT_cases(ContactTracingAverages)})

output$ProximityAppContacts <- renderPlotly({plot_prox_contacts_chart(ProximityApp)})
output$ProximityAppUploads <- renderPlotly({plot_prox_uploads_chart(ProximityApp)})

## Data downloads ----
# For the charts at the moment the data download is for the overall one,
output$download_CT_data <- downloadHandler(
  filename ="Contact_Tracing_Extract.csv",
  content = function(file) {
    
    write_csv(ContactTime, file)
    
    })
