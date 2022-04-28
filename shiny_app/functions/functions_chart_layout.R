# Functions for Chart Layouts ---------------------------------------------

plot_box <- function(title_plot, plot_output) {
  tagList(h4(title_plot),
          withSpinner(plotlyOutput(plot_output)))
}


plot_box_2 <- function(title_plot, subtitle_plot = "", plot_output) {
  tagList(h4(title_plot),p(tags$i(subtitle_plot)),
          withSpinner(plotlyOutput(plot_output), proxy.height = "500px"))
}

plot_cut_box <- function(title_plot1, plot_output1,
                         title_plot2, plot_output2, extra_content = NULL) {
  tagList(
    fluidRow(column(6, h4(title_plot1)),
             column(6, h4(title_plot2))),
    extra_content,
    fluidRow(column(6, withSpinner(plotlyOutput(plot_output1))),
             column(6, withSpinner(plotlyOutput(plot_output2))))
  )
}

#if missing plot (e.g. no SIMD)
plot_cut_missing <- function(title_plot, plot_output, extra_content = NULL) {
  tagList(
    fluidRow(column(6, h4(title_plot))),
    extra_content,
    fluidRow(column(6, withSpinner(plotlyOutput(plot_output))))
  )
}

br3<-function(){tagList(br(),br(),br())}

# Function to create the standard layout for all the different charts/sections
cut_charts <- function(title, source, data_name, total_title, agesex_title, simd_title) {
  tagList(
    h3(title),
    actionButton("btn_dataset_modal", paste0("Data source: ", source), icon = icon('question-circle')),
    plot_box(paste0(total_title), paste0(data_name, "_overall")),
    plot_cut_box(paste0(agesex_title), paste0(data_name, "_AgeSex"),
                 paste0(simd_title), paste0(data_name, "_SIMD")))
}

#for e.g. ICU admissions where no SIMD data
cut_charts_missing <- function(title, source, data_name, agesex_title, total_title) {
  tagList(
    h3(title),
    p("SICSAG data are stored in a dynamic database and subject to ongoing validations therefore on a week to week basis the data may change."),
    p("On 30 October 2020, Public Health Scotland became aware of an ongoing issue when linking ICU data to laboratory data for COVID-19 test results.
        Any COVID-19 positive patients with a missing a CHI number that had a first positive test in the community are unable to be linked to ICU data.
        As a result, the COVID-19 positive ICU patients could be underreported by up to 10%."),
    actionButton("btn_dataset_modal", paste0("Data source: ", source), icon = icon('question-circle')),
    plot_box(paste0(total_title), paste0(data_name, "_overall")),
    plot_cut_missing(paste0(agesex_title), paste0(data_name, "_AgeSex")))
}

# Function to create the standard layout for all the different charts/sections
cut_charts_subheading <- function(title, subheading, notes, source, total_title, data_name,
                                  agesex_title, simd_title) {
  tagList(
    h3(title),
    p(subheading),
    p(strong(notes)),
    actionButton("btn_dataset_modal", paste0("Data source: ", source), icon = icon('question-circle')),
    plot_box(paste0(total_title), paste0(data_name, "_overall")),
    plot_cut_box(paste0(agesex_title), paste0(data_name, "_AgeSex"),
                 paste0(simd_title), paste0(data_name, "_SIMD")))
}
