#### Mobile Testing Units Tab
#################################### Functions##################################

# HEATMAP

plot_mtu_heatmap <- function(){

ggplotly(mtu %>% group_by(test_centre_name, `Test Centre`, date) %>%
           summarise(value = sum(value, na.rm = TRUE)) %>%
           ungroup() %>%
           mutate(value = if_else(value == 0, NA_real_, value)) %>%
           rename(Date = date, 
                  `Number of Tests` = value,
                  `Test Centre Name` = test_centre_name) %>%
           
           ggplot(aes(Date, `Test Centre Name`, fill= `Number of Tests`)) + 
           geom_tile() +
           theme_minimal()+
           theme(axis.title.y = element_blank(),
                 legend.position = "bottom")+
           scale_fill_gradient(low = "#ebb7e6", high = "#9B4393", na.value = "lightgrey")) %>%     
           
           #Layout
  layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
         yaxis = yaxis_plots, xaxis = xaxis_plots,
         legend = list(x = 100, y = 0.5)) %>% #position of legend
  # leaving only save plot button
  config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 

}

plot_mtu_totals <- function(){
  
  tooltip_trend <- glue("Test Centre: {mtu_totals$test_centre_name}<br>",
                        "Symptomatic/ Asymptomatic: {mtu_totals$flag_covid_symptomatic}<br>",
                        "Count: {mtu_totals$total_tests_taken}<br>")
  
  
  mtu_totals %>% 
    plot_ly(x = ~test_centre_name, y = ~total_tests_taken) %>% 
    add_bars(color = ~flag_covid_symptomatic, #colour group
             colors = pal_mtu, #palette
             stroke = I("black"), #outline
             text = tooltip_trend, 
             hoverinfo = "text") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "group") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
  
}

output$mtu_lookup_table <- renderTable({
  mtu_lookup
})

### Summary points objects
append_date_suffix <- function(dates){
  dayy <- day(dates)
  suff <- case_when(dayy %in% c(11,12,13) ~ "th",
                    dayy %% 10 == 1 ~ 'st',
                    dayy %% 10 == 2 ~ 'nd',
                    dayy %% 10 == 3 ~'rd',
                    TRUE ~ "th")
  paste0(dayy, suff)
}

mtu_end <- paste(append_date_suffix(mtu_key_points$`Date End`),
                 month(mtu_key_points$`Date End`,label = TRUE, abbr = FALSE),
                 year(mtu_key_points$`Date End`))
n_mtu <- format(mtu_key_points$`Number of Tests`, big.mark = ",")
mtu_pos <- paste0(mtu_key_points$`Percent Positive`, "%")
n_mtu_as <- format(mtu_key_points$`Number Asymptomatic`, big.mark = ",")
mtu_as_pos <- paste0(mtu_key_points$`Percent Asymptomatic Positive`, "%")
n_mtu_s <- format(mtu_key_points$`Number Symptomatic`, big.mark = ",")
mtu_s_pos <- paste0(mtu_key_points$`Percent Symptomatic Positive`, "%")


##################################### RENDER UI ################################

output$MTUOutputs <-renderUI({

  if(paste(input$MTU_select) == "heatmap"){
    tagList(h3("Overall Numbers of Tests Over Time"),
            p("Numbers of tests carried out over time through each Mobile Testing Unit."),
            plot_box("", plot_output = "mtu_heatmap"))
  }else if(paste(input$MTU_select) == "data"){
    tagList(h3("Numbers of Tests Over Time"),
            p("Numbers of tests carried out over time through each Mobile Testing Unit. Data are broken down by symptomatic/ asymptomatic testing."),
            downloadButton('download_mtu_data', 'Download data'),
            dataTableOutput("mtu_data"))
  }else if(paste(input$MTU_select) == "cumul_totals"){
    tagList(h3("Total Numbers of Tests"),
            p("Total Numbers of tests carried out through each Mobile Testing Unit."),
            plot_box("", plot_output = "mtu_totals"))
  }else if(paste(input$MTU_select) == "summary"){
    tagList(h3("Targeted Community Testing Summary"),
            
            p("From 18th January to ", mtu_end, "Mobile Testing Units carried out:"),
            tags$ul(
              tags$li(n_mtu, "tests, of which", mtu_pos, "were positive."),
              tags$li(n_mtu_as, "asymptomatic tests, of which", mtu_as_pos, "were positive."),
              tags$li(n_mtu_s, "symptomatic tests, of which", mtu_s_pos, "were positive.")),
                    
              br(),
              p("The 8 Mobile Testing Units are detailed in the table below."),
              tableOutput("mtu_lookup_table")
              
            )
  }
})

output$mtu_heatmap <- renderPlotly({plot_mtu_heatmap()})
output$mtu_data <- renderDataTable({
  data <- mtu %>%
    select(`Test Centre`, `Test Centre Name` = test_centre_name,
           `Symptomatic COVID-19` = flag_covid_symptomatic,
           Date = date, `Number of Tests` = value)

  
  DT::datatable(data, style = 'bootstrap',
                class = 'table-bordered table-condensed',
                rownames = FALSE,
                options = list(pageLength = 15,
                               dom = 'tip',
                               autoWidth = TRUE),
                filter = "top")
})
output$mtu_totals <- renderPlotly({plot_mtu_totals()})



#### download
mtu_data_download <- reactive({
  mtu %>%
    select(`Test Centre`, `Test Centre Name` = test_centre_name,
           `Symptomatic COVID-19` = flag_covid_symptomatic,
           Date = date, `Number of Tests` = value)
})

output$download_mtu_data <- downloadHandler(
  filename ="MTU_Data.csv",
  content = function(file) {
    write_csv(mtu_data_download(),
              file)
  })
