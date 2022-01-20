#### Functions to make default data tables

###############################################


byboard_data_table <- function(input_data_table, board_name_column, rows_to_display=14){
  
  # Remove the underscore from column names in the table
  table_colnames  <-  gsub("_", " ", colnames(input_data_table))
  
  dt <- DT::datatable(input_data_table, style = 'bootstrap',
                class = 'table-bordered table-condensed',
                rownames = FALSE,
                options = list(pageLength = rows_to_display, # Health Boards and total
                               order = list(list(0, "desc")), # Most recent week first
                               dom = 'tip',
                               autoWidth = TRUE,
                               initComplete = JS(
                                 "function(settings, json) {",
                                 "$(this.api().table().header()).css({'background-color': '#3F3685', 'color': 'white'});",
                                 "}")
                ),
                filter = "top",
                colnames = table_colnames) %>% 
    formatStyle(
      board_name_column, target="row", 
      backgroundColor = styleEqual("Scotland", phs_colours("phs-magenta")),
      fontWeight = styleEqual("Scotland", "bold"),
      color = styleEqual("Scotland", "white")
    )
  
  return(dt)

}
