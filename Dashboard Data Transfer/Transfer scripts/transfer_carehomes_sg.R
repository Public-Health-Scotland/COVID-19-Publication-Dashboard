# Dashboard data transfer for Care Homes (Turas) for SG
# Sourced from ../dashboard_data_transfer.R

##### 24. Care Homes data for Scottish Government

i_ch <- read_all_excel_sheets(glue(input_data, "care_homes_visits_{format(report_date -2,'%Y_%m_%d')}.xlsx"))

g_notes <- i_ch$Notes

write.csv(g_notes, glue(output_folder, "CareHomeVisitsNotes.csv"), row.names = FALSE)

g_board <- i_ch$`Table 1` %>%
  mutate(`% supporting indoor visits (as a proportion of all homes)` = 100*`% supporting indoor visits (as a proportion of all homes)`,
         `% supporting indoor visits (as a proportion of those returning a huddle)` = 100*`% supporting indoor visits (as a proportion of those returning a huddle)`)

write.csv(g_board, glue(output_folder, "CareHomeVisitsBoard.csv"), row.names = FALSE)

g_outbreak <- i_ch$`Table 2`

write.csv(g_outbreak, glue(output_folder, "CareHomeVisitsOutbreak.csv"), row.names = FALSE)

g_board_older <- i_ch$`Table 3a` %>%
  mutate(`% supporting indoor visits (as a proportion of all homes)` = 100*`% supporting indoor visits (as a proportion of all homes)`,
         `% supporting indoor visits (as a proportion of those returning a huddle)` = 100*`% supporting indoor visits (as a proportion of those returning a huddle)`)


write.csv(g_board_older, glue(output_folder, "CareHomeVisitsBoardOlder.csv"), row.names = FALSE)

g_outbreak_older <- i_ch$`Table 3b` %>%
  mutate(`% supporting indoor visits (as a proportion of all homes)` = 100*`% supporting indoor visits (as a proportion of all homes)`,
         `% supporting indoor visits (as a proportion of those returning a huddle)` = 100*`% supporting indoor visits (as a proportion of those returning a huddle)`)


write.csv(g_outbreak_older, glue(output_folder, "CareHomeVisitsOutbreakOlder.csv"), row.names = FALSE)

rm(g_notes, g_board, g_outbreak, g_board_older, g_outbreak_older, i_ch)