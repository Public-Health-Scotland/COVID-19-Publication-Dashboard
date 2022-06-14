# Dashboard data transfer for Community Hubs and Assessment
# Sourced from ../dashboard_data_transfer.R

###### 3. Community Hubs and Assessment

i_cha <- read_all_excel_sheets(glue(input_data, "2.2_Community_Hubs_and_Assessment.xlsx"))
i_sitrep <- read_all_excel_sheets(glue(input_data, "CoronavirusSitRep_{format(report_date -3,'%Y%m%d')}.xlsx"))


#o_cha <- read.csv(glue("{output_folder}/AssessmentHub.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
#o_cha_agesex <- read.csv(glue("{output_folder}/AssessmentHub_AgeSex.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_cha_simd <- read.csv(glue("{output_folder}/AssessmentHub_SIMD.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

### a) AssessmentHub

g_cha <- i_cha$`COVID Consultations`
g_cha %<>%
  data.table::transpose(keep.names=names(g_cha)[[2]], make.names=1) %>%
  head(-1) %>%
  dplyr::rename(Date = 1) %>%
  dplyr::rename(CountAdvice = `COVID19 ADVICE`,
                CountAssessment = `COVID19 ASSESSMENT`,
                CountOther = OTHER,
                Total = `Sum:`)


write.csv(g_cha, glue(output_folder, "AssessmentHub.csv"), row.names = FALSE)

rm(g_cha)

### b) AssessmentHub_AgeSex

g_agesexdata <- i_cha$`Age and Gender Total`
g_agesexdata[is.na(g_agesexdata)] <- 0

g_agesexdata %<>%
  head(-1) %>%
  mutate(Unknown = `NOT KNOWN` + `NOT SPEC`) %>%
  select(-c(`NOT KNOWN`, `NOT SPEC`)) %>%
  dplyr::rename(age_group = X1,
                Male = MALE,
                Female = FEMALE) %>%
  adorn_totals(where=c("row", "col")) %>%
  melt(id=c("age_group"), variable="sex") %>%
  dplyr::rename(number=value) %>%
  select(sex, age_group, number) %>%
  arrange(factor(sex, levels = c("Male", "Female", "Unknown")))


# Rename Total <- All in age_group column to join with population

g_agesexdata$age_group[g_agesexdata$age_group == "Total"] <- "All"


# Get rate data using population file
g_agesexdata %<>% left_join(i_population, by=c("age_group", "sex")) %>%
  mutate(rate = 100000*number/pop_number) %>%
  select(sex, age_group, number, rate) %>%
  arrange(factor(sex, levels = c("Male", "Female", "Unknown")))

# Rename All <- all in age_group column to match output
g_agesexdata$age_group[g_agesexdata$age_group == "All"] <- "all"

write.csv(g_agesexdata, glue(output_folder, "AssessmentHub_AgeSex.csv"), row.names = FALSE)

rm(g_agesexdata)

### c) AssessmentHub_SIMD

deprivation <- i_cha$`SIMD total` %>%  head(-1)
deprivation <- rbind(names(deprivation), deprivation)
names(deprivation) <- c("SIMD", "cases")

deprivation$SIMD <- o_cha_simd$SIMD

deprivation$cases <- as.numeric(deprivation$cases)

deprivation %<>% transform(cases_pc = cases/sum(cases))


write.csv(deprivation, glue(output_folder, "AssessmentHub_SIMD.csv"), row.names = FALSE)

rm(deprivation, o_cha_simd, i_sitrep)


