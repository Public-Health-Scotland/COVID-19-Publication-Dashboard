# Dashboard data transfer for Travel
# Sourced from ../dashboard_data_transfer.R

##### 19. Travel

i_t <- read_all_sheets(glue("Input data/Contact Tracing/{format(report_date-2 ,'%Y%m%d')}_travel_weekly.xlsx"))

#o_ctr <- read.csv(glue("{output_folder}/ContactTracingRegions.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)
#o_cti <- read.csv(glue("{output_folder}/ContactTracingInterviews.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

### a) Contact Tracing Regions

g_ctr <- i_t$`Region Totals` %>% 
  dplyr::rename(Region = region,
                Cases = cases)

write.csv(g_ctr, glue("Test output/ContactTracingRegions.csv"), row.names = FALSE)

### b) Contact Tracing Interviews

g_cti <- i_t$`Number Cases`

names(g_cti) <- c("CMS Outputs", "Number")

write.csv(g_cti, glue("Test output/ContactTracingInterviews.csv"), row.names = FALSE)

rm(g_cti, g_ctr, o_cti, o_ctr, i_t)