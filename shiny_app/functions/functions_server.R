# Functions for server side

###############################################.
# Function that creates line trend charts in Plotly for different splits: age, sex, SIMD
# Three parameters: pal_chose - what palette of colours you want
# dataset - what data to use for the chart formatted as required

## Functions to add lines and notes to charts -----

vline <- function(x, width=3.0, color="black", ...) {
  l_shape = list(
    type = "line",
    y0 = 0, y1 = 1, yref = "paper", # i.e. y as a proportion of visible region
    x0 = x, x1 = x,
    line = list(color = color)
  )
  return(l_shape)
}

annotation <- function(frac, y, note, color){
  ann <- list(yref = "paper",
             xref = "paper",
             y = y,
             x = frac,
             text = note,
             # Styling annotations' text:
             font = list(color = color,
                         size = 14),
             showarrow=FALSE)
  return(ann)
}

add_vline <- function(p, x, ...){
  l_shape <- vline(x, ...)
  p %>% layout(shapes=list(l_shape))
}


add_lines_and_notes <- function(p, dataframe, xcol, ycol, xs, notes, colors){



  for (i in seq(length(xs))){

    p %<>% add_segments(x = xs[i], xend = xs[i],
                       y = 0,
                       yend = max(dataframe[[ycol]]),
                       name = c(notes[i]),
                       line = list(color = colors[i], width = 3)
                       )

  }

  return(p)
}


## Functions for overall charts -----

plot_overall_chart <- function(dataset, data_name,  area = T, include_vline=F) {

  # Filtering dataset to include only overall figures
  trend_data <- dataset

  if (data_name =="Admissions"){
    # Get provisional dates
    prov_dates <- gsub("p", "", grep("p", trend_data$Date, value = TRUE))
    trend_data$Date<- ymd(trend_data$Date)
    prov_dates <- ymd(prov_dates)
    # Adding date below provisional so lines join up
    prov_dates <- c((min(prov_dates)-1), prov_dates)
    prov_data <- trend_data %>% dplyr::filter(Date %in% prov_dates)
    trend_data <- trend_data %>% dplyr::filter(!(Date %in% prov_dates))
  } else{
    # Make sure all dates in date format
    trend_data$Date<- ymd(trend_data$Date)
  }

  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "LabCases" ~ "Number of positive cases",
                           data_name == "LabCasesReinfections" ~ "Number of reinfections",
                           data_name == "Admissions" ~ "Number of admissions",
                           data_name == "ICU" ~ "Number of ICU admissions",
                           data_name == "NHS24" ~ "Number of NHS24 contacts")

  xaxis_title <- case_when(data_name == "LabCases" ~ "Specimen date")


  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  xaxis_plots[["title"]] <- xaxis_title

  measure_name <- case_when(data_name == "LabCases" ~ "Number of Cases: ",
                            data_name == "LabCasesReinfections" ~ "Reinfections: ",
                            data_name == "Admissions" ~ "Admissions: ",
                            data_name == "ICU" ~ "ICU admissions: ",
                            data_name == "NHS24" ~ "NHS24 Contacts: ")

  #Text for tooltip
  tooltip_trend <- c(paste0("Date: ", format(trend_data$Date, "%d %b %y"),
                            "<br>", measure_name, trend_data$Count,
                            "<br>", "7 Day Average: ", format(trend_data$Average7, nsmall=0, digits=3)))

  #Creating time trend plot
  p <- plot_ly(data = trend_data, x = ~Date) %>%
    add_lines(y = ~Count, line = list(color = pal_overall[2], width=0.8),
              text = tooltip_trend, hoverinfo = "text",
              name = "Count") %>%
    add_lines(y = ~Average7, line = list(color = pal_overall[1]),
              text = tooltip_trend, hoverinfo = "text",
              name = "7 day average") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )

  # Adding provisional points for admissions data
  if(data_name=="Admissions"){

    tooltip_trend_prov <- c(paste0("Provisional data: ",
                              "<br>", "Date: ", format(prov_data$Date, "%d %b %y"),
                              "<br>", measure_name, prov_data$Count,
                              "<br>", "7 Day Average: ", format(prov_data$Average7, nsmall=0, digits=3)))


    p %<>% add_lines(data=prov_data, x=~Date, y=~Count, line=list(color="#5c6164", width=0.8),
                     text = tooltip_trend_prov, hoverinfo = "text",
                     name = "Count (provisional)") %>%
      add_lines(data=prov_data, y=~Average7, line=list(color="#434343"),
                text = tooltip_trend_prov, hoverinfo = "text",
                name = "7 day average (provisional)")
  }

  if(include_vline){

    xs <- c("2022-01-06", "2022-05-01")

    p %<>% add_lines_and_notes(dataframe = trend_data,
                               xcol = "Date",
                               ycol = "Count",
                               xs=xs,
                               notes=c("From 5 Jan cases  include PCR + LFD",
                                       "Change in testing policy on 1 May"),
                               colors=c(phs_colours("phs-magenta"), phs_colours("phs-teal"))
                               )


  }

  return(p)

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
                           data_name == "SAS_SIMD" ~ "SAS incidents (suspected COVID-19)\n")

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

