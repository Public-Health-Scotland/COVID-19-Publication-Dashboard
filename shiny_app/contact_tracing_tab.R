observeEvent(input$btn_dataset_modal2, 
             
           #  if (input$measure_select == "LabCases") { # Positive Cases MODAL
               showModal(modalDialog(
                 title = "What is the data source?",
                 p("xxxxxxxxxxx"),
                 p("xxxxxxxxxxxx") ,                                   
                 p("xxxxxxxxxxxxxxxx"),
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))
               
            # }

output$ContactTracing_explorer <- renderUI({
  
  tagList(h3("COVID-19 cases and testing among children and young people"),
          actionButton("btn_dataset_modal2", paste0("Data source: ", "ECOSS"), icon = icon('question-circle')),
          plot_box("CONTACT TRACING", plot_output = "WeeklyContactTracing"))


})   

output$WeeklyContactTracing <- renderPlotly({plot_contacttrace_chart(ContactTracing, data_name = "ContactTracing")})

