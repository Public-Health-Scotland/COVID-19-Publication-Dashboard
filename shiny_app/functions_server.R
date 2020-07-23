
# Functions for server side

###############################################.
# Function that creates line trend charts in Plotly for different splits: age, sex, depr, condition
# THree parameters: pal_chose - what palette of colours you want
# dataset - what data to use for the chart formatted as required

## Function for overall charts ----

plot_overall_chart <- function(dataset, data_name, yaxis_title, area = T) {
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset
  
  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "LabCases" ~ "Number of positive cases",
                           data_name == "Admissions" ~ "Number of admissions",
                           data_name == "ICU" ~ "Number of ICU admissions", 
                           data_name == "NHS24" ~ "Number of NHS24 calls")
  
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  measure_name <- case_when(data_name == "LabCases" ~ "Number of Cases: ",
                            data_name == "Admissions" ~ "Admissions: ",
                            data_name == "ICU" ~ "ICU admissions: ",
                            data_name == "NHS24" ~ "NHS24 Calls: ")
  
  #Text for tooltip
  tooltip_trend <- c(paste0("Date: ", format(trend_data$Date, "%d %b %y"),
                            "<br>", measure_name, trend_data$Count,
                            "<br>", "7 Day Average: ", trend_data$Average7))
  
  #Creating time trend plot
  plot_ly(data=trend_data, x=~Date) %>%
    add_lines(y = ~Count, line = list(color = pal_overall[1]),
              text=tooltip_trend, hoverinfo="text",
              name = "Count") %>%
    add_lines(y = ~Average7, line = list(color = pal_overall[2], dash = 'dash'),
              text=tooltip_trend, hoverinfo="text",
              name = "7 Day Average") %>%
    #Layout
    layout(margin = list(b = 80, t=5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
  }


## Function for NHS24 chart ----

plot_overall_chartNHS24 <- function(dataset, data_name, yaxis_title, area = T) {
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset
  
  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "NHS24" ~ "Number of NHS24 calls")
  
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  measure_name <- case_when(data_name == "NHS24" ~ "NHS24 Calls: ")
  
  #Text for tooltip
  tooltip_trend <- c(paste0("Date: ", format(trend_data$Date, "%d %b %y"),
                            "<br>", "Number of calls to NHS24: ", trend_data$Count,
                            "<br>", "Number of calls to helpline: ", trend_data$CoronavirusHelpline))
  
  #Creating time trend plot
  plot_ly(data=trend_data, x=~Date) %>%
    add_lines(y = ~Count, line = list(color = pal_overall[1]),
              text=tooltip_trend, hoverinfo="text",
              name = "NHS24") %>%
    add_lines(y = ~CoronavirusHelpline, line = list(color = pal_overall[2]),
              text=tooltip_trend, hoverinfo="text",
              name = "Corona virus Helpline") %>%
    #Layout
    layout(margin = list(b = 80, t=5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
}


## Function for SAS chart ----

plot_overall_chartSAS <- function(dataset, data_name, yaxis_title, area = T) {
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset
  
  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "SAS" ~ "Number of SAS incidents")
  
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  measure_name <- case_when(data_name == "SAS" ~ "Number of SAS incidents: ")
  
  #Text for tooltip
  tooltip_trend <- c(paste0("Date: ", format(trend_data$Date, "%d %b %y"),
                            "<br>", "All suspected COVID-19 incidents: ", trend_data$`Suspected Covid - All`,
                            "<br>", "Attended suspected COVID-19 incidents: ", trend_data$`Suspected Covid - Attended`,
                            "<br>", "Conveyed syspected COVID-19 incidents: ", trend_data$`Suspected Covid - Conveyed`))
  
  #Creating time trend plot
  plot_ly(data=trend_data, x=~Date) %>%
    add_lines(y = ~`Suspected Covid - All`, line = list(color = pal_overall[1]),
              text=tooltip_trend, hoverinfo="text",
              name = "All") %>%
    add_lines(y = ~`Suspected Covid - Attended`, line = list(color = pal_overall[2]),
              text=tooltip_trend, hoverinfo="text",
              name = "Attended") %>%
    add_lines(y = ~`Suspected Covid - Conveyed`, line = list(color = pal_overall[3]),
              text=tooltip_trend, hoverinfo="text",
              name = "Conveyed") %>%
    #Layout
    layout(margin = list(b = 80, t=5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
}


## Function for Assessment Hubs chart ----

plot_overall_chartAssessmentHub <- function(dataset, data_name, yaxis_title, area = T) {
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset
  
  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "AssessmentHub" ~ "Number of consultations")
  
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  measure_name <- case_when(data_name == "AssessmentHub" ~ "Number of consultations: ")
  
  #Text for tooltip
  tooltip_trend <- c(paste0("Date: ", format(trend_data$Date, "%d %b %y"),
                            "<br>", "COVID-19 advice consultations: ", trend_data$CountAdvice,
                            "<br>", "COVID-19 assessment consultations: ", trend_data$CountAssessment,
                            "<br>", "COVID-19 other consultations: ", trend_data$CountOther))
  
  #Creating time trend plot
  plot_ly(data=trend_data, x=~Date) %>%
    add_lines(y = ~`CountAdvice`, line = list(color = pal_overall[1]),
              text=tooltip_trend, hoverinfo="text",
              name = "Advice") %>%
    add_lines(y = ~trend_data$CountAssessment, line = list(color = pal_overall[2]),
              text=tooltip_trend, hoverinfo="text",
              name = "Assessments") %>%
    add_lines(y = ~trend_data$CountOther, line = list(color = pal_overall[3]),
              text=tooltip_trend, hoverinfo="text",
              name = "Other") %>%
    #Layout
    layout(margin = list(b = 80, t=5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
}


## Function for filtering ----

# Function to filter the datasets for the overall charts and download data based on user input
filter_data <- function(dataset, area = T) {
  if (area == T) {
    dataset 
    # %>% filter(type == "sex") %>%
    #   filter(area_name == input$geoname &
    #            category == "All")
  } else { #this works for cath data
    dataset %>% 
      filter(category == "All")
  }
}



######################################################################.
#Function to create plot when no data available
plot_nodata <- function(height_plot = 450, text_nodata = "Data not available due to small numbers") {
  text_na <- list(x = 5, y = 5, text = text_nodata , size = 20,
                  xref = "x", yref = "y",  showarrow = FALSE)
  
  plot_ly(height = height_plot) %>%
    layout(annotations = text_na,
           #empty layout
           yaxis = list(showline = FALSE, showticklabels = FALSE, showgrid = FALSE, fixedrange=TRUE),
           xaxis = list(showline = FALSE, showticklabels = FALSE, showgrid = FALSE, fixedrange=TRUE),
           font = list(family = '"Helvetica Neue", Helvetica, Arial, sans-serif')) %>% 
    config( displayModeBar = FALSE) # taking out plotly logo and collaborate button
} 

### END