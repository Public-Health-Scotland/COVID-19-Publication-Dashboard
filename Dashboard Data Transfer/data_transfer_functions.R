##### Functions for transferring data to the dashboard
##### sourced from dashboard_data_transfer.R

# Function for row-wise suppression
# ---------------------------------

suppress_rowwise <- function(df,
                             suppress_under = 5,
                             cols_to_ignore = 0,
                             replace_with = "*",
                             constraints = 0){

  #  TODO: Make this less horrendous
  #  df: data frame to suppress rowwise
  #  suppress_under: number to suppress under, default = 5
  #  cols_to_ignore: number of columns at start of dataframe not to be suppressed, default = 0
  #  replace_with: character to replace suppressed values with, default = "*"
  #  constraints: number of constraints, e.g. if there is a Total column this is one constraint

  # Change dataframe column type to char so that can replace with "*"
  df[is.na(df)] <- 0
  chardf <- mutate_if(df, is.integer,as.character) %>% mutate_if(is.numeric,as.character)

  # Primary
  chardf[df < suppress_under & df != 0] <- replace_with

  # Secondary
  for(i in seq(1,nrow(df))){
    row_constraints <- constraints
    selection <- chardf[i,(cols_to_ignore+1):length(chardf)]
    mask <- selection == replace_with
    num_stars <- length(selection[mask[1,]])
    if(num_stars == 1){
      while(row_constraints > 0){
        seln <- selection %>% mutate_if(is.character, as.numeric)
        seln[seln==0] <- NA
        minloc <- names(which.min(seln))
        chardf[i,minloc] <- replace_with
        selection[,minloc] <- replace_with
        row_constraints <- row_constraints -1
      }
    }
  }
  return(chardf)

}








