# Functions for Chart Layouts ---------------------------------------------

# Notes: Need to define a new set of functions based off plot_box etc. but which display objects which
# are members of the reactive value list called values, which is defined in summary_tab


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
    actionButton("btn_dataset_modal", paste0("Data source: ", source), icon = icon('question-circle')),
    plot_box_values(paste0(total_title), paste0(data_name, "_overall")),
    plot_cut_missing_values(paste0(agesex_title), paste0(data_name, "_AgeSex")))
}

# Function to create the standard layout for all the different charts/sections
cut_charts_subheading <- function(title, subheading="", notes="", source, total_title, data_name,
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