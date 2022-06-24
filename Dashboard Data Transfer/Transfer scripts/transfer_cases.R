# Dashboard data transfer for Hospital Admissions
# Sourced from ../dashboard_data_transfer.R

##### 13. Hospital Admissions

i_cag <- read_csv_with_options(glue(input_data, "Hospital Admissions/{format(report_date -2,'%Y%m%d')}_Cases_Adm_Wk_AgeGrp.csv"))

### a) Admissions by Age Group

adm_agegrp <- i_cag %>%
  select(week_ending, age_band, admissions) %>%
  dplyr::rename(Date = week_ending,
                Age = age_band,
                Admissions = admissions)

write.csv(adm_agegrp, glue(output_folder, "Admissions_AgeGrp.csv"), row.names = FALSE)

rm(prop_adm, i_cag, adm_agegrp)
