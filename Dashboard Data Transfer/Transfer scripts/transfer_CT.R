# Dashboard data transfer for Contact tracing
# Sourced from ../dashboard_data_transfer.R

##### 12. Contact Tracing

i_cccc <- read_all_sheets(glue("Input data/Contact Tracing/{format(report_date -2,'%Y%m%d')}_case_created_case_closed.xlsx"))
i_ccic <- read_all_sheets(glue("Input data/Contact Tracing/{format(report_date -2,'%Y%m%d')}_case_created_to_interview_completed.xlsx"))
i_casi <- read_all_sheets(glue("Input data/Contact Tracing/{format(report_date -2,'%Y%m%d')}_contacts_advised_to_self_isolate.xlsx"))
i_ctp <- read_all_sheets(glue("Input data/Contact Tracing/{format(report_date -2,'%Y%m%d')}_contacts_testing_positive.xlsx"))
i_ct <- read_all_sheets(glue("Input data/Contact Tracing/{format(report_date -2,'%Y%m%d')}_cumulative_totals.xlsx"))
i_teic <- read_all_sheets(glue("Input data/Contact Tracing/{format(report_date -2,'%Y%m%d')}_test_effective_to_interview_completed.xlsx"))
i_wco <- read_all_sheets(glue("Input data/Contact Tracing/{format(report_date -2,'%Y%m%d')}_weekly_cms_output.xlsx"))
i_wfr <- read_all_sheets(glue("Input data/Contact Tracing/{format(report_date -2,'%Y%m%d')}_weekly_failed_reasons_output.xlsx"))



o_a <- read.csv(glue("{output_folder}/ContactTracing_Average.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_tp <- read.csv(glue("{output_folder}/ContactTracing_Testing_Positive.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_ct <- read.csv(glue("{output_folder}/ContactTime.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_f <- read.csv(glue("{output_folder}/ContactTracingFail.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_wc <- read.csv(glue("{output_folder}/ContactTracingWeeklyCases.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_wcum <- read.csv(glue("{output_folder}/ContactTracingWeeklyCumulative.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

  
### a) Average

extract <- i_wco$`Sheet 1`[i_wco$`Sheet 1`$`CMS Outputs` == "Average Number of Contacts per Case",]
`Week Ending` <- unname(unlist(names(extract)[2:length(extract)]))
`Average Number of Contacts` <- unname(unlist(extract[2:length(extract)]))

g_a <- data.frame(`Week Ending`, `Average Number of Contacts`) %>% 
  dplyr::rename(`Week Ending` = Week.Ending, `Average Number of Contacts` = Average.Number.of.Contacts) %>% 
  mutate(`Age Band` = "All Ages") %>% 
  select(`Week Ending`, `Age Band`,`Average Number of Contacts`)


# Adding years to dates

o_a$`Week Ending` <- as.Date(o_a$`Week Ending`) 
start_date <- o_a$`Week Ending`[[1]]
dates <- seq(start_date, (start_date + 7*(length(`Week Ending`)-1)), by="week")
g_a$`Week Ending` <- dates


write.csv(g_a, glue("Test output/ContactTracing_Average.csv"), row.names = FALSE)

#rm(extract, `Week Ending`, `Average Number of Contacts`, g_a, o_a, start_date, dates)

### b) Testing Positive

g_tp <- i_ctp$`Sheet 1`

write.csv(g_tp, glue("Test output/ContactTracing_Testing_Positive.csv"), row.names = FALSE)

### c) Contact Time

g_teic <- i_teic$`Sheet 1` %>% 
  mutate(Measure = "Test to interview completed") %>% 
 # dplyr::rename(X..of.Total.Index.Cases = `%.of.Total.Index.Cases`) %>% 
  select(names(o_ct)) 

g_teic$week_ending <- format(as.Date(g_teic$week_ending, format= "%Y%m%d"), format="%Y-%m-%d")

g_ccic <- i_ccic$`Sheet 1` %>% 
  mutate(Measure = "Case created to interview completed") %>% 
 # dplyr::rename(X..of.Total.Index.Cases = `%.of.Total.Index.Cases`) %>% 
  select(names(o_ct)) 

g_ccic$week_ending <- format(as.Date(g_ccic$week_ending, format= "%Y%m%d"), format="%Y-%m-%d")

g_cccc <- i_cccc$`Sheet 1` %>% 
  mutate(Measure = "Case created to case closed") %>% 
 # dplyr::rename(X..of.Total.Index.Cases = `%.of.Total.Index.Cases`) %>% 
  select(names(o_ct)) 

g_cccc$week_ending <- format(as.Date(g_cccc$week_ending, format= "%Y%m%d"), format="%Y-%m-%d")

g_ct <- rbind(g_teic, g_ccic) %>% rbind(g_cccc) 
  
write.csv(g_ct, glue("Test output/ContactTime.csv"), row.names = FALSE)

#rm(g_tp, g_teic, g_ccic, g_cccc, g_ct, i_ccic, i_teic, i_cccc)

### d) Fail

g_f <- i_wfr$`Sheet 1` %>% 
  dplyr::rename(`Week Ending` = week_ending,
                `Reason incomplete` = index_reason_for_failure,
                `Number of index cases` = `Reason For Failure`,
                `% of incomplete index cases` = `% of Total Failures`)

g_f$`Week Ending` <- format(as.Date(g_f$`Week Ending`, format= "%Y%m%d"), format="%Y-%m-%d")


write.csv(g_f, glue("Test output/ContactTracingFail.csv"), row.names = FALSE)

#rm(g_f, i_wfr)


### e) Weekly Cases

g_wc <- data.frame(t(i_wco$`Sheet 1`)) %>% 
  row_to_names(row_number = 1)

g_wc <- cbind(`Week ending` = rownames(g_wc), g_wc)
rownames(g_wc) <- 1:nrow(g_wc) 

g_wc %<>% dplyr::rename(
                        `Percentage in Progress` = `Percentage In Progress`,
                        `Distinct Contacts` = `Distinct Deduplicated Contacts`)
# Update date to include year
o_wc$`Week ending` <- as.Date(o_wc$`Week ending`) 
start_date <- o_wc$`Week ending`[[1]]
dates <- seq(start_date, (start_date + 7*(nrow(g_wc)-1)), by="week")
g_wc$`Week ending` <- dates
g_wc %<>% dplyr::rename(`Incomplete Cases` = `Failed Cases`,
                        `Percentage Incomplete` = `Percentage Failed`) 

write.csv(g_wc, glue("Test output/ContactTracingWeeklyCases.csv"), row.names = FALSE)

#rm(g_wc, o_wc, start_date, dates)


### f) Weekly Cumulative

g_wcum <- i_ct$`Sheet 1`

g_wcum$Outputs[g_wcum$Outputs == "Distinct Deduplicated Contacts"] <- "Distinct Contacts"
g_wcum$Outputs[g_wcum$Outputs == "Contacts"] <- "Total Contacts"
g_wcum$Outputs[g_wcum$Outputs == "Failed Cases"] <- "Incomplete Cases"

write.csv(g_wcum, glue("Test output/ContactTracingWeeklyCumulative.csv"), row.names = FALSE)

#rm(g_wcum, i_ct, i_wco, i_whbo, i_wlao, i_ctp, i_coe, i_caso, o_f, o_tp, o_wcum, o_ct, i_casi)



