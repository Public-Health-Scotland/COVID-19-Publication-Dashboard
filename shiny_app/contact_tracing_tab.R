# 
# # Modal -------------------------------------------------------------------
# 
# observeEvent(input$btn_dataset_modal2,
# 
#                showModal(modalDialog(
#                  title = "What is the data source?",
#                  p("xxxxxxxxxxx"),
#                  p("xxxxxxxxxxxx") ,
#                  p("xxxxxxxxxxxxxxxx"),
#                  size = "m",
#                  easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))
# 
# 
# # Chart -------------------------------------------------------------------
# 
# output$ContactTracing_explorer <- renderUI({
# 
#   tagList(h3("Contact Tracing"),
#           actionButton("btn_dataset_modal2", paste0("Data source: DATA SOURCE"), icon = icon('question-circle')),
#           plot_box("Number of individuals", plot_output = "WeeklyContactTracing"))
# })
# 
# output$WeeklyContactTracing <- renderPlotly({plot_contacttrace_chart(ContactTracing, data_name = "ContactTracing")})
# 
# ## Data downloads ----
# # For the charts at the moment the data download is for the overall one,
# output$download_CT_data <- downloadHandler(
#   filename ="data_extract.csv",
#   content = function(file) {
#     write_csv(ContactTracing(),
#               file)
#     })
