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

rm(g_cag, o_cag)


### c) Proportion of Case Admissions by Age Group (added 24/1/22 - RV)

prop_adm = i_cag %>%
  # Removing square brackets
  dplyr::mutate(SG_Age_Band = gsub(pattern = "\\[|\\]",
                                   replacement = "",
                                   SG_Age_Band),
                # Adding % sign
                p.admissions = paste0(format
                                      (round_half_up
                                        (p.admissions, 1), nsmall = 1), "%"),
                # Suppression:
                # Suppress for fewer than 5 in cases or admissions
                # If just one suppressed, proportion also suppressed
                # Otherwise no suppression
                cases = ifelse(
                  cases<5, "*", cases),
                admissions = ifelse(
                  admissions<5, "*", admissions),
                p.admissions = case_when(
                  cases == "*" & admissions == "*" ~ p.admissions,
                  cases != "*" & admissions != "*" ~ p.admissions,
                  TRUE ~ "*"
                )) %>%
  # Renaming column headers
  dplyr::rename(Date = week_ending,
                Age = SG_Age_Band,
                Cases = cases,
                Admissions = admissions,
                "Proportion Admitted" = p.admissions)

write.csv(prop_adm, glue("Test output/Prop_Admitted_AgeGrp.csv"))

rm(prop_adm, i_cag)