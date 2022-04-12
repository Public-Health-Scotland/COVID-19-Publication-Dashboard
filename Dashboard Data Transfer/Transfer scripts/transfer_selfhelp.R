# Dashboard data transfer for Self Help Guides
# Sourced from ../dashboard_data_transfer.R

##### 14. Self Help Guides

i_sitrep <- read_all_excel_sheets(glue(input_data, "CoronavirusSitRep_{format(report_date -3,'%Y%m%d')}.xlsx"))

o_sh <- read.csv(glue("{output_folder}/SelfHelpGuides.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

g_sh <- i_sitrep$Summary %>%
  select(`Date:`, `COVID19 Self Help Guides Completed`, `COVID19 Self help guide - User advised to isolate`) %>%
  dplyr::rename(Date = `Date:`,
                selfhelp = `COVID19 Self Help Guides Completed`,
                isolate = `COVID19 Self help guide - User advised to isolate`)

g_sh <- g_sh[2:8,]

o_sh$Date <- as.Date(o_sh$Date)
g_sh$Date <- as.Date(g_sh$Date)

o_sh %<>% filter(Date < min(g_sh$Date))

g_sh <- rbind(o_sh, g_sh)

write.csv(g_sh, glue(test_output, "SelfHelpGuides.csv"), row.names = FALSE)

rm(i_sitrep, o_sh, g_sh)