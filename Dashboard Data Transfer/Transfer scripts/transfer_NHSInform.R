# Dashboard data transfer for NHS Inform
# Sourced from ../dashboard_data_transfer.R

##### 1. NHS Inform

i_sitrep <- read_all_excel_sheets(glue(input_data, "CoronavirusSitRep_{format(report_date -3,'%Y%m%d')}.xlsx"))

o_inform <- read.csv(glue("{output_folder}/NHSInform.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

last_week_data <- i_sitrep$Summary[2:8,] %>%
  select(`Date:`, `Number of NHS Inform hits for COVID19 section of NHS Inform`) %>%
  dplyr::rename(date = `Date:`,
                count = `Number of NHS Inform hits for COVID19 section of NHS Inform`)

o_inform %<>% filter(date < min(last_week_data$date))

g_inform <- rbind(o_inform, last_week_data)

write.csv(g_inform, glue(test_output, "NHSInform.csv"), row.names = FALSE)

rm(g_inform, o_inform, last_week_data, i_sitrep)
