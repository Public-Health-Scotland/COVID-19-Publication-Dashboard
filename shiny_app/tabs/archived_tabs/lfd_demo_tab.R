##### Demographic data from LFT dashboard

#### Functions -----
### Functions to build the tables

build_peopletab_data_table <- function(data, dom_elements = "tB",
                                       nrow=NULL, numeric_cols = NULL, perc_cols= NULL, ...){

  table <- datatable(data,
                     style = "bootstrap",
                     extensions = 'Buttons',
                     options = list(dom = dom_elements,
                                    pageLength = nrow,
                                    buttons = list(
                                      list(
                                        extend = "copy",
                                        className = "btn",
                                        exportOptions = list(
                                          modifier = list(
                                            page="all", search ="none"
                                          ))
                                      ),
                                      list(
                                        extend = "csv",
                                        className = "btn",
                                        exportOptions = list(
                                          modifier = list(
                                            page="all", search ="none"
                                          ))
                                      ),
                                      list(
                                        extend = "excel",
                                        className = "btn",
                                        exportOptions = list(
                                          modifier = list(
                                            page="all", search ="none"
                                          ))
                                      )),
                                    initComplete = JS(paste0("function(settings, json) {",
                                                             "$(this.api().table().header()).css({'background-color': '#433684', 'color': '#ffffff'});}"))),
                     rownames = FALSE,
                     class = "table-bordered table-hover", ...)

  if(!is.null(perc_cols)){
    table <- table %>%
      formatPercentage(perc_cols, digits = 2)
  }

  if(is.null(numeric_cols)){
    table
  }
  else {
    table %>%
      formatCurrency(numeric_cols, currency = "", interval = 3, mark = ",",digits = 0)
  }
}

build_demographics_graph <- function(data){

  # remove totals for age-sex plot and local authority plot
  if(input$people_output_selection == "Age Group and Sex"){
    data<-data %>% filter(Sex %in% c("Female", "Male"))
    } else {

      data <- data
      simd_perc <- switch(input$plot_output_selection,
                          "All Individuals" = paste("Percent:", scales::percent(data$"Percent of Individuals", accuracy = 0.1)),
                          "Positive Testing Individuals" = paste0("Percent Testing Positive (of all Tested Individuals in ",
                                                                  data$"SIMD Quintile", "): ", scales::percent(data$"Percent Testing Positive", accuracy = 0.1)))

    }

  plot_y_var <- switch(input$plot_output_selection,
                       "All Individuals" = data$"Number of Individuals",
                       "Positive Testing Individuals" = data$"Number of Positive Individuals")

  plot_par <- switch(input$people_output_selection,
                 #    "Local Authority" = list(x = data$"Local Authority",
                #                              levels = arrange(data, desc(`Number of Individuals`))$`Local Authority`,
                #                              y = plot_y_var,
                #                              fill = "1",
                #
                #                              xlab = "Local Authority",
                #                              fill_color = "#433684",
                #                              theme = function(){
                #                                theme(legend.position = "none",
                #                                      axis.text.x = element_text(angle = 90))},
                #
                #                              tooltip = paste("Local Authority:", data$`Local Authority`, "<br>",
                #                                              "Number of Individuals:", format(plot_y_var, big.mark = ","))),

                     "Age Group and Sex" = list(x = data$"Age Group",
                                                levels = c("0-4", "5-14", "15-19", "20-24",
                                                           "25-44", "45-64", "65-74", "75-84", "85+", "Unknown"),
                                                y = plot_y_var,
                                                fill = data$"Sex",

                                                xlab = "Age Group",
                                                fill_color = c("#433684", "#7c6ec4"),
                                                theme = function(){
                                                  theme(legend.title = element_blank())},

                                                tooltip = paste("Age Group:", data$"Age Group", "<br>",
                                                                "Sex:", data$Sex, "<br>",
                                                                "Number of Individuals:", format(plot_y_var, big.mark=","))),

                     "SIMD" = list(x = data$"SIMD Quintile",
                                   levels = unique(data$"SIMD Quintile"),
                                   y = plot_y_var,
                                   fill = "1",

                                   xlab = "SIMD Quintile",
                                   fill_color = "#433684",
                                   theme = function(){
                                     theme(legend.position = "none")},

                                   tooltip = paste("SIMD Quintile:", gsub("SIMD ", "Q", data$`SIMD Quintile`), "<br>",
                                                   "Number of Individuals:", format(plot_y_var, big.mark=","), "<br>",
                                                   simd_perc)))


  p <- ggplotly(
    ggplot(data, aes(x = factor(plot_par$x, levels = plot_par$levels),
                     y = plot_par$y, fill = plot_par$fill, label = plot_par$tooltip)) +
      geom_bar(stat = "identity", position = position_dodge()) +
      scale_fill_manual(values = plot_par$fill_color) +
      labs(x = plot_par$xlab, y = "Number of Individuals") +
      labs(fill="") +
      theme_minimal() +
      theme(legend.title = element_blank()) +
      plot_par$theme() +
      scale_y_continuous(limits = c(0, NA), labels = function(x) {format(x, big.mark = ",",scientific = FALSE) })

  )
  p$x$data[[1]]$text <- sub(".*tooltip: ", "", p$x$data[[1]]$text )

  if(input$people_output_selection == "Age Group and Sex"){
    p$x$data[[2]]$text <- sub(".*tooltip: ", "", p$x$data[[2]]$text )
  }

  p %>% #Layout
    layout(margin = list(b = 80, t = 5), #to avoid labels getting cut out
           yaxis = yaxis_plots, xaxis = xaxis_plots,
           legend = list(x = 100, y = 0.5)) %>% #position of legend
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )

}



