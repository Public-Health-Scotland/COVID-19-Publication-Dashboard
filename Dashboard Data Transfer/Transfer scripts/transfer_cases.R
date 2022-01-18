# Dashboard data transfer for Hospital Admissions
# Sourced from ../dashboard_data_transfer.R

##### 13. Hospital Admissions

i_cadm <- read_csv_with_options(glue("Input data/Hospital Admissions/{format(report_date -2,'%Y%m%d')}_Cases_Adm_Wk_Scotland.csv"))
i_cag <- read_csv_with_options(glue("Input data/Hospital Admissions/{format(report_date -2,'%Y%m%d')}_Cases_Adm_Wk_AgeGrp.csv"))

o_cadm <- read.csv(glue("{output_folder}/Cases_Adm.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_cag <- read.csv(glue("{output_folder}/Cases_AgeGrp.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

### a) Cases Admissions

g_cadm <- i_cadm %>% 
  select(week_ending, p.admissions) %>% 
  dplyr::rename(Date = week_ending,
                Percent = p.admissions)

write.csv(g_cadm, glue("Test output/Cases_Adm.csv"), row.names = FALSE)

rm(i_cadm, g_cadm, o_cadm)

### b) Cases by Age Group

g_cag <- i_cag %>% 
  select(week_ending, SG_Age_Band, cases) %>% 
  dplyr::rename(Date = week_ending,
                Age = SG_Age_Band,
                Cases = cases)

write.csv(g_cag, glue("Test output/Cases_AgeGrp.csv"), row.names = FALSE)

rm(i_cag, g_cag, o_cag)
