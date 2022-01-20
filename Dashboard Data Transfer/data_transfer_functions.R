##### Functions for transferring data to the dashboard
##### sourced from dashboard_data_transfer.R


# Function to choose alternative filename
# ---------------------------------------

suggest_alternative_files <- function(keywords, location, recursive = TRUE){
  
  possibilities <- c()
  
  # Go through the list of keywords and search for files based off them
  for(keyword in keywords){
    key_poss <- list.files(path = location, pattern = keyword, all.files = FALSE,
                                full.names = TRUE, recursive = recursive,
                                ignore.case = TRUE, include.dirs = TRUE, no.. = FALSE)
    
    possibilities <- append(possibilities, key_poss)
    
  }
  
  print(unique(possibilities))
  user_choice <- readline(
    prompt="Should I use one of the above files? Type the number to use, or type 'No' and press Enter.     "
  )
  
  tryCatch(expr = {
    return(possibilities[as.integer(user_choice)]) 
  },
  warning = function(w){ 
    file_choice <- NA
  }
  )
  
}

# Function to read all excel sheets
# ---------------------------------
read_all_sheets = function(xlsxFile, ...) {
  
  xlsxFile <- check_file(xlsxFile)
  
  ##### Read the excel file
  sheet_names = openxlsx::getSheetNames(xlsxFile)
  sheet_list = as.list(rep(NA, length(sheet_names)))
  names(sheet_list) = sheet_names
  for (sn in sheet_names) {
    sheet_list[[sn]] = openxlsx::read.xlsx(xlsxFile, 
                                           sheet=sn, 
                                           sep.names=" ",  
                                           detectDates=TRUE, 
                                           colNames=TRUE, ...)
  }
  return(sheet_list)
  
}


check_file <- function(filename){

  ##### First check file is there and if not suggest alternatives
  if(file.exists(filename) == FALSE){
    message(glue("Could not find file {filename}. Searching for possible alternatives."))
    
    # Get keyword possibilities based off filename
    keywords <- unlist(lapply(strsplit(gsub('[[:digit:]]+', '', basename(filename)), split = '[-_,.]'), 
                              function(z){ z[!is.na(z) & z != "" & z!="xlsx" & z!="csv"]}))
    
    # Suggest alternatives based off keywords
    alternative <- suggest_alternative_files(keywords, dirname(filename))
    
    if(is.na(alternative)){
      
      stop(glue("Could not find file {filename} or suitable alternatives. Terminating script."))
      
    } else{
      
      return(alternative)
    
      }
  } else {
    return(filename)
  }

}

read_csv_with_options <- function(filename){
  
  filename <- check_file(filename)
  readfile <- read.csv(filename, header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
  
  return(readfile)
}

read_excel_with_options <- function(filename){
  
  filename <- check_file(filename)
  readfile <- readxl::read_excel(filename)
  
  return(readfile)
}



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








