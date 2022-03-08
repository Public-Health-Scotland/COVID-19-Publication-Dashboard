#### Functions to make default data tables

###############################################

## Function to format a given entry in a table
format_entry <- function(x, dp=0, perc=F){
  # x (numeric, char): entry
  # dp (int): number of decimal places
  # perc (bool): whether to add % afterwards

  # First strip any existing commas and whitespace out
  x <- gsub(",", "", x)
  x <- gsub(" ", "", x)

  # Try to convert entry to numeric, if failed return NULL
  numx <- tryCatch(as.numeric(x),
           warning = function(w) NULL)

  # Format entry if numeric
  if (!is.null(numx)){
    numx <- formatC(numx, format="f", big.mark = ",", digits=dp)
    if (perc){
      numx <- paste0(numx, "%")
    }
    return (numx)
  } else {
    # If entry cannot be converted to numeric, return original entry i.e. "*"
    return(x)
  }
}

# Data table for Data tab

datatab_table <- function(input_data_table,
                          add_separator_cols = NULL, # with , separator and 0dp
                          add_separator_cols_1dp = NULL, # with , separator and 1dp
                          add_percentage_cols = NULL, # with % symbol and 2dp
                          maxrows = 14, # max rows displayed on page
                          flip_order = FALSE, # Flip order of rows
                          highlight_column = NULL # Column to highlight specific entries based off
                          ){


  # Remove the underscore from column names in the table

  table_colnames  <-  gsub("_", " ", colnames(input_data_table))

  # Add column formatting

    for (i in add_separator_cols){
      input_data_table[i] <- apply(input_data_table[i], MARGIN=1, FUN=format_entry)
    }

    for (i in add_separator_cols_1dp){
      input_data_table[i] <- apply(input_data_table[i], MARGIN=1, FUN=format_entry, dp=1)
    }

    for (i in add_percentage_cols){
      input_data_table[i] <- apply(input_data_table[i], MARGIN=1, FUN=format_entry, dp=1, perc=T)
    }

  if(flip_order){
    tab_order <- list(list(0, "asc"))
  } else {
    tab_order <- list(list(0, "desc"))
  }

  dt <- DT::datatable(input_data_table, style = 'bootstrap',

                class = 'table-bordered table-condensed',
                rownames = FALSE,
                options = list(pageLength = maxrows,
                               dom = 'tip',
                               autoWidth = TRUE,
                               initComplete = JS(
                                 "function(settings, json) {",
                                 "$(this.api().table().header()).css({'background-color': '#3F3685', 'color': 'white'});",
                                 "}"), # Make header phs-purple
                               order = tab_order),

                filter = "top",
                colnames = table_colnames) %>%
    formatStyle(
      highlight_column, target="row",
      backgroundColor = styleEqual(c("Cumulative"),
                                   c(phs_colours("phs-magenta"))), # highlight Scotland rows in phs-magenta
      fontWeight = styleEqual(c("Cumulative"), c("bold")),
      color = styleEqual(c("Cumulative"), c("white"))
    )

  return(dt)


}


# Data table with breakdown by Health Board
byboard_data_table <- function(input_data_table,
                               board_name_column,  # Name of the column with board names e.g. "NHS Board"
                               add_separator_cols=NULL, # Column indices to add thousand separators to
                               rows_to_display=14,
                               flip_order=FALSE){ # Number of Boards + 1 for Scotland

  if(flip_order){
    tab_order <- list(list(0, "asc"))
  } else {
    tab_order <- list(list(0, "desc"))
  }

  # Remove the underscore from column names in the table
  table_colnames  <-  gsub("_", " ", colnames(input_data_table))

  # Add column formatting

  for (i in add_separator_cols){
    input_data_table[i] <- apply(input_data_table[i], MARGIN=1, FUN=format_entry)
  }

  dt <- DT::datatable(input_data_table, style = 'bootstrap',
                class = 'table-bordered table-condensed',
                rownames = FALSE,
                options = list(pageLength = rows_to_display, # Health Boards and total
                               order = tab_order, # Most recent week first
                               dom = 'tip',
                               autoWidth = TRUE,
                               initComplete = JS(
                                 "function(settings, json) {",
                                 "$(this.api().table().header()).css({'background-color': '#3F3685', 'color': 'white'});",
                                 "}") # Make header phs-purple
                ),
                filter = "top",
                colnames = table_colnames) %>%
    formatStyle(
      board_name_column, target="row",
      backgroundColor = styleEqual(c("Scotland", "Total", "All"),
                                   c(phs_colours("phs-magenta"),phs_colours("phs-magenta"),phs_colours("phs-magenta"))), # highlight Scotland rows in phs-magenta
      fontWeight = styleEqual(c("Scotland", "Total", "All"), c("bold", "bold", "bold")),
      color = styleEqual(c("Scotland", "Total", "All"), c("white", "white", "white"))
    )

  return(dt)

}
