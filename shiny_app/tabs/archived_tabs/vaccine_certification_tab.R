#### Vaccine Tab

output$vaccine_cert_table <- DT::renderDataTable({

  datatab_table(VaccineCertification,
                maxrows=20,
                order_by_firstcol = NULL,
                add_separator_cols = c(2) # with , separator and 0dp
  )
})


## Data downloads ----

vaccine_cert_download <- reactive({
  VaccineCertification
})

# For the charts at the moment the data download is for the overall one,
output$download_vaccine_cert_data <- downloadHandler(
  filename ="VaccineCertification.csv",
  content = function(file) {
    write_csv(vaccine_cert_download(),
              file)
  })

