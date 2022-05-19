# Dashboard data transfer for Care Homes
# Sourced from ../dashboard_data_transfer.R

##### 11. Care Homes

#### Care Home Time series

g_carehome_timeseries <- read_excel_with_options(
  glue( '//PHI_conf/Real_Time_Epi/Routine_Reporting/Time_Series/Outputs/PCR_LFD',
        '/Care Home Time Series (PCRLFD Reinfections) {format(report_date -2,"%d%m%Y")}_all.xlsx' )
) %>%
  select( specimen_date, RESIDENT, STAFF ) %>%
  filter(specimen_date != "Total") %>%
  mutate(specimen_date = ymd(specimen_date),
         `Week Ending` = ceiling_date(specimen_date,
                                      unit='week',
                                      week_start = c(5),
                                      change_on_boundary = FALSE)) %>%
  filter( specimen_date <= ceiling_date( Sys.Date()-7, unit = 'week', week_start = c(5),
                                         change_on_boundary = FALSE ) ) %>%
  group_by( `Week Ending` ) %>%
  mutate( StWk = sum(STAFF), ReWk = sum(RESIDENT), TOTAL = StWk + ReWk ) %>%
  ungroup() %>%
  mutate( Staff = case_when( between(StWk, 1, 4) ~ '*',
                             TRUE ~ as.character(StWk)),
          Resident = case_when( between(ReWk, 1, 4) ~ '*',
                                TRUE ~ as.character(ReWk)),
          Total = case_when( between(StWk, 1, 4) | between(ReWk, 1, 4) ~ '*',
                             TRUE ~ as.character(TOTAL) )) %>%
  select( `Week Ending`, Resident, Staff, Total ) %>%
  distinct()


write.csv(g_carehome_timeseries, glue(test_output, "CareHomeTimeSeries.csv"), row.names = FALSE)

rm(g_carehome_timeseries)
