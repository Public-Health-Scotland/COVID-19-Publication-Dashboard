# Dashboard data transfer for Care Homes (Turas) for SG
# Sourced from ../dashboard_data_transfer.R

##### 24. Care Homes data for Scottish Government

i_ch <- read_all_excel_sheets(glue(input_data, "care_homes_visits_{format(report_date -2,'%Y_%m_%d')}.xlsx"))

g_notes <- i_ch$Notes

write.csv(g_notes, glue(test_output, "CareHomeVisitsNotes.csv"), row.names = FALSE)

g_board <- i_ch$`Table 1`

write.csv(g_board, glue(test_output, "CareHomeVisitsBoard.csv"), row.names = FALSE)

g_outbreak <- i_ch$`Table 2`

write.csv(g_outbreak, glue(test_output, "CareHomeVisitsOutbreak.csv"), row.names = FALSE)

g_board_older <- i_ch$`Table 3a`

write.csv(g_board_older, glue(test_output, "CareHomeVisitsBoardOlder.csv"), row.names = FALSE)

g_outbreak_older <- i_ch$`Table 3b`

write.csv(g_outbreak_older, glue(test_output, "CareHomeVisitsOutbreakOlder.csv"), row.names = FALSE)