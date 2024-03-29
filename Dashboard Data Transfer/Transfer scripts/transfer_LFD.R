# Dashboard data transfer for LFDs
# Sourced from ../dashboard_data_transfer.R

##### 18. LFDs

i_lfd <- read_all_excel_sheets(glue(input_data, "{format(report_date -2,'%Y%m%d')}_LFT_publication_output.xlsx"))

#o_lfd <- read.csv(glue("{output_folder}/LFD_Board.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)


### a) Breakdown by HB
g_lfd <- i_lfd$`NHS Board`

write.csv(g_lfd, glue(output_folder, "LFD_Board.csv"), row.names = FALSE)

### b) Weekly trend

g_lfdtrend <- i_lfd$`Number of Tests Weekly` %>%
  dplyr::rename(`Week Ending` = week_ending,
                `Number of LFD Tests` = n) %>% head(-1) # Removing last entry as not complete

write.csv(g_lfdtrend, glue(output_folder, "LFD_Weekly.csv"), row.names = FALSE)

### c) Weekly trend by test group

g_lfdtestgroup <- i_lfd$`Test Groups Dashboard` %>%
  dplyr::rename(`Week Ending` = week_ending,
                `Test Group` = test_group)  %>%
  filter(`Week Ending` < report_date) %>%  # Removing entries in the future
  mutate(`Number of Positive Tests` = ifelse(`Number of Positive Tests` < 5,
                                             "*",
                                             `Number of Positive Tests`),
         `Percentage LFD positive` = ifelse(`Number of Positive Tests` == "*",
                                            "*",
                                            `Percentage LFD positive`))


write.csv(g_lfdtestgroup, glue(output_folder, "LFD_TestGroup.csv"), row.names = FALSE)

rm(i_lfd, g_lfd, g_lfdtestgroup)

### d) Demographics file
# ARCHIVED
# copy_bool = file.copy(
#   from="/conf/C19_Test_and_Protect/Test & Protect - Warehouse/LFD_demographics_extract/data/Demographics.csv",
#   to=glue("{output_folder}Demographics.csv"),
#   overwrite=TRUE)
#
# if (copy_bool == FALSE){
#   stop("Failed to copy Demographics.csv to input data. Check that Demographics.csv is in
#         /conf/C19_Test_and_Protect/Test & Protect - Warehouse/LFD_demographics_extract/data")
# }
#
# # Check modified time
#
# modified_time <- file.info(glue("{output_folder}/Demographics.csv"))$mtime
#
# if (modified_time < report_date - weeks(1)){
#   stop("Demographics.csv file is out of date. Was last modified at {modified_time}.")
# }



