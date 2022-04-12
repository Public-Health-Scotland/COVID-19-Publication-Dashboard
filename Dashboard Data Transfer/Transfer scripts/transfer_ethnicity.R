# Dashboard data transfer for Ethnicity
# Sourced from ../dashboard_data_transfer.R

##### 15. Ethnicity

i_ethnicity <- read_csv_with_options(glue(input_data, "/RAPID_Ethnicity_Oct21.csv"))

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

write.csv(g_ethnicity, glue(test_output, "Ethnicity.csv"), row.names = FALSE)

### b) Ethnicity Chart

g_ethnicitychart <- g_ethnicity %>%
  dplyr::rename("Ethnicity" = "Ethnic_group") %>%
  pivot_wider(names_from = Ethnicity, values_from = c(Admissions, Percentage)) %>%
  clean_names()


write.csv(g_ethnicitychart, glue(test_output, "Ethnicity_Chart.csv"), row.names = FALSE)

rm(g_ethnicity, o_ethnicity, g_ethnicitychart, o_ethnicitychart, i_ethnicity)


