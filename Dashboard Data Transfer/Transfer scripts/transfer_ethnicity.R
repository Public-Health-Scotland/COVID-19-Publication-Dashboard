# Dashboard data transfer for Ethnicity
# Sourced from ../dashboard_data_transfer.R

##### 15. Ethnicity

i_ethnicity <- read_csv_with_options(glue("Input data/RAPID_Ethnicity_Oct21.csv"))

#o_ethnicity <- read.csv(glue("{output_folder}/Ethnicity.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
o_ethnicitychart <- read.csv(glue("{output_folder}/Ethnicity_Chart.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

### a) Ethnicity

g_ethnicity <- i_ethnicity %>%
  dplyr::rename(Admissions = count,
                Percentage = percentage) %>%
  mutate(Percentage = Percentage*100) %>%
  mutate_if(is.numeric, round, 2)

g_ethnicity$Admissions[g_ethnicity$Admissions < 5] <- "*"
g_ethnicity$Percentage[g_ethnicity$Admissions == "*"] <- "*"

write.csv(g_ethnicity, glue("Test output/Ethnicity.csv"), row.names = FALSE)

### b) Ethnicity Chart

g_ethnicitychart <- g_ethnicity %>%
  pivot_wider(names_from = Ethnicity, values_from = c(Admissions, Percentage)) %>%
  dplyr::rename(
                White_c = `Admissions_White`,
                White_p = `Percentage_White`,
                `Black/Caribbean/African_c` = `Admissions_Black/Caribbean/African`,
                `Black/Caribbean/African_p` = `Percentage_Black/Caribbean/African`,
                `South Asian_c` = `Admissions_South Asian`,
                `South Asian_p` = `Percentage_South Asian`,
                Chinese_c = `Admissions_Chinese`,
                Chinese_p = `Percentage_Chinese`,
                Other_c = `Admissions_Other`,
                Other_p = `Percentage_Other`,
                `Not Available_c` = `Admissions_Not Available`,
                `Not Available_p` = `Percentage_Not Available`
                ) %>%
  select(names(o_ethnicitychart))

g_ethnicitychart$`Month beginning` <- as.Date(format(as.Date(g_ethnicitychart$`Month beginning`, format="%d/%m/%Y"), format="%Y-%m-%d"))

write.csv(g_ethnicitychart, glue("Test output/Ethnicity_Chart.csv"), row.names = FALSE)

rm(g_ethnicity, o_ethnicity, g_ethnicitychart, o_ethnicitychart, i_ethnicity)


