# Dashboard data transfer for Admissions
# Sourced from ../dashboard_data_transfer.R

##### 5. Admissions

adm_path <- "/conf/PHSCOVID19_Analysis/RAPID Reporting/Daily_extracts"

i_adm <- read_all_excel_sheets(glue("{adm_path}/12_Admissions_Positives_provisional.xlsx"))

read_rds_with_options <- create_loader_with_options(readRDS)
i_chiadm <- read_rds_with_options(glue("{adm_path}/CHI_Admissions_Positives_provisional.rds"))

o_adm_simd <- read.csv(glue("{output_folder}/Admissions_SIMD.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

# Filter CHI and 12 files down to last Tuesday
i_chiadm %<>% filter(admission_date <= (report_date - 3))
i_adm$`12 Admissions Positives` %<>% filter(admission_date <= (report_date - 10))


### a) Admissions

g_adm <- i_adm$`12 Admissions Positives`
# Replace any NA with 0
g_adm[is.na(g_adm)] <- 0

g_adm %<>%
  dplyr::rename(ADMISSION_DATE1 = admission_date,
                TESTEDIN = TestDIn) %>%
  mutate(Average7 = zoo::rollmean(TESTEDIN, k = 7, fill = NA, align="right")) %>%
  mutate(ADMISSION_DATE1 = case_when(
    ADMISSION_DATE1 > (report_date-10) ~ paste0(as.character(ADMISSION_DATE1), "p"),
    TRUE ~ as.character(ADMISSION_DATE1))
    )


write.csv(g_adm, glue(output_folder, "Admissions.csv"), row.names = FALSE)

rm(g_adm)

### b) Admissions_AgeBD

g_adm_agebd <- i_chiadm %>%
  mutate(Admission_date_week_ending_Sunday = ceiling_date(
    as.Date(admission_date),unit="week",week_start=7, change_on_boundary=FALSE)
  ) %>%
  mutate(
    age_year = as.numeric(age_year),
    custom_age_group = case_when(age_year < 18 ~ 'Under 18',
                                      age_year < 30 ~ '18-29',
                                      age_year < 40 ~ '30-39',
                                      age_year < 50 ~ '40-49',
                                      age_year < 55 ~ '50-54',
                                      age_year < 60 ~ '55-59',
                                      age_year < 65 ~ '60-64',
                                      age_year < 70 ~ '65-69',
                                      age_year < 75 ~ '70-74',
                                      age_year < 80 ~ '75-79',
                                      age_year < 200 ~ '80+',
                                      is.na(age_year) ~ 'Unknown')) %>%
  group_by(Admission_date_week_ending_Sunday, custom_age_group) %>%
  summarise(count_by_agegroup = n()) %>%
  ungroup() %>%
  pivot_wider(names_from = custom_age_group, values_from = count_by_agegroup) %>%
  adorn_totals(where=c("col")) %>%
  select(Admission_date_week_ending_Sunday,
         `Under 18`, `18-29`, `30-39`, `40-49`, `50-54`, `55-59`, `60-64`, `65-69`, `70-74`, `75-79`, `80+`, Total)

# Apply suppression
g_adm_agebd <- suppress_rowwise(g_adm_agebd,
                                suppress_under = 5,
                                cols_to_ignore = 1,
                                replace_with = "*",
                                constraints = 1)  %>%
  mutate(Admission_date_week_ending_Sunday = case_when(
    Admission_date_week_ending_Sunday > (report_date-10) ~ paste0(as.character(Admission_date_week_ending_Sunday), "p"),
    TRUE ~ as.character(Admission_date_week_ending_Sunday))
  )


write.csv(g_adm_agebd, glue(output_folder, "Admissions_AgeBD.csv"), row.names = FALSE)

rm(g_adm_agebd,i,selection, mask, num_stars, minloc)

### c) Admissions_AgeSex

g_adm_agesex <- i_chiadm %>%
  mutate(custom_age_group_2 = case_when(age_year < 5 ~ '0-4',
                                        age_year < 15 ~ '5-14',
                                        age_year < 20 ~ '15-19',
                                        age_year < 25 ~ '20-24',
                                        age_year < 45 ~ '25-44',
                                        age_year < 65 ~ '45-64',
                                        age_year < 75 ~ '65-74',
                                        age_year < 85 ~ '75-84',
                                        age_year < 200 ~ '85+',
                                        is.na(age_year) ~ 'Unknown')) %>%
  group_by(custom_age_group_2, sex) %>%
  summarise(number = n()) %>%
  dplyr::rename(age_group = custom_age_group_2) %>%
  select(sex, age_group, number)


g_adm_agesex$sex[g_adm_agesex$sex == "F"] <- "Female"
g_adm_agesex$sex[g_adm_agesex$sex == "M"] <- "Male"


# Add totals
g_adm_agesex$number %<>% as.numeric(g_adm_agesex$number)

male <-  c("Male", "All",
           sum(g_adm_agesex$number[g_adm_agesex$sex == "Male"])
           )

female <- c("Female", "All",
            sum(g_adm_agesex$number[g_adm_agesex$sex == "Female"])
            )

g_adm_agesex$number %<>% as.character(g_adm_agesex$number)

g_adm_agesex[nrow(g_adm_agesex) + 1, ] <- as.list(male)
g_adm_agesex[nrow(g_adm_agesex) + 1, ] <- as.list(female)


agegroups <- unique(g_adm_agesex$age_group)

for(agegroup in agegroups){

  num <- as.numeric(g_adm_agesex$number[g_adm_agesex$age_group == agegroup])
#  pop <-  as.numeric(g_adm_agesex$population[g_adm_agesex$age_group == agegroup])


  newline <- c("Total", agegroup,
               sum(num)
               )

  g_adm_agesex[nrow(g_adm_agesex) + 1, ] <- as.list(newline)

}

g_adm_agesex$number <- as.numeric(g_adm_agesex$number)

# Add population

g_adm_agesex %<>% left_join(i_population, by=c("age_group", "sex")) %>%
  mutate(rate = 100000*number/pop_number) %>%
  select(-c("pop_number")) %>%
  arrange(factor(age_group, levels= c("0-4", "5-14", "15-19", "20-24", "25-44","45-64", "65-74", "75-84", "85+", "Unknown"))) %>%
  arrange(factor(sex, levels = c("Male", "Female", "Unknown")))

write.csv(g_adm_agesex, glue(output_folder, "Admissions_AgeSex.csv"), row.names = FALSE)

rm(g_adm_agesex, num, pop, newline, agegroups, male, female)


### d) Admissions_AgeSIMD

g_adm_simd <- i_chiadm %>%
  group_by(simd2020v2_sc_quintile) %>%
  summarise(cases = n()) %>%
  dplyr::rename(SIMD = simd2020v2_sc_quintile) %>%
  mutate(cases_pc = cases/sum(cases))

g_adm_simd$SIMD <- o_adm_simd$SIMD

write.csv(g_adm_simd, glue(output_folder, "Admissions_SIMD.csv"), row.names = FALSE)

rm(g_adm_simd)


### e) Admissions by age group

g_adm_agegroup  <- i_chiadm %>%
  mutate(custom_age_group_2 = case_when(age_year < 5 ~ '0-4',
                                        age_year < 15 ~ '5-14',
                                        age_year < 20 ~ '15-19',
                                        age_year < 25 ~ '20-24',
                                        age_year < 45 ~ '25-44',
                                        age_year < 65 ~ '45-64',
                                        age_year < 75 ~ '65-74',
                                        age_year < 85 ~ '75-84',
                                        age_year < 200 ~ '85+',
                                        is.na(age_year) ~ 'Unknown')) %>%
  mutate(week_ending = ceiling_date(admission_date, unit = "week", change_on_boundary = F)) %>%
  group_by(week_ending, custom_age_group_2) %>%
  summarise(number = n()) %>%
  dplyr::rename(Age = custom_age_group_2,
                Date = week_ending,
                Admissions = number)

write.csv(g_adm_agegroup, glue(output_folder, "Admissions_AgeGrp.csv"), row.names = FALSE)

rm(g_adm_agegroup, adm_path)


