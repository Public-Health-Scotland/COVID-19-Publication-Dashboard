# Dashboard data transfer for Healthcare Workers
# Sourced from ../dashboard_data_transfer.R

##### 10. Health Care Workers

i_elderly <- read_all_excel_sheets(glue(input_data, "HCW/{format(report_date -2,'%Y%m%d')}_long_stay_care_of_the_elderly.xlsx"))
i_psychiatry <- read_all_excel_sheets(glue(input_data, "HCW/{format(report_date -2,'%Y%m%d')}_long_stay_psychiatry_and_learning_disability.xlsx"))
i_cancer <- read_all_excel_sheets(glue(input_data, "HCW/{format(report_date -2,'%Y%m%d')}_specialist_cancer_wards_and_treatment_areas.xlsx"))

o_elderly <- read.csv(glue("{output_folder}/HCW_CareOfElderly.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_psychiatry <- read.csv(glue("{output_folder}/HCW_Psychiatry.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_cancer <- read.csv(glue("{output_folder}/HCW_SpecialistCancer.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

################ Function to apply suppression#### ################

HCW_suppress <- function(    df,
                             suppress_under = 5,
                             cols_to_ignore = 2,
                             replace_with = "*"){

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
  # If only one *, star out the next smallest
  for(i in seq(1,nrow(df))){
    selection <- chardf[i,(cols_to_ignore+1):length(chardf)]
    mask <- selection == replace_with
    num_stars <- length(selection[mask[1,]])
    if(num_stars == 1){
      seln <- selection %>% mutate_if(is.character, as.numeric)
      seln[seln==0] <- NA
      minloc <- names(which.min(seln))
      chardf[i,minloc] <- replace_with
      selection[,minloc] <- replace_with
    }
    # If number of positive tests is suppressed, star out positive rate
    selection <- chardf[i,(cols_to_ignore+1):length(chardf)]
    mask <- selection == replace_with
    num_stars <- length(selection[mask[1,]])
    numpos <- selection$`Number of Positive Tests`
    if(is.na(numpos)){
      numpos <- "0"
    }
    if(numpos == "*"){
      chardf$`Positive rate per 10,000`[i] <- "*"
    }
    # If number staff declied to test is suppressed, star out not tested exc. declines
    selection <- chardf[i,(cols_to_ignore+1):length(chardf)]
    mask <- selection == replace_with
    numdec <- selection$`Number of Staff decline to test`
    if(is.na(numdec)){
      numdec <- "0"
    }
    if(numdec == "*"){
      chardf$`Number of staff not tested exc. Declines`[i] <- "*"
    }
  }
  return(chardf)

}



################ Function to produce and save outputs for each of the categories ################

hcw_transfer <- function(i_file, o_file, tag){

  g_file <- i_file$`Sheet 1`

  # Getting most recent week
  g_file <- g_file[g_file$`Week Ending` == max(g_file$`Week Ending`),] %>%
    dplyr::rename(`Number of staff not tested exc. Declines` = `Number of staff not tested (excl decline/operational)`) %>%
    select(names(o_file))

  o_file$`Week Ending` <- as.Date(o_file$`Week Ending`, format="%Y-%m-%d")
  o_file %<>% filter(`Week Ending` != max(g_file$`Week Ending`))

  # Suppress entries <5, note 2 constraints because in terms of columns of g_file,
  # 3 = 4 + 7 + 8 + 9; 6 = 5/4 are two constraints
  g_file <- HCW_suppress(g_file, suppress_under = 5, cols_to_ignore = 2, replace_with = "*")

  g_file <- rbind(o_file, g_file)

  write.csv(g_file, glue(test_output, "HCW_{tag}.csv"), row.names = FALSE)


}

##################################################################################################

### a) Long stay care of the elderly

hcw_transfer(i_file = i_elderly, o_file = o_elderly, tag = "CareOfElderly")

### b) Long stay psychiatry and learning disability

hcw_transfer(i_file = i_psychiatry, o_file = o_psychiatry, tag = "Psychiatry")

### c) Specialist cancer wards and treatment areas

hcw_transfer(i_file = i_cancer, o_file = o_cancer, tag = "SpecialistCancer")




