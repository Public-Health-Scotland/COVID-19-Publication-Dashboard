# Dashboard data transfer for Hospital Admissions
# Sourced from ../dashboard_data_transfer.R

##### 13. Hospital Admissions

i_cadm <- read_csv_with_options(glue(input_data, "Hospital Admissions/{format(report_date -2,'%Y%m%d')}_Cases_Adm_Wk_Scotland.csv"))
i_cag <- read_csv_with_options(glue(input_data, "Hospital Admissions/{format(report_date -2,'%Y%m%d')}_Cases_Adm_Wk_AgeGrp.csv"))

o_cadm <- read.csv(glue("{output_folder}/Cases_Adm.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_cag <- read.csv(glue("{output_folder}/Cases_AgeGrp.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

### a) Cases Admissions

g_cadm <- i_cadm %>%
  select(week_ending, p.admissions) %>%
  dplyr::rename(Date = week_ending,
                Percent = p.admissions)

write.csv(g_cadm, glue(test_output, "Cases_Adm.csv"), row.names = FALSE)

rm(i_cadm, g_cadm, o_cadm)

### b) Cases by Age Group

g_cag <- i_cag %>%
  select(week_ending, age_band, cases) %>%
  dplyr::rename(Date = week_ending,
                Age = age_band,
                Cases = cases)

write.csv(g_cag, glue(test_output, "Cases_AgeGrp.csv"), row.names = FALSE)

rm(g_cag, o_cag)


### c) Proportion of Case Admissions by Age Group (added 24/1/22 - RV)

prop_adm = i_cag %>%
  # Removing square brackets
  dplyr::mutate(age_band = gsub(pattern = "\\[|\\]",
                                   replacement = "",
                                   age_band),
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
                Age = age_band,
                Cases = cases,
                Admissions = admissions,
                "Proportion Admitted" = p.admissions)

write.csv(prop_adm, glue(test_output, "Prop_Admitted_AgeGrp.csv"), row.names=FALSE)

### d) Cases by Age Group

adm_agegrp <- i_cag %>%
  select(week_ending, age_band, admissions) %>%
  dplyr::rename(Date = week_ending,
                Age = age_band,
                Admissions = admissions)

write.csv(adm_agegrp, glue(test_output, "Admissions_AgeGrp.csv"), row.names = FALSE)

rm(prop_adm, i_cag, adm_agegrp)
