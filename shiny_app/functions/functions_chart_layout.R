# Functions for Chart Layouts ---------------------------------------------
plot_box_values <- function(title_plot, valuename) {
  tagList(h4(title_plot),
          values[[valuename]])
}

plot_cut_box_values <- function(title_plot1, valuename1,
                         title_plot2, valuename2, extra_content = NULL) {
  tagList(
    fluidRow(column(6, h4(title_plot1)),
             column(6, h4(title_plot2))),
    extra_content,
    fluidRow(column(6, values[[valuename1]]),
             column(6, values[[valuename2]]))
  )
}

#if missing plot (e.g. no SIMD)
plot_cut_missing_values <- function(title_plot, valuename, extra_content = NULL) {
  tagList(
    fluidRow(column(6, h4(title_plot))),
    extra_content,
    fluidRow(column(6, values[[valuename]]))
  )
}


# Function to create the standard layout for all the different charts/sections
cut_charts <- function(title, source, data_name, total_title, agesex_title, simd_title) {
  tagList(
    h3(title),
    actionButton("btn_dataset_modal", paste0("Data source: ", source), icon = icon('question-circle')),
    plot_box_values(paste0(total_title), paste0(data_name, "_overall")),
    plot_cut_box_values(paste0(agesex_title), paste0(data_name, "_AgeSex"),
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
    plot_box_values(paste0(total_title), paste0(data_name, "_overall")),
    plot_cut_missing_values(paste0(agesex_title), paste0(data_name, "_AgeSex")))
}

# Function to create the standard layout for all the different charts/sections
cut_charts_subheading <- function(title, subheading, notes, source, total_title, data_name,
                                  agesex_title, simd_title) {
  tagList(
    h3(title),
    p(subheading),
    p(strong(notes)),
    actionButton("btn_dataset_modal", paste0("Data source: ", source), icon = icon('question-circle')),
    plot_box_values(paste0(total_title), paste0(data_name, "_overall")),
    plot_cut_box_values(paste0(agesex_title), paste0(data_name, "_AgeSex"),
                 paste0(simd_title), paste0(data_name, "_SIMD")))
}