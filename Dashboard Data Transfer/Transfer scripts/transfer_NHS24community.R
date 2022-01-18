# Dashboard data transfer for NHS24 Community
# Sourced from ../dashboard_data_transfer.R

##### 1. NHS24 Community

i_endpoints <- read_excel_with_options("Input data/PHS COVID-19 Endpoints.xlsx")

o_nhs24community <- read.csv(glue("{output_folder}/NHS24_community.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

### a) NHS24 community

g_nhs24community <- i_endpoints %>% 
  dplyr::rename(date = Date,
                Call.999 = `999`,
                Dr.to.Phone.within.1Hr = `Dr to Phone 1Hr`,
                Dr.to.Phone.within.4.Hrs = `Dr to Phone 4 Hrs`,
                Coronavirus.Testing = `Coronavirus Testing`,
                Self.Care = `Self Care`
                )

o_nhs24community$date <- as.Date(o_nhs24community$date)

o_nhs24community %<>% 
  filter(date < g_nhs24community$date)

g_nhs24community <- rbind(o_nhs24community, g_nhs24community)

write.csv(g_nhs24community, glue("Test output/NHS24_community.csv"), row.names = FALSE)

rm(o_nhs24community, g_nhs24community, i_endpoints)