plot_singletrace_chart <- function(dataset, data_name, yaxis_title, xaxis_title, area = T, include_vline=F) {

  # Filtering dataset to include only overall figures
  trend_data <- dataset

  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "NHS24_inform" ~ "Number of hits",
                           data_name == "SAS_all" ~ "Number of SAS incidents",
                           data_name == "Cases_Adm" ~ "Percent")

  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title

  measure_name <- case_when(data_name == "NHS24_inform" ~ "COVID-19 section of NHS Inform: ",
                            data_name == "SAS_all" ~ "SAS incidents: ",
                            data_name == "Cases_Adm" ~ "Percentage")



  #measure_name <- case_when(data_name == "Cases_Adm" ~ "Week Commencing")

  xaxis_title <- case_when(data_name == "Cases_Adm" ~ "Week Ending")
  xaxis_plots[["title"]] <- xaxis_title

  #Text for tooltip
  tooltip_trend <- glue("Date: {format(trend_data$date, '%d %b %y')}<br>",
                        "{measure_name}: {trend_data$count}")

  #Creating time trend plot
 p <-  plot_ly(data = trend_data, x = ~date) %>%
    add_lines(y = ~count, line = list(color = pal_overall[1]),
              text = tooltip_trend, hoverinfo = "text", showlegend=FALSE) %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )


 if(include_vline){

   xs <- c("2022-01-06", "2022-05-01")
   fracs <- unlist(purrr::map(.x=xs,
                              .f= ~ as.numeric(as.Date(.x) - min(trend_data$date))/as.numeric(max(trend_data$date - min(trend_data$date)))))

   p %<>% add_lines_and_notes(dataframe = trend_data,
                              xcol = "date",
                              ycol = "count",
                              xs=xs,
                              notes=c("From 5 Jan cases include PCR + LFD",
                                      "Change in testing policy on 1 May"),
                              colors=c(phs_colours("phs-magenta"), phs_colours("phs-teal"))
   )

 }

 return(p)
}

plot_singlerate_chart <- function(dataset, data_name, yaxis_title, area = T, include_vline=F) {

  # Filtering dataset to include only overall figures
  trend_data <- dataset

  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- case_when(data_name == "LabCases" ~ "Cumulative rate of cases per 100,000",
                           data_name == "LabCasesReinfections" ~ "Cumulative rate of reinfections per 100,000")
  xaxis_title <- case_when(data_name %in% c("LabCases", "LabCasesReinfections") ~ "Specimen date")


  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  xaxis_plots[["title"]] <- xaxis_title

  measure_name <- case_when(data_name == "LabCases" ~ "Cumulative rate of cases per 100,000",
                            data_name == "LabCasesReinfections" ~ "Cumulative rate of reinfections per 100,000")

  #Text for tooltip
  tooltip_trend <- glue("Date: {format(trend_data$Date, '%d %b %y')}<br>",
                        "{measure_name}: {format(trend_data$CumulativeRatePer100000, nsmall=0, digits=2)}")

  #Creating time trend plot
  p <- plot_ly(data = trend_data, x = ~Date) %>%
    add_lines(y = ~CumulativeRatePer100000, line = list(color = pal_overall[1]),
              text = tooltip_trend, hoverinfo = "text", showlegend=FALSE) %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )

  if(include_vline){

    xs <- c("2022-01-06", "2022-05-01")
    fracs <- unlist(purrr::map(.x=xs,
                               .f= ~ as.numeric(as.Date(.x) - min(trend_data$Date))/as.numeric(max(trend_data$Date - min(trend_data$Date)))))

    p %<>% add_lines_and_notes(dataframe=trend_data,
                               xcol="Date",
                               ycol="CumulativeRatePer100000",
                               xs=xs,
                               notes=c("From 5 Jan cases include PCR + LFD",
                                       "Change in testing policy on 1 May"),
                               colors=c(phs_colours("phs-magenta"), phs_colours("phs-teal"))
    )

  }

  return(p)

}


