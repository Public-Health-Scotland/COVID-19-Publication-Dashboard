# Dashboard data transfer for LFDs
# Sourced from ../dashboard_data_transfer.R

##### 18. LFDs

i_lfd <- read_all_sheets(glue("Input data/{format(report_date -2,'%Y%m%d')}_LFT_publication_output.xlsx"))

#o_lfd <- read.csv(glue("{output_folder}/LFD_Board.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)


### a) Breakdown by HB
g_lfd <- i_lfd$`NHS Board`

write.csv(g_lfd, glue("Test output/LFD_Board.csv"), row.names = FALSE)

### b) Weekly trend

g_lfdtrend <- i_lfd$`Number of Tests Weekly` %>%
  dplyr::rename(`Week Ending` = week_ending,
                `Number of LFD Tests` = n) %>% head(-1) # Removing last entry as not complete

write.csv(g_lfdtrend, glue("Test output/LFD_Weekly.csv"), row.names = FALSE)

### c) Weekly trend by test group

g_lfdtestgroup <- i_lfd$`` %>%
  dplyr::rename(`Week Ending` = week_ending,
                `Test Group` = test_group,
                `Number of LFD Tests` = LFD_tests,
                `Number of Positive Tests` = LFD_positives) #  %>% head(-1) is this needed?

write.csv(g_lfdtestgroup, glue("Test output/LFD_TestGroup.csv"), row.names = FALSE)

rm(i_lfd, g_lfd, g_lfdtestgroup)