#### Mobile Testing Units Tab
#################################### Functions##################################


rb_choices <- list("Number of Tests" = "total_tests",
                   "Number of Positive Tests" = "positive_tests",
                   "Number of Symptomatic Tests" = "symptomatic",
                   "Number of Asymptomatic Tests" = "asymptomatic",
                   "Number of Tests via MTUs" = "mtu_tests",
                   "Number of Tests via ATSs" = "ats_tests" )

# HEATMAP


plot_mtu_heatmap <- function(){
  
  data <- mtu_heatmap_data %>% 
    dplyr::rename(`Number of Tests` = total_tests,
           `Test Centre Name` = test_centre) %>%
    arrange(`Test Centre Name`)
  
  n_weeks <- unique(data$week_ending_label) %>% length()
  n_tc <- unique(data$`Test Centre Name`) %>% length()
  
  tooltip_ <- paste("Test Centre:", data$`Test Centre Name`, "<br>",
                    "Week Ending:", data$week_ending_label, "<br>",
                    "Total Tests:", format(replace_na(data$`Number of Tests`,0), big.mark = ","))
  tooltip_ <- matrix(tooltip_, nrow = n_tc, ncol = n_weeks, byrow = TRUE)
  
p <- ggplotly(ggplot(data, 
                aes(week_ending, `Test Centre Name`,fill= `Number of Tests`)) + 
           geom_tile() +
           theme_minimal()+
           theme(axis.title.y = element_blank(),
                 legend.position = "bottom")+
           scale_fill_gradient(low = "#ebb7e6", high = "#9B4393", na.value = "lightgrey"),
         
         height =   20*n_tc-1) %>%     
           
           #Layout
  layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
         yaxis = yaxis_plots, xaxis = xaxis_plots,
         legend = list(x = 100, y = 0.5)) %>% #position of legend
  # leaving only save plot button
  config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 

p$x$data[[1]]$text <- tooltip_
p
}

### Time series
plot_all_mtu_ts <- function(plot_var) {
  
  yaxis_title <- names(rb_choices)[which(paste(plot_var) == rb_choices)]
  
  trend_data <- mtu_ts_data %>%
    filter(hb2019name == "All") %>%
    dplyr::rename(date = week_ending, value = paste(plot_var))

  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  #Text for tooltip
  tooltip_trend <- c(paste0("Week Ending: ", trend_data$week_ending_label,
                            "<br>",yaxis_title, ": ", 
                            format(trend_data$value, big.mark = ",")))
  
  trend_data <- mutate(trend_data,value = ifelse(value == "*", 0, as.numeric(value)))
  
  #Creating time trend plot
  plot_ly(data = trend_data, x = ~date) %>%
    add_lines(y = ~value, line = list(color = pal_ETH[1]),
              text = tooltip_trend, hoverinfo="text",
              name = "All Test Centres") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
}

plot_mtu_totals <- function(){
  
  tooltip_trend <- glue("Health Board: {mtu_cumul_symp$`Health Board`}<br>",
                        "Symptomatic/ Asymptomatic: {mtu_cumul_symp$name}<br>",
                        "Count: {mtu_cumul_symp$value}<br>")
  
  
  mtu_cumul_symp %>% 
    plot_ly(x = ~`Health Board`, y = ~value) %>% 
    add_bars(color = ~name, #colour group
             colors = pal_mtu, #palette
             stroke = I("black"), #outline
             text = tooltip_trend, 
             hoverinfo = "text") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = c(xaxis_plots,tickangle = -45),
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "group") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
  
}

plot_mtu_test_centre_type <- function(){
  
  tooltip_trend <- glue("Health Board: {mtu_cumul_site$`Health Board`}<br>",
                        "Testing Site Type: {mtu_cumul_site$name}<br>",
                        "Count: {mtu_cumul_site$value}<br>")
  
  
  mtu_cumul_site %>% 
    plot_ly(x = ~`Health Board`, y = ~value) %>% 
    add_bars(color = ~name, #colour group
             colors = c("#3393DD", "#83BB26"), #palette
             stroke = I("black"), #outline
             #text = tooltip_trend
             hovertemplate = tooltip_trend, 
             hoverinfo = "text") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = c(xaxis_plots,tickangle = -45),
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "group") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
  
}

plot_mtu_positives <- function(){
  plot_data <- mtu_cumul_pos %>% filter(positive_tests != "*") %>%
    mutate(label = paste0(percent_positive, "%"),
           percent_positive = as.numeric(percent_positive)/100)
  
  tooltip_trend <- glue("Health Board: {plot_data$`Health Board`}<br>",
                        "Total Tests Carried Out: {format(plot_data$total_tests, big.mark = ',')}<br>",
                        "Percent Positive: {plot_data$label}<br>  <extra></extra> ")
  
  plot_data %>% 
    
    plot_ly(x = ~`Health Board`, y = ~percent_positive) %>% 
    add_bars(colors = pal_mtu, #palette
             stroke = I("black"),  #outline
           # text = tooltip_trend, 
             hovertemplate = tooltip_trend) %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = c(yaxis_plots, tickformat = ",.0%"),
           xaxis = c(xaxis_plots,tickangle = -45)) %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 

  }

#### 