cases_age_chart_3_week <- function(dataset, data_name, area = T, type = "cases"){

  if (type == "cases") {
    yaxis_title <- "Percent of Cases"
    levels =     c("0-17",
                   "18-29",
                   "30-39",
                   "40-49",
                   "50-54",
                   "55-59",
                   "60-64",
                   "65-69",
                   "70-74",
                   "75-79",
                   "80+")
  } else if (type == "admissions") {
    yaxis_title <- "Percent of Admissions"
    levels = c("0-4", "5-14", "15-19", "20-24", "25-44", "45-64", "65-74", "75-84", "85+", "Unknown")
  }

  xaxis_title <- "Age Group"

  latest_date <- max(dataset$Date)

  # Filtering dataset to include only overall figures
  trend_data <- dataset %>%
    filter(Date > (latest_date - 20)) %>%   # filter last 3 weeks
    mutate(Age = gsub('\\[|\\]','', Age) ) %>%
    mutate(Age = factor(Age, levels=levels))


  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  xaxis_plots[["title"]] <- xaxis_title

  #Text for tooltip
  if (type == "cases") {
    tooltip_trend <- glue("Percent of Cases: {trend_data$Percent}%<br>",
                          "Week Ending: {trend_data$Date}<br>",
                          "Age Group: {trend_data$Age}")
  } else if (type == "admissions") {
    tooltip_trend <- glue("Percent of Admissions: {trend_data$Percent}%<br>",
                          "Week Ending: {trend_data$Date}<br>",
                          "Age Group: {trend_data$Age}")
  }


  #Creating contact tracing time
  trend_data %>%
    plot_ly(x = ~Age, y = ~Percent, type="bar",
            color=~Date,
            stroke=I("black"),
            colors = pal_3_week,
            name=~Date,
            hovertemplate=tooltip_trend,
            hoverinfo="text") %>%
   # add_bars(color = ~Date, #colour group
  #           stroke = I("black"), #outline
  #           #text = tooltip_trend,
  #           hovertemplate = tooltip_trend,
  #           hoverinfo = "text",
  #           name = ~Date) %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "group") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )


}




stacked_cases_age_chart <- function(dataset, data_name, area = T) {

  yaxis_title <- "Percent of Cases"

  # Filtering dataset to include only overall figures
  trend_data <- dataset %>%
    mutate( Age = gsub('\\[|\\]','',Age) ) %>%
    mutate(Age = factor(Age,levels = rev(c("0-17",
                                           "18-29",
                                          "30-39",
                                          "40-49",
                                          "50-54",
                                          "55-59",
                                          "60-64",
                                          "65-69",
                                          "70-74",
                                          "75-79",
                                          "80+"))))

  #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title

  #Text for tooltip
  tooltip_trend <- glue("Percent of Cases: {trend_data$Percent}<br>",
                        "Date: {trend_data$Date}<br>",
                        "Age Group: {trend_data$Age}")

  #Creating contact tracing time
  trend_data %>%
    plot_ly(x = ~Date, y = ~Percent) %>%
    add_bars(color = ~Age, #colour group
             colors = pal_AgeGrp, #palette
             stroke = I("black"), #outline
             text = tooltip_trend,
             hoverinfo = "text",
             name = ~Age) %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "stack") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )

}

## Reinfections Proportion barchart

plot_reinfections_barchart <- function(casesdata, reinfdata) {

   yaxis_plots[["title"]] <- "Percentage of cases that are reinfections"
   xaxis_plots[["title"]] <- "Specimen Date by Week Ending"

   names(casesdata) <- unlist(purrr::map(names(casesdata), ~ paste0(.x, " Cases")))
   names(reinfdata) <- unlist(purrr::map(names(reinfdata), ~ paste0(.x, " Reinfections")))

   newdf <- merge(casesdata, reinfdata, by.x="Date Cases", by.y="Date Reinfections") %>%
     dplyr::rename("Cases" = "Count Cases",
                   "Reinfections" = "Count Reinfections",
                   "Date" = "Date Cases") %>%
     select(c("Date", "Cases", "Reinfections")) %>%
     dplyr::mutate(`Week Ending` = ceiling_date(Date, unit="week", change_on_boundary = FALSE)) %>%
     select(-Date) %>%
     group_by(`Week Ending`) %>%
     summarise(Cases= sum(Cases), Reinfections=sum(Reinfections)) %>%
     dplyr::mutate(`First Infections Proportion` = (Cases-Reinfections)/Cases,
                   `Reinfections Proportion` = Reinfections/Cases) %>%
     replace_na(list(`First Infections Proportion`=0, `Reinfections Proportion`=0)) %>%
     select(c("Week Ending", "First Infections Proportion", "Reinfections Proportion")) %>%
     dplyr::rename("First Infections" = "First Infections Proportion",
                   "Reinfections" = "Reinfections Proportion") %>%
     gather(key="reinfection_flag", value="count", -`Week Ending`) %>%
     group_by(`Week Ending`, reinfection_flag) %>%
     summarise(total_count = sum(count)) %>%
     dplyr::mutate(total_count = 100 * total_count) %>% # get as percentage
     arrange(`Week Ending`) %>%
     tail(40)

   tooltip_trend <- glue("Week Ending: {newdf$`Week Ending`}<br>",
                         "{newdf$reinfection_flag}: {scales::percent(newdf$total_count, accuracy=0.1, scale=1)}")

  # Creating barchart
   newdf %>%
     plot_ly(x = ~`Week Ending`, y = ~total_count) %>%
     add_bars(color = ~reinfection_flag, #colour group
              colors = pal_reinf, #palette
              stroke = I("black"), #outline
              text = tooltip_trend,
              hoverinfo = "text",
              name = ~reinfection_flag) %>%
     #Layout
     layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
            yaxis = yaxis_plots, xaxis = xaxis_plots,
            legend = list(x = 100, y = 0.5), #position of legend
            barmode = "stack") %>% #split by group
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
             colors = pal_CT, #palette
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
# New