#### Objects -----
people_table_data <- reactive({
  switch(input$people_output_selection,

            ## Local authority data
          #  "Local Authority" = lfd_demographics_data %>%
          #    filter(indicator == "Local Authority") %>%
          #    select(`Local Authority`=lookup,
          #           `Number of Individuals` = count,
          #           `Number of Positive Individuals` = positive_count),

         ## age group data
         "Age Group and Sex" = lfd_demographics_data %>%
           filter(indicator == "Age-Sex") %>%
           separate(col = lookup, sep = ";", into = c("Sex", "Age Group")) %>%
           select(Sex, `Age Group`, `Number of Individuals` = count,
                  `Number of Positive Individuals` = positive_count),

         ## SIMD
         "SIMD" = lfd_demographics_data %>%
           filter(indicator == "SIMD") %>%
           mutate(percent = count/sum(count),
                  percent_pos = positive_count/count) %>%
           select(`SIMD Quintile` = lookup,
                  `Number of Individuals` = count,
                  `Percent of Individuals` = percent,
                  `Number of Positive Individuals` = positive_count,
                  `Percent Testing Positive` = percent_pos))
})



table_params <- reactive({
  nrow =   switch(input$people_output_selection,
           #         "Local Authority" = 15,
                  "Age Group and Sex" = 9,
                  "SIMD" = NULL)

  num_cols = switch(input$people_output_selection,
            #              "Local Authority" = 2:3,
                    "Age Group and Sex" = 3:4,
                    "SIMD" = c(2, 4))

  perc_cols = switch(input$people_output_selection,
             #              "Local Authority" = NULL,
                     "Age Group and Sex" = NULL,
                     "SIMD" = c(3,5))

  dom = switch(input$people_output_selection,
              #    "Local Authority" = "tipB",
               "Age Group and Sex" = "tipB",
               "SIMD" = "tB")

  list("nrow" = nrow, "numeric_cols" = num_cols, "dom" = dom, "perc_cols" = perc_cols)

})


#### Build UI -----
output$people_tab <- renderUI({
  tagList(
    actionButton("btn_modal_simd", "What is SIMD?", icon = icon('question-circle'), class="action"),

    plot_box_2(title_plot = switch(input$plot_output_selection,
                                 "All Individuals" = "Number of Individuals to Record an LFD",
                                 "Positive Testing Individuals" = "Number of Individuals to Record a Positive LFD"),
             subtitle_plot = switch(input$people_output_selection,
               #                            "Local Authority" = "By Local Authority",
                                    "Age Group and Sex" = "By Age Group and Sex",
                                    "SIMD" = "By SIMD Quintile"),
             plot_output = "people_data_plot"),

    h4("Data Table"),
    dataTableOutput("people_data_table")
  )
})

###############################################.
# Modal to explain SIMD and deprivation
simd_modal <- modalDialog(
  h5("What is SIMD and deprivation?"),
  p("The", tags$a(href="https://simd.scot/", "Scottish Index of Multiple Deprivation (SIMD).",
                  class="externallink"), "is the Scottish Government's
    official tool for identifying areas in Scotland with concentrations of deprivation
    by incorporating several different aspects of deprivation (multiple-deprivations)
    and combining them into a single index. Concentrations of deprivation are identified
    in SIMD at Data Zone level and can be analysed using this small geographical unit.
    The use of data for such small areas helps to identify 'pockets' (or concentrations)
    of deprivation that may be missed in analyses based on larger areas such as council
    areas. By identifying small areas where there are concentrations of multiple deprivation,
    the SIMD can be used to target policies and resources at the places with the greatest need.
    The SIMD identifies deprived areas, not deprived individuals."),
  p("In this tool we use the concept of quintile, which refers to a fifth of the population.
    For example when we talk about the most deprived quintile, this means the 20% of the population
    living in the most deprived areas."),
  size = "l",
  easyClose = TRUE, fade=TRUE, footer = modalButton("Close (Esc)")
)
# Link action button click to modal launch
observeEvent(input$btn_modal_simd, { showModal(simd_modal) })


#### Render UI -----
output$people_data_table <- renderDataTable({
  build_peopletab_data_table(people_table_data(),
                             nrow = table_params()$nrow,
                             numeric_cols = table_params()$numeric_cols,
                             dom = table_params()$dom,
                             perc_cols = table_params()$perc_cols)
}, server = FALSE)

output$people_data_plot <- renderPlotly({
  build_demographics_graph(people_table_data())
})