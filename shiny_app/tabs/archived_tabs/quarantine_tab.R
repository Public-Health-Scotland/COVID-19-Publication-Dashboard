#### Quarantine Data Tab

output$quarantine_table <- DT::renderDataTable({

  datatab_table(Quarantine,
                maxrows=20,
                highlight_column = "Week Ending",
                add_separator_cols = c(2:8) # with , separator and 0dp
)
})


## Data downloads ----

quarantine_download <- reactive({
  Quarantine
})

# For the charts at the moment the data download is for the overall one,
output$download_quarantine_data <- downloadHandler(
  filename ="Quarantine.csv",
  content = function(file) {
    write_csv(quarantine_download(),
              file)
  })