plot_contacttrace_Per_graph <- function(dataset, data_name, CTdata, yaxis_title, area = T, include_vline = T) {

  yaxis_title <- case_when(#CTdata == "TestIndex" ~ "Test to index created",
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
  p <- trend_data %>%
    plot_ly(x =~week_ending, y=~`% of Total Index Cases`) %>%
    add_lines(color = ~ordered(`Hours taken`)) %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "stack") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )

  if(include_vline){

    xs <- c("2022-01-06", "2022-05-01")

    p %<>% add_lines_and_notes(dataframe = trend_data,
                               xcol = "week_ending",
                               ycol = "% of Total Index Cases",
                               xs=xs,
                               notes=c("From 5 Jan cases include PCR + LFD",
                                       "Change in testing policy on 1 May"),
                               colors=c(phs_colours("phs-magenta"), phs_colours("phs-teal"))
    )


  }

  return(p)

}

plot_contacttrace_graph <- function(dataset, data_name, CTdata, yaxis_title, area = T, include_vline=T) {

  yaxis_title <- case_when(#CTdata == "TestIndex" ~ "Test to index created",
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
  p <- trend_data %>%
    plot_ly(x = ~week_ending, y = ~`Number of Index Cases`) %>%
    add_lines(color = ~ordered(`Hours taken`)) %>%
    # Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "stack") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )

  if(include_vline){

    xs <- c("2022-01-06", "2022-05-01")

    p %<>% add_lines_and_notes(dataframe = trend_data,
                               xcol = "week_ending",
                               ycol = "Number of Index Cases",
                               xs=xs,
                               notes=c("From 5 Jan cases include PCR + LFD",
                                       "Change in testing policy on 1 May"),
                               colors=c(phs_colours("phs-magenta"), phs_colours("phs-teal"))
    )

  }

  return(p)

}





##### Old - bar chart
plot_contacttrace_Per_chart <- function(dataset, data_name, CTdata, yaxis_title, area = T) {

  yaxis_title <- case_when(#CTdata == "TestIndex" ~ "Test to index created",
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
             colors = pal_comm, #palette
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

  yaxis_title <- case_when(#CTdata == "TestIndex" ~ "Test to index created",
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


plot_average_CT_cases <- function(dataset, area = T, include_vline=F) {

#Filtering dataset to include only overall figures

yaxis_title <- "Average number of contacts per case"

trend_data <- dataset

#Modifying standard layout
yaxis_plots[["title"]] <- yaxis_title

#Text for tooltip
tooltip_trend <- c(paste0("Week ending: ", format(trend_data$`Week Ending`, "%d %b %y"),
                          "<br>", yaxis_title,  trend_data$`Average Number of Contacts`))

#Creating time trend plot
p <- plot_ly(data = trend_data, x = ~`Week Ending`) %>%
  add_lines(y = ~`Average Number of Contacts`,
            line = list(color = pal_ETH[1]),
            text = tooltip_trend, hoverinfo="text",
            name = "Age 0-4") %>%
  #Layout
  layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
         yaxis = yaxis_plots, xaxis = xaxis_plots,
         legend = list(x = 100, y = 0.5)) %>% #position of legend
  # leaving only save plot button
  config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )

if(include_vline){

  xs <- c("2022-01-06", "2022-05-01")

  p %<>% add_lines_and_notes(dataframe = trend_data,
                             xcol = "Week Ending",
                             ycol = "Average Number of Contacts",
                             xs=xs,
                             notes=c("From 5 Jan cases include PCR + LFD",
                                     "Change in testing policy on 1 May"),
                             colors=c(phs_colours("phs-magenta"), phs_colours("phs-teal"))
  )



}

return(p)

}

# Settings ----------------------------------------------------------------

# new

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
    add_lines(color = ~`Setting Location`) %>%
    # Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "stack") %>% #split by group
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )
}




# old
#plot_settings_chart <- function(dataset, data_name, settingdata, yaxis_title, area = T) {

#  yaxis_title <- case_when(data_name == "Settings" ~ "Number of Cases")

#  # Filtering dataset to include only overall figures
#  trend_data <- dataset %>%
#    filter(`Setting Type` == input$Setting_select)  %>%
#    mutate(`Setting Location` = fct_inorder(`Setting Location`))

#  # Modifying standard layout
#  yaxis_plots[["title"]] <- yaxis_title

