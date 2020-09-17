
# Functions for server side

###############################################.
# Function that creates line trend charts in Plotly for different splits: age, sex, SIMD 
# Three parameters: pal_chose - what palette of colours you want
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
                           data_name == "NHS24" ~ "Number of NHS24 contacts")
  
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  measure_name <- case_when(data_name == "LabCases" ~ "Number of Cases: ",
                            data_name == "Admissions" ~ "Admissions: ",
                            data_name == "ICU" ~ "ICU admissions: ",
                            data_name == "NHS24" ~ "NHS24 Contacts: ")
  
  #Text for tooltip
  tooltip_trend <- c(paste0("Date: ", format(trend_data$Date, "%d %b %y"),
                            "<br>", measure_name, trend_data$Count,
                            "<br>", "7 Day Average: ", trend_data$Average7))
  
  #Creating time trend plot
  plot_ly(data = trend_data, x = ~Date) %>%
    add_lines(y = ~Count, line = list(color = pal_overall[1]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Count") %>%
    add_lines(y = ~Average7, line = list(color = pal_overall[2], dash = 'dash'),
              text = tooltip_trend, hoverinfo = "text",
              name = "7 Day Average") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
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
  yaxis_title <- case_when(data_name == "NHS24" ~ "Number of COVID-19 related Contacts")
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  measure_name <- case_when(data_name == "NHS24" ~ "NHS24 Contacts: ")
  
  #Text for tooltip
  tooltip_trend <- c(paste0("Date: ", format(trend_data$Date, "%d %b %y"),
                            "<br>", "Number of NHS24 contacts: ", trend_data$Count,
                            "<br>", "Number of calls to helpline: ", trend_data$CoronavirusHelpline))
  
  #Creating time trend plot
  plot_ly(data = trend_data, x = ~Date) %>%
    add_lines(y = ~Count, line = list(color = pal_overall[1]),
              text = tooltip_trend, hoverinfo="text",
              name = "NHS24 contacts") %>%
    add_lines(y = ~CoronavirusHelpline, line = list(color = pal_overall[2]),
              text = tooltip_trend, hoverinfo="text",
              name = "Coronavirus Helpline") %>%
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
  yaxis_title <- case_when(data_name == "SAS" ~ "Number of SAS incidents (suspected COVID-19)")
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  measure_name <- case_when(data_name == "SAS" ~ "Number of SAS incidents: ")
  
  #Text for tooltip
  tooltip_trend <- c(paste0("Date: ", format(trend_data$Date, "%d %b %y"),
                            "<br>", "All suspected COVID-19 incidents: ", trend_data$`Suspected Covid - All`,
                            "<br>", "Attended suspected COVID-19 incidents: ", trend_data$`Suspected Covid - Attended`,
                            "<br>", "Conveyed syspected COVID-19 incidents: ", trend_data$`Suspected Covid - Conveyed`))
  
  #Creating time trend plot
  plot_ly(data = trend_data, x = ~Date) %>%
    add_lines(y = ~`Suspected Covid - All`, line = list(color = pal_overall[1]),
              text = tooltip_trend, hoverinfo = "text",
              name = "All suspected COVID-19") %>%
    add_lines(y = ~`Suspected Covid - Attended`, line = list(color = pal_overall[2]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Attended suspected COVID-19") %>%
    add_lines(y = ~`Suspected Covid - Conveyed`, line = list(color = pal_overall[3]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Conveyed suspected COVID-19") %>%
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
  plot_ly(data = trend_data, x = ~Date) %>%
    add_lines(y = ~`CountAdvice`, line = list(color = pal_overall[1]),
              text = tooltip_trend, hoverinfo="text",
              name = "Advice") %>%
    add_lines(y = ~trend_data$CountAssessment, line = list(color = pal_overall[2]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Assessments") %>%
    add_lines(y = ~trend_data$CountOther, line = list(color = pal_overall[3]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Other") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
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
     } else { 
    dataset %>% 
      filter(category == "All")
  }
}


######################################################################.
#Function to create plot when no data available
plot_nodata <- function(height_plot = 450, text_nodata = "Data not available") {
  text_na <- list(x = 5, y = 5, text = text_nodata , size = 20,
                  xref = "x", yref = "y",  showarrow = FALSE)
  
  plot_ly(height = height_plot) %>%
    layout(annotations = text_na,
           #empty layout
           yaxis = list(showline = FALSE, showticklabels = FALSE, showgrid = FALSE, fixedrange=TRUE),
           xaxis = list(showline = FALSE, showticklabels = FALSE, showgrid = FALSE, fixedrange=TRUE),
           font = list(family = '"Helvetica Neue", Helvetica, Arial, sans-serif', size = 40)) %>% 
    config( displayModeBar = FALSE) # taking out plotly logo and collaborate button
} 

## Function for AgeSex charts ----

plot_agesex_chart <- function(dataset, data_name, yaxis_title, area = T) {
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset
  
  ###############################################.
  measure_name <- case_when(data_name == "LabCases_AgeSex" ~ "Cases",
                            data_name == "Admissions_AgeSex" ~ "Admissions",
                            data_name == "ICU_AgeSex" ~ "ICU admissions",
                            data_name == "NHS24_AgeSex" ~ "NHS24 contacts",
                            data_name == "SAS_AgeSex" ~ "SAS incidents",
                            data_name == "AssessmentHub_AgeSex" ~ "Individuals ")
  
  yaxis_title <- glue("{measure_name} per 100,000 population")
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  xaxis_plots[["title"]] <- "Age group"
  
  #remove unknowns from chart
  #make age_group an ordered factor
  trend_data <- trend_data %>% 
                  filter(sex != "unknown", age_group != "Unknown") %>% 
                  mutate(age_group = fct_inorder(age_group))
  
  #Text for tooltip
  tooltip_trend <- glue("Age group: {trend_data$age_group}<br>",
                        "Sex: {trend_data$sex}<br>",
                        "Count: {trend_data$number}<br>",
                        "{measure_name} per 100,000 population: {round(trend_data$rate, 2)}")
  
  #Creating age/sex plot
  trend_data %>% 
    plot_ly(x = ~age_group) %>%
    add_bars(y = ~rate,
             color = ~sex,
             colors = pal_sex,
             text = tooltip_trend,
             stroke = I("black"),
             hoverinfo = "text",
             name = ~sex) %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "group") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
}

## Function for SIMD charts ----

plot_simd_chart <- function(dataset, data_name, yaxis_title, area = T) {
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset
  
  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "LabCases_SIMD" ~ "Cases",
                           data_name == "Admissions_SIMD" ~ "Admissions",
                           data_name == "NHS24_SIMD" ~ "NHS24 contacts",
                           data_name == "AssessmentHub_SIMD" ~ "Individuals",
                           data_name == "SAS_SIMD" ~ "SAS incidents (suspected COVID-19)")
  
  yaxis_title <- paste0(yaxis_title, " by deprivation category (SIMD)")
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  xaxis_plots[["title"]] <- "Deprivation category (SIMD)"
  
  #remove unknowns from chart
  #make SIMD an ordered factor
  trend_data <- trend_data %>% 
                    filter(SIMD != "Unknown") %>% 
                    mutate(SIMD = fct_inorder(SIMD))  
  
  measure_name <- case_when(data_name == "LabCases_SIMD" ~ "cases",
                            data_name == "Admissions_SIMD" ~ "admissions",
                            data_name == "AssessmentHub_SIMD" ~ "individuals",
                            data_name == "NHS24_SIMD" ~ "NHS24 contacts",
                            data_name == "SAS_SIMD" ~ "SAS incidents")

  tooltip_trend <- glue("Deprivation category: {trend_data$SIMD}<br>",
                        "Count: {trend_data$cases}<br>",
                        "Percent of {measure_name}: {round(trend_data$cases_pc, 2)}")
  
  #Creating SIMD plot
  trend_data %>% 
    plot_ly(x = ~SIMD, y = ~cases) %>% 
    add_bars(color = ~SIMD, #colour group
             colors = pal_simd, #palette
             stroke = I("black"), #outline
             text = tooltip_trend, 
             hoverinfo = "text",
             name = ~SIMD) %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "group") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
}


## Function for other charts -----------------------------------------------


plot_singletrace_chart <- function(dataset, data_name, yaxis_title, area = T) {
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset
  
  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "NHS24_inform" ~ "Number of hits",
                           data_name == "SAS_all" ~ "Number of SAS incidents")
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  measure_name <- case_when(data_name == "NHS24_inform" ~ "COVID-19 section of NHS Inform: ",
                            data_name == "SAS_all" ~ "SAS incidents: ")
  
  #Text for tooltip
  tooltip_trend <- glue("Date: {format(trend_data$date, '%d %b %y')}<br>",
                        "{measure_name}: {trend_data$count}")
  
  #Creating time trend plot
  plot_ly(data = trend_data, x = ~date) %>%
    add_lines(y = ~count, line = list(color = pal_overall[1]),
              text = tooltip_trend, hoverinfo = "text") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
}

plot_nhs24_selfhelp_chart <- function(dataset, data_name, yaxis_title, area = T) {
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset
  
  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "NHS24_selfhelp" ~ "Number of self help guides completed")
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  measure_name <- case_when(data_name == "NHS24_selfhelp" ~ "Number of self help guides completed: ")
  
  #Text for tooltip
  tooltip_trend <- glue("Date: {format(trend_data$Date, '%d %b %y')}<br> ",
                        "Self help guides completed: {trend_data$selfhelp}<br>",
                        "Users advised to isolate: {trend_data$isolate}")
  
  #Creating time trend plot
  plot_ly(data = trend_data, x = ~Date) %>%
    add_lines(y = ~selfhelp, line = list(color = pal_overall[1]),
              text = tooltip_trend, hoverinfo = "text",
              name = "NHS24 self help guides") %>%
    add_lines(y = ~isolate, line = list(color = pal_overall[2]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Users advised to isolate") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
}

plot_nhs24_community_chart <- function(dataset, data_name, yaxis_title, area = T) {
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset
  
  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "NHS24_community" ~ "Number of NHS24 COVID-19 records")

  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title

  measure_name <- case_when(data_name == "NHS24_community" ~ "NHS24 community outcomes")
  
  #make factor
  trend_data <- trend_data %>% mutate(#date = fct_inorder(date),
                                      outcome = fct_inorder(outcome))

  #Text for tooltip
  tooltip_trend <- glue("Date: {trend_data$date}<br>",
                      "{trend_data$outcome}: {trend_data$count}")
 
  #Creating community hub plot
  trend_data %>% 
    plot_ly(x = ~date, y = ~count) %>% 
    add_bars(color = ~outcome, #colour group
             colors = pal_comm, #palette
             stroke = I("black"), #outline
             text = tooltip_trend, 
             hoverinfo = "text",
             name = ~outcome) %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "stack") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
}

### END