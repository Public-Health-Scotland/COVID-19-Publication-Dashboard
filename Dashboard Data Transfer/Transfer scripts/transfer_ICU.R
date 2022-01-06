# Dashboard data transfer for ICU
# Sourced from ../dashboard_data_transfer.R

###### 2. ICU

i_icu_newpatient <- read_all_sheets(glue("Input data/{(report_date -9)}_ICU_newpatientadmissions_bydate.xlsx"))
i_icu_cp_agesex_rate <- read_all_sheets(glue("Input data/{(report_date -9)}_ICU_cumulativepos_agesex_ratedata.xlsx"))

#o_icu <- read.csv(glue("{output_folder}/ICU.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
#o_icu_agesex <- read.csv(glue("{output_folder}/ICU_AgeSex.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

### a) ICU

g_icu <- i_icu_newpatient$Sheet1 %>% 
  dplyr::rename(Date = `Date of First ICU Admission`,
                Count = `Count of New COVID-19 Admissions per Day`)

write.csv(g_icu, glue("Test output/ICU.csv"), row.names = FALSE)

### b) ICU_AgeSex

g_icu_agesex <- i_icu_cp_agesex_rate$Sheet1 %>% 
  dplyr::rename(sex=gender,
                age_group = PHSagegrp,
                number=Counts) %>% 
  select(sex, age_group, number, population, rate)
  

g_icu_agesex[g_icu_agesex == "F"] <- "Female"
g_icu_agesex[g_icu_agesex == "M"] <- "Male"

# Add totals
g_icu_agesex$number %<>% as.numeric(g_icu_agesex$number)

male <-  c("Male", "All", 
           sum(g_icu_agesex$number[g_icu_agesex$sex == "Male"]), 
           sum(g_icu_agesex$population[g_icu_agesex$sex == "Male"]),
           100000*sum(g_icu_agesex$number[g_icu_agesex$sex == "Male"])/sum(g_icu_agesex$population[g_icu_agesex$sex == "Male"])
)

female <- c("Female", "All", 
            sum(g_icu_agesex$number[g_icu_agesex$sex == "Female"]), 
            sum(g_icu_agesex$population[g_icu_agesex$sex == "Female"]),
            100000*sum(g_icu_agesex$number[g_icu_agesex$sex == "Female"])/sum(g_icu_agesex$population[g_icu_agesex$sex == "Female"])
)

g_icu_agesex %<>% rbind(male) %>%  rbind(female) 

agegroups <- unique(g_icu_agesex$age_group)

for(agegroup in agegroups){
    
    num <- as.numeric(g_icu_agesex$number[g_icu_agesex$age_group == agegroup])
    pop <-  as.numeric(g_icu_agesex$population[g_icu_agesex$age_group == agegroup])
  
    
    newline <- c("Total", agegroup, 
                 sum(num),
                 sum(pop),
                 100000*sum(num)/sum(pop))
    
    g_icu_agesex %<>% rbind(newline) 
  
  }
  

g_icu_agesex %<>% arrange(factor(sex, levels = c("Male", "Female", "Total"))) %>% select(-c(population))

write.csv(g_icu_agesex, glue("Test output/ICU_AgeSex.csv"), row.names = FALSE)

rm(g_icu, g_icu_agesex, i_icu_cp_agesex_rate, i_icu_newpatient)