#  # ext for tooltip
#  tooltip_trend <- glue("{trend_data$`Setting Location`}<br>",
#                        "Week ending: {trend_data$week_ending}<br>",
#                        "Number of cases: {trend_data$`Number of  Cases`}")

  # Creating contact tracing time
#  trend_data %>%
#    plot_ly(x = ~week_ending, y = ~`Number of  Cases`) %>%
#    add_bars(color = ~`Setting Location`, #colour group
#             colors = pal_CT, #palette
#             stroke = I("black"), #outline
#             text = tooltip_trend,
#             hoverinfo = "text",
#             name = ~`Setting Location`) %>%
#    # Layout
#    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
#           yaxis = yaxis_plots, xaxis = xaxis_plots,
#           legend = list(x = 100, y = 0.5), #position of legend
#           barmode = "stack") %>% #split by group
#    # leaving only save plot button
#    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )
#}


## Ethnicity Chart ------------------------------------------------------------

plot_overall_chartEthnicity <- function(dataset, data_name, yaxis_title, area = T) {
  trend_data <- Ethnicity_Chart

  yaxis_title <- "COVID-19 Admissions"

  yaxis_plots[["title"]] <- yaxis_title

  #Text for tooltip
  tooltip_trend <- c(paste0("Month: ", trend_data$month_begining,
                            "<br>",yaxis_title, " - White: ", trend_data$admissions_white, " (", trend_data$percentage_white,"%)",
                            "<br>",yaxis_title, " - Black/Caribbean: ", trend_data$admissions_caribbean_or_black," (", trend_data$percentage_caribbean_or_black,"%)",
                            "<br>",yaxis_title, " - Mixed/Multiple Ethnic Groups: ", trend_data$admissions_mixed_or_multiple_ethnic_groups," (", trend_data$percentage_mixed_or_multiple_ethnic_groups,"%)",
                            "<br>",yaxis_title, " - African: ", trend_data$admissions_african," (", trend_data$percentage_african,"%)",
                            "<br>",yaxis_title, " - Asian/Asian Scottish/Asian British: ", trend_data$admissions_asian_asian_scottish_or_asian_british," (", trend_data$percentage_asian_asian_scottish_or_asian_british,"%)",
                            "<br>",yaxis_title, " - Other: ", trend_data$admissions_other," (", trend_data$percentage_other,"%)",
                            "<br>",yaxis_title, " - Unknown: ", trend_data$admissions_unknown," (", trend_data$percentage_unknown,"%)"))



  #Creating time trend plot
  plot_ly(data = trend_data, x = ~month_begining) %>%
    add_lines(y = ~trend_data$admissions_white, line = list(color = pal_ETH[1]),
              text = tooltip_trend, hoverinfo="text",
              name = "White") %>%
    add_lines(y = ~trend_data$admissions_caribbean_or_black, line = list(color = pal_ETH[2]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Black/Caribbean") %>%
    add_lines(y = ~trend_data$admissions_mixed_or_multiple_ethnic_groups, line = list(color = pal_ETH[3]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Mixed/Multiple Ethnic Groups") %>%
    add_lines(y = ~trend_data$admissions_asian_asian_scottish_or_asian_british, line = list(color = pal_ETH[4]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Asian/Asian Scottish/Asian British") %>%
    add_lines(y = ~trend_data$admissions_other, line = list(color = pal_ETH[5]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Other") %>%
    add_lines(y = ~trend_data$admissions_unknown, line = list(color = pal_ETH[6]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Unknown") %>%
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
  tooltip_trend <- c(paste0("Month: ", trend_data$month_begining,
                            "<br>COVID-19 Admissions -  White: ", trend_data$admissions_white, " (", trend_data$percentage_white,"%)",
                            "<br>COVID-19 Admissions -  Black/Caribbean: ", trend_data$admissions_caribbean_or_black," (", trend_data$percentage_caribbean_or_black,"%)",
                            "<br>COVID-19 Admissions -  Mixed/Multiple Ethnic Groups: ", trend_data$admissions_mixed_or_multiple_ethnic_groups," (", trend_data$percentage_mixed_or_multiple_ethnic_groups,"%)",
                            "<br>COVID-19 Admissions -  Asian/Asian Scottish/Asian British: ", trend_data$admissions_asian_asian_scottish_or_asian_british," (", trend_data$percentage_asian_asian_scottish_or_asian_british,"%)",
                            "<br>COVID-19 Admissions -  Other: ", trend_data$admissions_other," (", trend_data$percentage_other,"%)",
                            "<br>COVID-19 Admissions -  Unknown: ", trend_data$admissions_unknown," (", trend_data$percentage_unknown,"%)"))

  #Creating time trend plot
  plot_ly(data = trend_data, x = ~month_begining) %>%
    add_lines(y = ~trend_data$percentage_white, line = list(color = pal_ETH[1]),
              text = tooltip_trend, hoverinfo="text",
              name = "White") %>%
    add_lines(y = ~trend_data$percentage_caribbean_or_black, line = list(color = pal_ETH[2]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Black/Caribbean") %>%
    add_lines(y = ~trend_data$percentage_mixed_or_multiple_ethnic_groups, line = list(color = pal_ETH[3]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Mixed/Multiple Ethnic Groups") %>%
    add_lines(y = ~trend_data$percentage_asian_asian_scottish_or_asian_british, line = list(color = pal_ETH[4]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Asian/Asian Scottish/Asian British") %>%
    add_lines(y = ~trend_data$percentage_other, line = list(color = pal_ETH[5]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Other") %>%
    add_lines(y = ~trend_data$percentage_unknown, line = list(color = pal_ETH[6]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Unknown") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )
}

##Scotland Proximity App - number of notificatins chart
plot_prox_contacts_chart <- function(dataset, yaxis_title, xaxis_title, area = T, include_vline=F) {

  # Filtering dataset to include only overall figures
  trend_data <- dataset

  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- "Number of contact notifications"
  xaxis_title <- "Week beginning"

    #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  xaxis_plots[["title"]] <- xaxis_title

  measure_name <- "Number of contact notifications"

    #Text for tooltip
  tooltip_trend <- glue("Week beginning: {trend_data$'Week beginning'}<br>",
                        "Contact Notifications: {trend_data$'Contact notifications'}")

   #Creating plot

 p <- plot_ly(x = trend_data$`Week beginning`, y = trend_data$`Contact notifications`,
          type = "bar", #text=tooltip_trend
          hovertemplate = tooltip_trend) %>%

    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
          yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "bar") %>%
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )


  if(include_vline){

    xs <- c("2022-01-06", "2022-05-01")

    p %<>% add_lines_and_notes(dataframe = trend_data,
                               xcol = "Week beginning",
                               ycol = "Contact notifications",
                               xs=xs,
                               notes=c("From 5 Jan cases include PCR + LFD",
                                       "Change in testing policy on 1 May"),
                               colors=c(phs_colours("phs-magenta"), phs_colours("phs-teal"))
    )


  }

  return(p)
}


##Scotland Proximity App - number of uploads chart
plot_prox_uploads_chart <- function(dataset, yaxis_title, xaxis_title, area = T, include_vline = F) {

  # Filtering dataset to include only overall figures
  trend_data <- dataset

  ###############################################.
  # Creating objects that change depending on dataset
  yaxis_title <- "Number of exposure key uploads"
  xaxis_title <- "Week beginning"

    #Modifying standard layout
  yaxis_plots[["title"]] <- yaxis_title
  xaxis_plots[["title"]] <- xaxis_title

  measure_name <- "Number of contact notifications"

    #Text for tooltip
  tooltip_trend <- glue("Week beginning: {trend_data$'Week beginning'}<br>",
                        "Exposure key uploads: {trend_data$'Exposure key uploads'}")

   #Creating plot

  p <- plot_ly(x = trend_data$`Week beginning`, y = trend_data$`Exposure key uploads`,
          type = "bar", #text=tooltip_trend
          hovertemplate = tooltip_trend) %>%

    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
          yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "bar") %>%
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )


  if(include_vline){

    xs <- c("2022-01-06", "2022-05-01")

    p %<>% add_lines_and_notes(dataframe = trend_data,
                               xcol = "Week beginning",
                               ycol = "Exposure key uploads",
                               xs=xs,
                               notes=c("From 5 Jan cases include PCR + LFD",
                                       "Change in testing policy on 1 May"),
                               colors=c(phs_colours("phs-magenta"), phs_colours("phs-teal"))
    )

  }

  return(p)

}


############ Chart for LFD trend
plot_LFDs <- function(dataset, area = T) {

  # Filtering dataset to include only overall figures
  trend_data <- dataset

  #Modifying standard layout
  yaxis_plots[["title"]] <- "Number of LFD Tests"

  tooltip_trend <- glue("Week ending: {trend_data$`Week Ending`}<br>",
                        "Number of LFDs: {trend_data$`Number of LFD Tests`}")

  #Creating time trend plot
  plot_ly(data = trend_data, x = ~`Week Ending`) %>%
    add_lines(y = ~`Number of LFD Tests`, line = list(color = pal_overall[3]),
              text = tooltip_trend, hoverinfo = "text",
              name = "Number of LFD Tests") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )
}

############ Chart for LFD trend by test group
LFD_time_series_chart <- function(testdata, posdata){

  if (input$LFD_timeseries_select == "Number of LFD Tests"){
    data <- testdata
    } else { data <- posdata }

  tooltip_trend <- c(paste0("Week Ending: ", format(data$`Week Ending`, "%d %b %y"),
                            "<br>", "Education Testing: ", format(as.numeric(data$`Education Testing`), big.mark=","),
                            "<br>", "Other: ", format(as.numeric(data$`Other`), big.mark=","),
                            "<br>", "Care Home Testing: ", format(as.numeric(data$`Care Home Testing`), big.mark=","),
                            "<br>", "Healthcare Testing: ", format(as.numeric(data$`Healthcare Testing`), big.mark=","),
                            "<br>", "Social Care: ", format(as.numeric(data$`Social Care`), big.mark=","),
                            "<br>", "Community Testing: ", format(as.numeric(data$`Community Testing`), big.mark=","),
                            "<br>", "Workplace Testing: ", format(as.numeric(data$`Workplace Testing`), big.mark=","),
                            "<br>", "Universal Offer: ", format(as.numeric(data$`Universal Offer`), big.mark=",")))

  yaxis_plots[["title"]] <- "Tests"
  xaxis_plots[["title"]] <- "Week Ending"

  p <- data %>%
    select( `Week Ending`, `Education Testing`, `Other`, `Care Home Testing`, `Healthcare Testing`,
            `Social Care`, `Community Testing`, `Workplace Testing`, `Universal Offer` ) %>%
    mutate( `Education Testing` = as.numeric(`Education Testing`),
            `Other` = as.numeric(`Other`),
            `Care Home Testing` = as.numeric(`Care Home Testing`),
            `Healthcare Testing` = as.numeric(`Healthcare Testing`),
            `Social Care` = as.numeric(`Social Care`),
            `Community Testing` = as.numeric(`Community Testing`),
            `Workplace Testing` = as.numeric(`Workplace Testing`),
            `Universal Offer` = as.numeric(`Universal Offer`)) %>%
    plot_ly( x = ~`Week Ending` ) %>%
    add_lines(
      y = ~`Education Testing`, line=list(color=phs_colours('phs-magenta-80')), name='Education Testing', mode='lines',
      text = tooltip_trend, hoverinfo="text"
    ) %>%
    add_lines(
      y = ~`Other`, line=list(color=phs_colours('phs-blue-80')), name='Other', mode='lines',
      text = tooltip_trend, hoverinfo="text"
    ) %>%
    add_lines(
      y = ~`Care Home Testing`, line=list(color=phs_colours('phs-green-80')), name='Care Home Testing', mode='lines',
      text = tooltip_trend, hoverinfo="text"
    ) %>%
    add_lines(
      y = ~`Healthcare Testing`, line=list(color=phs_colours('phs-purple-80')), name='Healthcare Testing', mode='lines',
      text = tooltip_trend, hoverinfo="text"
    ) %>%
    add_lines(
      y = ~`Social Care`, line=list(color=phs_colours('phs-teal-80')), name='Social Care', mode='lines',
      text = tooltip_trend, hoverinfo="text"
    ) %>%
    add_lines(
      y = ~`Community Testing`, line=list(color=phs_colours('phs-liberty-80')), name='Community Testing', mode='lines',
      text = tooltip_trend, hoverinfo="text"
    ) %>%
    add_lines(
      y = ~`Workplace Testing`, line=list(color=phs_colours('phs-rust')), name='Workplace Testing', mode='lines',
      text = tooltip_trend, hoverinfo="text"
    ) %>%
    add_lines(
      y = ~`Universal Offer`, line=list(color="black"), name='Universal Offer', mode='lines',
      text = tooltip_trend, hoverinfo="text"
    ) %>%
    layout(margin = list(b = 80, t = 5),
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #commented out to check function works
  config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )

  return(p)


}

#### Travel outside Scotland Chart

travel_outside_scotland_chart <- function(dataset, area = T){

  yaxis_plots[["title"]] <- "Travel Outside Scotland"

  plot_data <- dataset %>%
    mutate(Region = factor(Region, levels = c("Scotland", "United Kingdom","North Sea", "Europe", "Rest of the World")))

  tooltip_trend <- glue("Region: {plot_data$Region}<br>",
                        "Cases: {plot_data$Cases}")

  plot_ly(x = plot_data$Region, y = plot_data$Cases,
          type = "bar", hovertemplate=tooltip_trend) %>%

    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5), #position of legend
           barmode = "bar") %>%
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )


}



#### Length of Stay Chart

los_chart_fn = function(data) {

    table = data %>%
      filter(`Age Group` == input$los_age) %>%
      mutate(`Length of Stay` = factor(`Length of Stay`,
                                       levels = c("1 day or less", "2-3 days", "4-5 days",
                                                  "6-7 days", "8+ days"))) %>%
      mutate(Percent = (prop * 100))

    tooltip_trend <- glue("Week Ending: {table$`Week Ending`}<br>",
                          "Length of Stay: {table$`Length of Stay`}<br>",
                          "Percent: {round(table$Percent, 1)}%"
                          )

    table %>%
      plot_ly(x = ~`Week Ending`,
              y = ~Percent,
              color = ~`Length of Stay`,
              type = 'bar',
              colors = c(phs_colours("phs-graphite"),
                         phs_colours("phs-green"),
                         phs_colours("phs-purple"),
                         phs_colours("phs-magenta"),
                         phs_colours("phs-blue")),
              text = tooltip_trend,
              hoverinfo = "text",
              marker = list(line = list(width=.5,
                                        color = 'rgb(0,0,0)'))) %>%
      layout(barmode = "stack",
             yaxis = list(title = 'Percentage of Admissions',
                          ticksuffix = "%"),
             xaxis = list(title = 'Admission Date by Week Ending')) %>%
      # leaving only save plot button
      config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )
}

#### Care Homes Time Series Chart

care_home_time_series_chart <- function(data){

  tooltip_trend <- c(paste0("Week Ending: ", format(data$`Week Ending`, "%d %b %y"),
                            "<br>", "Staff: ", format(as.numeric(data$Staff), big.mark=","),
                            "<br>", "Residents: ", format(as.numeric(data$Resident), big.mark=",")))

  yaxis_plots[["title"]] <- "Tests"
  xaxis_plots[["title"]] <- "Week Ending"

  CareHomeGraph <- data %>%
    select( `Week Ending`, Resident, Staff ) %>%
    mutate( Resident = as.numeric(Resident), Staff = as.numeric(Staff) ) %>%
    plot_ly( x = ~`Week Ending` ) %>%
    add_lines(
      y = ~Staff, line=list(color=phs_colours('phs-magenta-80')), name='Staff', mode='lines',
      text = tooltip_trend, hoverinfo="text"
    ) %>%
    add_lines(
      y = ~Resident, line=list(color=phs_colours('phs-blue-80')), name='Residents', mode='lines',
      text = tooltip_trend, hoverinfo="text"
    ) %>%
    layout(margin = list(b = 80, t = 5),
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>%
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )

  return(CareHomeGraph)


}

############ Chart for Vaccine Wastage trend
plot_VaccineWastage <- function(dataset, area = T) {

  #Modifying standard layout
  yaxis_plots[["title"]] <- "Percentage of Doses Wasted"

  tooltip_trend <- glue("Month Beginning: {dataset$`Month Beginning`}<br>",
                        "Doses Wasted: {format(dataset$`Doses Wasted`, big.mark=',')}<br>",
                        "Percentage Wasted: {dataset$`% Wasted`}%")

  p <- plot_ly(data = dataset, x = ~`Month Beginning`) %>%
    add_bars(y = ~`% Wasted`, color = I(phs_colours("phs-teal-80")),
              text = tooltip_trend, hoverinfo = "text",
              name = "% Wasted") %>%
    #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )

  # Adding vertical line
  # Fraction of plot which is since 01 Dec 2021 (where we want to place text)
  frac1 <- as.numeric(as.Date("2021-11-01") - min(dataset$`Month Beginning`))/as.numeric(max(dataset$`Month Beginning` - min(dataset$`Month Beginning`)))
  frac2 <- as.numeric(as.Date("2022-01-12") - min(dataset$`Month Beginning`))/as.numeric(max(dataset$`Month Beginning` - min(dataset$`Month Beginning`)))

  annotation1 <- list(yref = "paper",
                     xref = "paper",
                     y = 0.7,
                     x = frac1,
                     text = "<b>Doses 1 & 2</b>",
                     bordercolor = phs_colours("phs-purple"),
                     borderwidth = 2,
                     showarrow=FALSE)

  annotation2 <- list(yref = "paper",
                      xref = "paper",
                      y = 0.7,
                      x = frac2,
                      text = "<b>All Doses</b>",
                      bordercolor = phs_colours("phs-purple"),
                      borderwidth = 2,
                      showarrow=FALSE)



  p %<>% add_vline("2021-12-01", color=phs_colours("phs-purple"), width=3.0) %>%
    layout(annotations=list(annotation1, annotation2))
  return(p)
}


make_simd_trend_plot <- function(data) {

  data %<>%
    mutate(WeekEnding = as.Date(as.character(WeekEnding), format = "%Y%m%d"))

  yaxis_plots[["title"]] <- "Number of admissions"
  xaxis_plots[["title"]] <- "Week ending"

  p <- plot_ly(data) %>%
       add_trace(x = ~WeekEnding, y = ~NumberOfAdmissions, split = ~SIMD, text=~SIMD,
               type="scatter", mode="lines",
               color=~SIMD,
               colors=phs_colours(c("phs-blue", "phs-liberty-30", "phs-liberty-30",
                                    "phs-liberty-30", "phs-green")),
               hovertemplate = paste0('<b>Week ending</b>: %{x}<br>',
                                      '<b>SIMD quintile</b>: %{text}<br>',
                                     '<b>Number of admissions</b>: %{y}')
       ) %>%
    layout(margin = list(b = 80, t = 5),
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>%
    config(displaylogo = F, displayModeBar = TRUE,
           modeBarButtonsToRemove = bttn_remove )



  return(p)

}


### END