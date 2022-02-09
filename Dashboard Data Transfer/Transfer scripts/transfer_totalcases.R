# Dashboard data transfer for Total Daily Cases
# Sourced from ../dashboard_data_transfer.R

##### 20. Total daily cases

i_dailydata <- read_all_sheets("Input data/DailyDataFigs.xlsx")

### a) Total cases

pop_grandtotal <- i_population$pop_number[i_population$age_group == "All" & i_population$sex == "Total"]

g_cases <- i_dailydata$Cases %>%
  dplyr::rename(NumberCasesperDay = `Cases per day`,
                Average7 = `7 Day Average`) %>%
  mutate(CumulativeRatePer10000 = 10000 * Cumulative / pop_grandtotal) %>%
  select(Date, NumberCasesperDay, Cumulative, Average7, CumulativeRatePer100000)


write.csv(g_cases, glue("Test output/TotalCases.csv"), row.names = FALSE)

rm(g_cases, pop_grandtotal)
