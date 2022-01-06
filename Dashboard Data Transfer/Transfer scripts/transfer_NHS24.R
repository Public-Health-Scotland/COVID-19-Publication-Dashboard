# Dashboard data transfer for NHS24 
# Sourced from ../dashboard_data_transfer.R

##### 1. NHS24

i_nhs24 <- read_all_sheets("Input data/2.1 NHS24 Covid-19 Advice.xlsx")
i_sitrep <- read_all_sheets(glue("Input data/CoronavirusSitRep_{format(report_date -3,'%Y%m%d')}.xlsx"))


o_nhs24 <- read.csv(glue("{output_folder}/NHS24.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_nhs24_agesex <- read.csv(glue("{output_folder}/NHS24_AgeSex.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_nhs24_simd <- read.csv(glue("{output_folder}/NHS24_SIMD.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

### a) NHS24

g_nhs24 <- i_nhs24$`Total Daily COVID Calls` %>% dplyr::rename(Date = `NHS 24 Call Rcvd Date`,
                                                        Count = `Number of NHS 24 Records`)
# Getting last week's entries for 2nd column output from sitrep
helpline_lastweek <- i_sitrep$Summary %>% 
  select(c("Date:", "Coronavirus Helpline Calls Offered")) %>% 
  dplyr::rename(Date = `Date:`,
         CoronavirusHelpline = `Coronavirus Helpline Calls Offered`)
helpline_lastweek <- helpline_lastweek[2:8,]

# Get entries from o_nhs24 up to the last week
helpline_previousweeks <- o_nhs24 %>% 
  filter(Date < (report_date -7)) %>% 
  select(Date, CoronavirusHelpline)

helpline <- rbind(helpline_previousweeks, helpline_lastweek) %>% 
  mutate_if(is.character,as.Date)

g_nhs24 %<>% left_join(helpline, by="Date")

write.csv(g_nhs24, glue("Test output/NHS24.csv"), row.names = FALSE)

rm(g_nhs24, helpline, helpline_lastweek, helpline_previousweeks, o_nhs24)

### b) NHS24_AgeSex

g_agesexdata <- i_nhs24$`Agegroup - gender` %>% 
  dplyr::rename(Female = FEMALE,
         Male = MALE,
         Unknown = `NOT KNOWN`,
         age_group = X1) %>% 
  adorn_totals(where=c("row", "col")) %>% 
  melt(id=c("age_group"), variable="sex") %>% 
  dplyr::rename(number=value) %>% 
  select(sex, age_group, number) %>% 
  arrange(factor(sex, levels = c("Male", "Female", "Unknown")))

# Rename Total <- All in age_group column

g_agesexdata$age_group[g_agesexdata$age_group == "Total"] <- "All"

# Get rate data using population file
g_agesexdata %<>% left_join(i_population, by=c("age_group", "sex")) %>% 
  mutate(rate = 100000*number/pop_number) %>% 
  select(sex, age_group, number, rate) %>% 
  arrange(factor(sex, levels = c("Male", "Female", "Unknown")))

write.csv(g_agesexdata, glue("Test output/NHS24_AgeSex.csv"), row.names = FALSE)

rm(g_agesexdata)

### c) NHS24_SIMD

deprivation <- i_nhs24$Deprivation

g_simd <- o_nhs24_simd %>% 
  transform(cases = deprivation$`Number of NHS 24 Records`) %>% 
  transform(cases_pc = cases/sum(cases))


write.csv(g_simd, glue("Test output/NHS24_SIMD.csv"), row.names = FALSE)

rm(g_simd, deprivation, i_nhs24, i_sitrep, o_nhs24_agesex, o_nhs24_simd)
