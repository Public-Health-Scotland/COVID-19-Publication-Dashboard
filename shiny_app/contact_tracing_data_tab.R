

## Reactive data ----

##reactive data to show in app
CTdata_table <- reactive({  # Change dataset depending on what user selected

  table_data <- switch(input$CTdata_select,
                       "ContactTime" = ContactTime,
                       "ContactEC" = ContactEC,
                       "ContactWeeklyCases" = ContactWeeklyCases,
                       "ContactTracingWeeklyCumulative" = ContactTracingWeeklyCumulative,
                       "ContactTracingTestingPositive" = ContactTracingTestingPositive,
                       "ContactTracingFail" = ContactTracingFail,
                       "ContactTracingRegions" = ContactTracingRegions,
                       "ProximityApp" = ProximityApp)

  if (input$CTdata_select %in% c("ContactTime")) {

    table_data <- table_data %>%

      dplyr::rename("Week ending" = "week_ending")



  }


table_data %>%
    mutate_if(is.numeric, round, 1) %>%
    mutate_if(is.character, as.factor)
})

## UI ----
output$CT_Data_Tab_table <- renderUI({
  if(input$CTdata_select == "ContactEC"){
    tagList(
      p(strong("Information on COVID-19 in children and young people of educational age, education staff and educational settings is now presenting in the",
               tags$a("COVID-19 Education Surveillance dashboard.",
                      href = "https://publichealthscotland.scot/our-areas-of-work/covid-19/covid-19-data-and-intelligence/enhanced-surveillance-of-covid-19-in-education-settings/covid-19-education-surveillance-dashboard/", target="blank_"),
               "This includes data previously shown here on the proportion of positive cases reporting their occupation sector as “education and childcare” during the contact tracing process."))
    )
  } else {
    tagList(p("Please note this includes individuals with no information on their Health Board of residence and from elsewhere in the UK.
        We are aware of a higher number of these records in week ending 20th December.
        This is under investigation, and any revision will be updated in subsequent publications."),

            if(input$CTdata_select == "ContactTime") {
              strong("")
              },


  DT::dataTableOutput("CTtable_filtered"))
  }
})

###############################################.
## Table ----

output$CTtable_filtered <- DT::renderDataTable({


  datatab_table(CTdata_table(),
                add_separator_cols = table_params_CTdata()$separator_cols,
                add_separator_cols_1dp = table_params_CTdata()$separator_cols_1dp,
                add_percentage_cols = table_params_CTdata()$percentage_cols,
                maxrows = table_params_CTdata()$maxrows
  ) # from functions_tables.R

})


table_params_CTdata <- reactive({
  separator_cols = switch(input$CTdata_select,

                           "ContactTime" = c(4),
                           "ContactWeeklyCases" = c(2,3,5,7,8,11:15),
                           "ContactTracingWeeklyCumulative" = c(2),
                           "ContactTracingTestingPositive" = c(2,3),
                           "ContactTracingFail" = c(3),
                           "ProximityApp" = c(2,3)
  )
  separator_cols_1dp = switch(input$CTdata_select,

                              "ContactWeeklyCases" = c(16)

  )
  percentage_cols = switch(input$CTdata_select,

                           "ContactTime" = c(5),
                           "ContactWeeklyCases" = c(4,6,8,10),
                           "ContactTracingTestingPositive" = c(4)
  )
  maxrows = switch(input$CTdata_select,

                   "ContactTime" = 6,
                   "ContactTracingWeeklyCumulative" = 11,
                   "ContactTracingFail" = 7
  )

  list("separator_cols" = separator_cols,
       "separator_cols_1dp" = separator_cols_1dp,
       "percentage_cols" = percentage_cols,
       "maxrows" = maxrows)

})



###############################################.
## Data downloads ----

# Data download of data table.
output$CTdownload_table_csv <- downloadHandler(
  filename ="CTdata_extract.csv",
  content = function(file) {
    # This downloads only the data the user has selected using the table filters
    write_csv(CTdata_table()[input[["CTtable_filtered_rows_all"]], ], file)
  }
)
