# Dashboard data transfer for SAS
# Sourced from ../dashboard_data_transfer.R

###### 4. SAS

i_sas <- read_all_sheets("Input data/2.3 SAS COVID-19 Incidents UCD.xlsx")

#library(readxl)
i_sas_2 <- read_excel_with_options("Input data/2.2 SAS Incidents COVID-19.xlsx.xls")

o_sas <- read.csv(glue("{output_folder}/SAS.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_sasall <- read.csv(glue("{output_folder}/SAS_all.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_sas_agesex <- read.csv(glue("{output_folder}/SAS_AgeSex.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_sas_simd <- read.csv(glue("{output_folder}/SAS_SIMD.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

### a) SAS_all

#g_sasall <- i_sas$`Report 6` %>% 
#  complete(SAS.Call.Start.Date = seq.Date(min(SAS.Call.Start.Date), max(SAS.Call.Start.Date), by="day"))

#g_sasall$Number.of.Incidents[is.na(g_sasall$Number.of.Incidents)] <- 0

recent_sasall_info <- i_sas_2[,6:8] %>% 
  dplyr::rename(date = `Call Started Date...6`,
                allinc = `All Incidents`,
                count = `All SAS Attended Incidents`) %>% 
  select(-c(allinc))

o_sasall$date <- as.Date(o_sasall$date) 

g_sasall <- o_sasall %>% 
  filter(date < min(recent_sasall_info$date)) %>% 
  rbind(recent_sasall_info)

write.csv(g_sasall, glue("Test output/SAS_all.csv"), row.names = FALSE)

rm(g_sasall, recent_sasall_info) 


### b) SAS

recent_sas_info <- i_sas_2[,1:4] %>% dplyr::rename(Date = `Call Started Date...1`)

# Take output file and filter out rows for which there is a replacement
o_sas$Date <- as.Date(o_sas$Date)

g_sas <- o_sas %>% 
  filter(Date < min(recent_sas_info$Date)) %>% 
  rbind(recent_sas_info)

write.csv(g_sas, glue("Test output/SAS.csv"), row.names = FALSE)

rm(g_sas, o_sas, recent_sas_info) 

### c) SAS_AgeSex

g_sas_agesex <- i_sas$`Age Group - Gender` %>% 
  dplyr::rename(Female = FEMALE,
                Male = MALE, 
                age_group = X1,
                Unknown = X4)

g_sas_agesex$age_group[is.na(g_sas_agesex$age_group)] <- "Unknown"

g_sas_agesex %<>% 
  adorn_totals(where=c("row", "col")) %>% 
  melt(id=c("age_group"), variable="sex") %>% 
  dplyr::rename(number=value) %>% 
  select(sex, age_group, number) %>% 
  arrange(factor(sex, levels = c("Male", "Female", "Unknown")))

# Rename Total <- All in age_group column
g_sas_agesex$age_group[g_sas_agesex$age_group == "Total"] <- "All"

# Get rate data using population file
g_sas_agesex %<>% left_join(i_population, by=c("age_group", "sex")) %>% 
  mutate(rate = 100000*number/pop_number) %>% 
  select(sex, age_group, number, rate) %>% 
  arrange(factor(sex, levels = c("Male", "Female", "Unknown")))

write.csv(g_sas_agesex, glue("Test output/SAS_AgeSex.csv"), row.names = FALSE)

rm(g_sas_agesex, o_sas_agesex)

### c) SAS_SIMD

g_simd <- i_sas$Deprivation %>% 
  head(-1) %>% 
  dplyr::rename(SIMD = `Patient Prompt Dataset - Deprivation Scot Quintile`,
                cases = `Number of Incidents`)

g_simd$SIMD <- o_sas_simd$SIMD
g_simd$cases <- as.numeric(g_simd$cases)

g_simd %<>% mutate(cases_pc = cases/sum(cases))

write.csv(g_simd, glue("Test output/SAS_SIMD.csv"), row.names = FALSE)

rm(g_simd, o_sas_simd)

