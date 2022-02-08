# Dashboard data transfer for Lab Data 
# Sourced from ../dashboard_data_transfer.R

##### 6. Lab Data



i_labdata <- read_all_sheets(glue("Input data/Lab_Data_HPS_{format(report_date-2, format='%m%d')}_test.xlsx"))
i_barchart <- read_csv_with_options(glue("Input data/cases_agegrp_chart_data_{format(as.Date((report_date-2), format='%Y%m%d'), format='%m%d')}.csv"))

o_labcases <- read.csv(glue("{output_folder}/LabCases.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_labcases_agesex <- read.csv(glue("{output_folder}/LabCases_AgeSex.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_labcases_simd <- read.csv(glue("{output_folder}/LabCases_SIMD.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)


### a) LabCases

#g_labcases <- i_labdata[,1:3] %>% tail(-1)
g_labcases <- i_labdata$`Cumulative confirmed cases`[,1:3] %>% tail(-1)

#names(g_labcases) <- g_labcases[1,]

g_labcases %<>% 
#  transform(Date = excel_numeric_to_date(as.numeric(as.character(Date)), date_system = "modern") ) %>% 
  dplyr::rename(NumberCasesperDay = `Number of cases per day`) 

g_labcases$NumberCasesperDay <- as.numeric(g_labcases$NumberCasesperDay)
g_labcases$Cumulative <- as.numeric(g_labcases$Cumulative)

pop_grandtotal <- i_population$pop_number[i_population$age_group == "All" & i_population$sex == "Total"]

g_labcases %<>% 
  mutate(Average7 = zoo::rollmean(NumberCasesperDay, k = 7, fill = NA, align="right")) %>% 
  mutate(CumulativeRatePer100000 = 100000 * Cumulative / pop_grandtotal)

write.csv(g_labcases, glue("Test output/LabCases.csv"), row.names = FALSE)

rm(g_labcases, pop_grandtotal)

### b) LabCases_AgeSex

#g_lagesex <- i_labdata[5:16,7:11]

g_lagesex <- i_labdata$`Age group and sex` %>% head(-4)

#names(g_lagesex) <- g_lagesex[1,]

g_lagesex %<>% 
  dplyr::rename(Total = `All Sex`,
                age_group = `Age group (years)`) %>% 
  select(-`%agegroup`)

g_lagesex$age_group[g_lagesex$age_group == "Total"] <- "All"

g_lagesex %<>% 
  reshape2::melt(id=c("age_group"), variable="sex") %>% 
  dplyr::rename(number = value) %>% 
  select(sex, age_group, number)

g_lagesex$number <- as.numeric(g_lagesex$number)

g_lagesex %<>% 
  left_join(i_population, by=c("age_group", "sex")) %>% 
  mutate(rate = 100000*number/pop_number) %>% 
  select(sex, age_group, number, rate) %>% 
  arrange(factor(sex, levels = c("Male", "Female", "Unknown")))

g_lagesex$age_group[g_lagesex$age_group == "All"] <- "All Ages"

write.csv(g_lagesex, glue("Test output/LabCases_AgeSex.csv"), row.names = FALSE)

rm(g_lagesex)

### c) LabCases_SIMD

#g_lsimd <- i_labdata[26:35,7:9]

g_lsimd <- i_labdata$SIMD

#names(g_lsimd) <- g_lsimd[1,]

g_lsimd$`SIMD Quintile`[g_lsimd$`SIMD Quintile` == "Missing"] <- "Unknown"


g_lsimd %<>% 
  drop_na(`SIMD Quintile`) %>% 
  subset(`SIMD Quintile` != "Total") %>% 
  dplyr::rename(cases_pc = `% cases per quintile`,
                cases = Cases,
                SIMD = `SIMD Quintile`)
  

write.csv(g_lsimd, glue("Test output/LabCases_SIMD.csv"), row.names = FALSE)

rm(g_lsimd)
  

### d) LabCases_Age

o_barchart <- i_barchart %>% 
  dplyr::rename(Age = age_group,
                Cases = count,
                Date = `Week ending`) %>% 
  select(Date, Age, Cases)

write.csv(o_barchart, glue("Test output/LabCases_Age.csv"), row.names=FALSE)