#HBs <- mtu_ts_data$hb2019name %>% unique()


##################################### RENDER UI ################################

output$MTUOutputs <-renderUI({

  if(paste(input$MTU_select) == "heatmap"){
    tagList(h3("Overall Numbers of Tests Over Time"),
            p("Total Numbers of tests carried out over time. Please note that figures for the latest week of data are complete to the Monday only and are marked 'p' for provisional."),
            radioButtons("mtu_measure_select_ts", "Select Measure", 
                         choices = rb_choices, inline = TRUE),
            plot_box("", plot_output = "mtu_time_series"),
            h3("Numbers of Tests Over Time by Testing Site"),
            p("Numbers of tests carried out over time through each Test Centre. Please note that figures for the latest week of data are complete to the Monday only and are marked 'p' for provisional."),
            plot_box("", plot_output = "mtu_heatmap"))
  }else if(paste(input$MTU_select) == "data"){
    tagList(h3("Numbers of Tests Over Time"),
            p("Numbers of tests carried out over time through each Test Centre. Please note that figures for the latest week of data are complete to the Monday only and are marked 'p' for provisional."),
            downloadButton('download_mtu_data', 'Download data'),
            DT::dataTableOutput("mtu_data"),
            
            h3("Numbers of Tests Over Time by Test Site Type"),
            p("Numbers of tests carried out through each Test Site Type by Health Board."),
            downloadButton('download_mtu_data3', 'Download data'),
            DT::dataTableOutput("mtu_data3"),
            
            h3("Percent of Tests which had a Positive Result"),
            p("Total numbers of tests carried out and percent positive by Health Board."),
            downloadButton('download_mtu_data2', 'Download data'),
            DT::dataTableOutput("mtu_data2"))
    
  }else if(paste(input$MTU_select) == "cumul_totals"){
    tagList(h3("Total Numbers of Tests"),
            p("Total Numbers of tests carried out by Health Board."),
            plot_box("", plot_output = "mtu_totals"),
            p("Total Numbers of tests carried out by MTUs and ATSs in each Health Board."),
            plot_box("", plot_output = "mtu_test_sites"),
            h3("Percent of Tests with a Positive Result"),
            p("The percent of all tests (symptomatic and asymptomatic) which had a positive result by Health Board."),
            plot_box("", plot_output = "mtu_positives"))
  # }else if(paste(input$MTU_select) == "details"){
  #   tagList(h3("Test Centres"),       
  #            p("The Mobile Testing Units and their deployment dates are detailed in the table below."),
  #            tableOutput("mtu_lookup_table"))
  } else if(paste(input$MTU_select == "summary")){
      
    parse_mtu_key_points()
            
  }
})


output$mtu_heatmap <- renderPlotly({plot_mtu_heatmap()})
output$mtu_time_series <- renderPlotly({plot_all_mtu_ts(plot_var = input$mtu_measure_select_ts)})

output$mtu_data <- renderDataTable({
  
  byboard_data_table((mtu_heatmap_data2 %>% 
                        select(`Week Ending`, `NHS Board`, `Test Centre`, `Number of Tests`)),
                     "NHS Board",  # Name of the column with board names e.g. "NHS Board"
                     add_separator_cols=c(4))

})
output$mtu_totals <- renderPlotly({plot_mtu_totals()})
output$mtu_test_sites <- renderPlotly({plot_mtu_test_centre_type()})
output$mtu_positives <- renderPlotly({plot_mtu_positives()})

## Positive tests
output$mtu_data2 <- renderDataTable({
  
  tab_to_view <- mtu_cumul_pos %>% 
    mutate(`Percent Positive` = if_else(positive_tests == "*", "*", paste0(percent_positive, "%"))) %>% 
    select(`Health Board`, `Total Tests` = total_tests, `Positive Tests` = positive_tests, `Percent Positive`)
  
  byboard_data_table(tab_to_view,
                     "Health Board",  # Name of the column with board names e.g. "NHS Board"
                     add_separator_cols=c(2,3),
                     flip_order=TRUE)
})

output$mtu_data3 <- renderDataTable({
  
  byboard_data_table((mtu_cumul_site %>% 
                        pivot_wider(names_from = name, values_from = value)),
                     "Health Board",  # Name of the column with board names e.g. "NHS Board"
                     add_separator_cols=c(2,3),
                     flip_order=TRUE)
  
})


#### download

output$download_mtu_data <- downloadHandler(
  filename ="MTU_Data.csv",
  content = function(file) {
    write_csv(mtu_heatmap_data2,
              file)
  })

output$download_mtu_data3 <- downloadHandler(
  filename ="MTU_Data.csv",
  content = function(file) {
    write_csv((mtu_cumul_site %>% 
                 pivot_wider(names_from = name, values_from = value)),
              file)
  })


output$download_mtu_data2 <- downloadHandler(
  filename ="MTU_Data.csv",
  content = function(file) {
    write_csv((mtu_cumul_pos %>% 
                 mutate(`Percent Positive` = if_else(positive_tests == "*", "*", paste0(percent_positive, "%"))) %>% select(`Health Board`, `Total Tests` = total_tests, `Positive Tests` = positive_tests, `Percent Positive`)),
              file)
  })