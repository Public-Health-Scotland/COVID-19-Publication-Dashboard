

## Reactive data ----

##reactive data to show in app
CTdata_table <- reactive({  # Change dataset depending on what user selected

  table_data <- switch(input$CTdata_select,
                      # "ContactTracing" = ContactTracing,
                       "ContactTime" = ContactTime,
                       "ContactEC" = ContactEC,
                       "ContactWeeklyCases" = ContactWeeklyCases,
                       "ContactTracingWeeklyCumulative" = ContactTracingWeeklyCumulative,
                       "ContactTracingTestingPositive" = ContactTracingTestingPositive,
                       "ContactTracingFail" = ContactTracingFail,
                       "ContactTracingRegions" = ContactTracingRegions,
                       "ProximityApp" = ProximityApp)
                       #"ContactTracingDemoAge" = ContactTracingDemoAge,
                       #"ContactTracingDemoSex" = ContactTracingDemoSex,
                       #"ContactTracingDemoSIMD" = ContactTracingDemoSIMD,
                       #"ContactTracingAveragesAge" = ContactTracingAveragesAge)
                       #"ContactTracingAverages" = select(ContactTracingAverages, -`Age Band`))

  # if (input$data_select %in% c("ContactTracing")) {
  #   table_data <- table_data
  # 
  # } else if (input$data_select %in% "ContactTime") {
  #   table_data <- table_data
  # }

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
  
  # Remove the underscore from column names in the table
  table_colnames  <-  gsub("_", " ", colnames(CTdata_table()))

  DT::datatable(CTdata_table(), style = 'bootstrap',
                class = 'table-bordered table-condensed',
                rownames = FALSE,
                options = list(pageLength = 20,
                               dom = 'tip',
                               autoWidth = TRUE),
                filter = "top",
                colnames = table_colnames)
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
