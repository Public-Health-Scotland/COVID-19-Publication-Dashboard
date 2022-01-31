
# Modal -------------------------------------------------------------------

observeEvent(input$btn_dataset_modal3,

               showModal(modalDialog(
                 title = "What is the data source?",
                 p("Case Management System"),
                 p("Contacting Tracing data is extracted from the Case management System on the Sunday at 8pm prior to publication. ") ,
                 size = "m",
                 easyClose = TRUE, fade=FALSE,footer = modalButton("Close (Esc)"))))


# Chart -------------------------------------------------------------------

output$Setting_explorer <- renderUI({

   tagList(
          actionButton("btn_dataset_modal3", paste0("Data source: Data source: Case Management System"), icon = icon('question-circle')))

  # Charts and rest of UI
  if (input$Setting_select == "All setting types") { #
    tagList(h3("Settings"),
            actionButton("btn_dataset_modal3", paste0("Data source: Case Management System"), icon = icon('question-circle')),
      plot_box("Cases by setting type", plot_output = "SettingType"),
     h4("Data Table"),
     dataTableOutput("setting_table")
    )


  }  else if (input$Setting_select != "All setting types" ) { # drill down to setting locations
    tagList(h3("Settings"),
            actionButton("btn_dataset_modal3", paste0("Data source: Case Management System"), icon = icon('question-circle')),
    p("Single click on an item in the legend to remove it from the plot."),
    p("Double click on an item in the legend to view only that line."),
    plot_box("Cases by setting location", plot_output = "SettingLocation"),
    h4("Data Table"),
    dataTableOutput("setting_table")
    )
  }
})

output$SettingType <- renderPlotly({plot_settings_chart(Settings, data_name = "Settings", settingdata = "Type")})
output$SettingLocation <- renderPlotly({plot_settings_chart(Settings, data_name = "Settings", settingdata = "Location")})

## Data view -----

output$setting_table <- DT::renderDataTable({

  Settings %<>% dplyr::rename("Week Ending" = "week_ending")

  datatab_table(Settings, add_separator_cols = 4)

})


## Data downloads ----

Settings_data_download <- reactive({
  Settings
})
# For the charts at the moment the data download is for the overall one,
output$download_setting_data <- downloadHandler(
  filename ="data_extract.csv",
  content = function(file) {
    write_csv(Settings_data_download(),
              file)
    })



