# Dashboard data transfer for Care Homes (Turas) for SG
# Sourced from ../dashboard_data_transfer.R

##### 24. Care Homes data for Scottish Government

care_homes_visit_path <- "/conf/C19_Test_and_Protect/Care Home Visiting - Turas/Outputs/"
care_homes_visit_files <- list.files(path=care_homes_visit_path, pattern="*care_homes_visits.xlsx")
# Get the most recent file
filedates <- purrr::map_dbl(care_homes_visit_files, ~ as.numeric(str_extract_all(.x, "[0-9]+")[[1]]))
most_recent_date <- max(filedates)
most_recent_file <- care_homes_visit_files[which.max(filedates)]

# Processing most recent file
i_ch <- read_all_excel_sheets(paste0(care_homes_visit_path, most_recent_file))
g_notes <- i_ch$Notes

write.csv(g_notes, glue(output_folder, glue("CareHomeVisitsNotes_{most_recent_date}.csv")), row.names = FALSE)

g_board <- i_ch$`Table 1` %>%
  mutate(`% supporting indoor visits (as a proportion of all homes)` = 100*`% supporting indoor visits (as a proportion of all homes)`,
         `% supporting indoor visits (as a proportion of those returning a huddle)` = 100*`% supporting indoor visits (as a proportion of those returning a huddle)`)

write.csv(g_board, glue(output_folder, glue("CareHomeVisitsBoard_{most_recent_date}.csv")), row.names = FALSE)

g_outbreak <- i_ch$`Table 2`

write.csv(g_outbreak, glue(output_folder, glue("CareHomeVisitsOutbreak_{most_recent_date}.csv")), row.names = FALSE)

g_board_older <- i_ch$`Table 3a` %>%
  mutate(`% supporting indoor visits (as a proportion of all homes)` = 100*`% supporting indoor visits (as a proportion of all homes)`,
         `% supporting indoor visits (as a proportion of those returning a huddle)` = 100*`% supporting indoor visits (as a proportion of those returning a huddle)`)


write.csv(g_board_older, glue(output_folder, glue("CareHomeVisitsBoardOlder_{most_recent_date}.csv")), row.names = FALSE)

g_outbreak_older <- i_ch$`Table 3b` %>%
  mutate(`% supporting indoor visits (as a proportion of all homes)` = 100*`% supporting indoor visits (as a proportion of all homes)`,
         `% supporting indoor visits (as a proportion of those returning a huddle)` = 100*`% supporting indoor visits (as a proportion of those returning a huddle)`)


write.csv(g_outbreak_older, glue(output_folder, glue("CareHomeVisitsOutbreakOlder_{most_recent_date}.csv")), row.names = FALSE)

rm(g_notes, g_board, g_outbreak, g_board_older, g_outbreak_older, i_ch)