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
                            "<br>", "NHS24 Calls (COVID-19 Mention): ", trend_data$Count,
                            "<br>", "Number of calls to helpline: ", trend_data$CoronavirusHelpline))
  
  #Creating time trend plot
  plot_ly(data = trend_data, x = ~Date) %>%
    add_lines(y = ~Count, line = list(color = pal_overall[1]),
              text = tooltip_trend, hoverinfo="text",
              name = "NHS24 Calls (COVID-19 Mention)") %>%
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

plot_singlerate_chart <- function(dataset, data_name, yaxis_title, area = T) {
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset
  
  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "LabCases" ~ "Cumulative rate of positive cases per 100,000")
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  measure_name <- case_when(data_name == "LabCases" ~ "Cumulative rate of positive cases per 100,000")
  
  #Text for tooltip
  tooltip_trend <- glue("Date: {format(trend_data$Date, '%d %b %y')}<br>",
                        "{measure_name}: {trend_data$CumulativeRatePer100000}")
  
  #Creating time trend plot
  plot_ly(data = trend_data, x = ~Date) %>%
    add_lines(y = ~CumulativeRatePer100000, line = list(color = pal_overall[1]),
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


## Child Charts ------------------------------------------------------------

plot_overall_chartChild <- function(dataset, data_name, childdata, yaxis_title, area = T) {
  
  #Filtering dataset to include only overall figures
  
  
  yaxis_title <- case_when(childdata == "ChildPositive" ~ "Number of patients tested positive",
                           childdata == "ChildNegative" ~"Number of patients tested negative" ,
                           childdata == "ChildPer" ~ "% of patients testing positive")
  
  trend_data <- dataset %>% 
    filter(Indicator == yaxis_title)  
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  #Text for tooltip
  tooltip_trend <- c(paste0("Week ending: ", format(trend_data$`Week ending`, "%d %b %y"),
                            "<br>",yaxis_title, " aged 2-4: ", trend_data$`Age 2 - 4`,
                            "<br>",yaxis_title, " aged 5-11: ", trend_data$`Age 5 - 11`,
                            "<br>",yaxis_title, " aged 12-13: ", trend_data$`Age 12 - 13`,
                            "<br>",yaxis_title, " aged 14-15: ", trend_data$`Age 14 - 15`,
                            "<br>",yaxis_title, " aged 16-17: ", trend_data$`Age 16 - 17`,
                            "<br>",yaxis_title, " aged 18-19: ", trend_data$`Age 18 - 19`,
                            "<br>",yaxis_title, " for all children and young people (aged 2-19): ", trend_data$`All children and young people aged 2-19`))
  
  #Creating time trend plot
  plot_ly(data = trend_data, x = ~`Week ending`) %>%
    add_lines(y = ~`Age 2 - 4`, line = list(color = pal_child[1]),
              text = tooltip_trend, hoverinfo="text",
              name = "Age 2-4") %>%
    add_lines(y = ~trend_data$`Age 5 - 11`, line = list(color = pal_child[2]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Age 5-11") %>%
    add_lines(y = ~trend_data$`Age 12 - 13`, line = list(color = pal_child[3]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Age 12-13") %>%
    add_lines(y = ~trend_data$`Age 14 - 15`, line = list(color = pal_child[4]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Age 14-15") %>%
    add_lines(y = ~trend_data$`Age 16 - 17`, line = list(color = pal_child[5]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Age 16-17") %>%
    add_lines(y = ~trend_data$`Age 18 - 19`, line = list(color = pal_child[6]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Age 18-19") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove ) 
}


## Contact Tracing Charts --------------------------------------------------
# % stacked bar charts
plot_contacttrace_Per_chart <- function(dataset, data_name, CTdata, yaxis_title, area = T) {
  
  yaxis_title <- case_when(CTdata == "TestIndex" ~ "Test to index created",
                           CTdata == "TestInterview" ~ "Test to interview completed" ,
                           CTdata == "CaseInterview" ~ "Case created to interview completed",
                           CTdata == "CaseClose" ~ "Case created to case closed")
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset %>% 
    filter(Measure == yaxis_title) %>% 
    mutate(`Hours taken` = fct_inorder(`Hours taken`))
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  #Text for tooltip
  tooltip_trend <- glue("{trend_data$Measure}<br>",
                        "Week ending: {trend_data$week_ending}<br>",
                        "{trend_data$`Hours taken`} hours: {trend_data$`Number of Index Cases`} cases ({trend_data$`% of Total Index Cases`}%)")
  
  #Creating contact tracing time
  trend_data %>%
    plot_ly(x = ~week_ending, y = ~`% of Total Index Cases`) %>%
    add_bars(color = ~`Hours taken`, #colour group
             colors = pal_CT, #palette
             stroke = I("black"), #outline
             text = tooltip_trend,
             hoverinfo = "text",
             name = ~`Hours taken`) %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "stack") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )
  
}

# cases stacked bar chart
plot_contacttrace_chart <- function(dataset, data_name, CTdata, yaxis_title, area = T) {
  
  yaxis_title <- case_when(CTdata == "TestIndex" ~ "Test to index created",
                           CTdata == "TestInterview" ~ "Test to interview completed" ,
                           CTdata == "CaseInterview" ~ "Case created to interview completed",
                           CTdata == "CaseClose" ~ "Case created to case closed")
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset %>% 
    filter(Measure == yaxis_title) %>% 
    mutate(`Hours taken` = fct_inorder(`Hours taken`))
  
  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  #Text for tooltip
  tooltip_trend <- glue("{trend_data$Measure}<br>",
                        "Week ending: {trend_data$week_ending}<br>",
                        "{trend_data$`Hours taken`} hours: {trend_data$`Number of Index Cases`} cases ({trend_data$`% of Total Index Cases`}%)")
  
  # Creating contact tracing time
  trend_data %>%
    plot_ly(x = ~week_ending, y = ~`Number of Index Cases`) %>%
    add_bars(color = ~`Hours taken`, #colour group
             colors = pal_CT, #palette
             stroke = I("black"), #outline
             text = tooltip_trend,
             hoverinfo = "text",
             name = ~`Hours taken`) %>%
    # Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "stack") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )
}


# Settings ----------------------------------------------------------------
# cases stacked bar chart
plot_settings_chart <- function(dataset, data_name, settingdata, yaxis_title, area = T) {

  yaxis_title <- case_when(data_name == "Settings" ~ "Number of Cases")
  
  # Filtering dataset to include only overall figures
  trend_data <- dataset %>% 
    filter(`Setting Type` == input$Setting_select)  %>% 
    mutate(`Setting Location` = fct_inorder(`Setting Location`))
  
  # Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  
  # ext for tooltip
  tooltip_trend <- glue("{trend_data$`Setting Location`}<br>",
                        "Week ending: {trend_data$week_ending}<br>",
                        "Number of cases: {trend_data$`Number of  Cases`}")
  
  # Creating contact tracing time
  trend_data %>%
    plot_ly(x = ~week_ending, y = ~`Number of  Cases`) %>%
    add_bars(color = ~`Setting Location`, #colour group
             colors = pal_CT, #palette
             stroke = I("black"), #outline
             text = tooltip_trend,
             hoverinfo = "text",
             name = ~`Setting Location`) %>%
    # Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "stack") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )
}


## Ethnicity Chart ------------------------------------------------------------

plot_overall_chartEthnicity <- function(dataset, data_name, yaxis_title, area = T) {
  trend_data <- Ethnicity_Chart
  
  yaxis_title <- "COVID-19 Admissions"
  
  yaxis_plots[["title"]] <- yaxis_title
  
  #Text for tooltip
  tooltip_trend <- c(paste0("Month: ", trend_data$`Date`, " 2020",
                            "<br>",yaxis_title, " - White: ", trend_data$`White_c`, " (", trend_data$`White_p`,"%)",
                            "<br>",yaxis_title, " - Black/Caribbean/African: ", trend_data$`Black/Caribbean/African_c`," (", trend_data$`Black/Caribbean/African_p`,"%)",
                            "<br>",yaxis_title, " - South Asian: ", trend_data$`South Asian_c`," (", trend_data$`South Asian_p`,"%)",
                            "<br>",yaxis_title, " - Chinese: ", trend_data$`Chinese_c`," (", trend_data$`Chinese_p`,"%)",
                            "<br>",yaxis_title, " - Other: ", trend_data$`Other_c`," (", trend_data$`Other_p`,"%)",
                            "<br>",yaxis_title, " - Not Available: ", trend_data$`Not Available_c`," (", trend_data$`Not Available_p`,"%)"))
  
  
  
  #Creating time trend plot
  plot_ly(data = trend_data, x = ~`Date`) %>%
    add_lines(y = ~`White_c`, line = list(color = pal_ETH[1]),
              text = tooltip_trend, hoverinfo="text",
              name = "White") %>%
    add_lines(y = ~trend_data$`Black/Caribbean/African_c`, line = list(color = pal_ETH[2]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Black/Caribbean/African") %>%
    add_lines(y = ~trend_data$`South Asian_c`, line = list(color = pal_ETH[3]),
              text = tooltip_trend, hoverinfo = "text",
              name = "South Asian") %>%
    add_lines(y = ~trend_data$`Chinese_c`, line = list(color = pal_ETH[4]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Chinese") %>%
    add_lines(y = ~trend_data$`Other_c`, line = list(color = pal_ETH[5]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Other") %>%
    add_lines(y = ~trend_data$`Not Available_c`, line = list(color = pal_ETH[6]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Not Available") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )
}

plot_overall_chartEthnicityPercent <- function(dataset, data_name, yaxis_title, area = T) {
  trend_data <- Ethnicity_Chart
  
  yaxis_title <- "% of COVID-19 Admissions"
  
  yaxis_plots[["title"]] <- yaxis_title
  
  #Text for tooltip
  tooltip_trend <- c(paste0("Month: ", trend_data$`Date`, " 2020",
                            "<br>COVID-19 Admissions -  White: ", trend_data$`White_c`, " (", trend_data$`White_p`,"%)",
                            "<br>COVID-19 Admissions -  Black/Caribbean/African: ", trend_data$`Black/Caribbean/African_c`," (", trend_data$`Black/Caribbean/African_p`,"%)",
                            "<br>COVID-19 Admissions -  South Asian: ", trend_data$`South Asian_c`," (", trend_data$`South Asian_p`,"%)",
                            "<br>COVID-19 Admissions -  Chinese: ", trend_data$`Chinese_c`," (", trend_data$`Chinese_p`,"%)",
                            "<br>COVID-19 Admissions -  Other: ", trend_data$`Other_c`," (", trend_data$`Other_p`,"%)",
                            "<br>COVID-19 Admissions -  Not Available: ", trend_data$`Not Available_c`," (", trend_data$`Not Available_p`,"%)"))
  
  
  #Creating time trend plot
  plot_ly(data = trend_data, x = ~`Date`) %>%
    add_lines(y = ~`White_p`, line = list(color = pal_ETH[1]),
              text = tooltip_trend, hoverinfo="text",
              name = "White") %>%
    add_lines(y = ~trend_data$`Black/Caribbean/African_p`, line = list(color = pal_ETH[2]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Black/Caribbean/African") %>%
    add_lines(y = ~trend_data$`South Asian_p`, line = list(color = pal_ETH[3]),
              text = tooltip_trend, hoverinfo = "text",
              name = "South Asian") %>%
    add_lines(y = ~trend_data$`Chinese_p`, line = list(color = pal_ETH[4]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Chinese") %>%
    add_lines(y = ~trend_data$`Other_p`, line = list(color = pal_ETH[5]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Other") %>%
    add_lines(y = ~trend_data$`Not Available_p`, line = list(color = pal_ETH[6]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Not Available") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )
}



### END