# Dashboard data transfer for Care Homes
# Sourced from ../dashboard_data_transfer.R

##### 11. Care Homes

i_carehomes <- read_excel_with_options(glue(input_data, "{format(report_date -1,'%Y%m%d')}_CareHomeWeekly.xlsx"))

o_carehomes <- read.csv(glue("{output_folder}/CareHomes.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

# Pulling summary figures from care home weekly file
summaryfigs <- dplyr::pull(i_carehomes, names(i_carehomes)[[length(i_carehomes)]])
summaryfigs <- summaryfigs[!is.na(summaryfigs)]

# Getting main table
maintable <- i_carehomes[,1:4] %>% tail(-2)

names(maintable) <- names(o_carehomes)[2:5]

maintable$`Health Board`[maintable$`Health Board` == "SCOTLAND"] <- "Scotland"

week_ending_recent <- as.Date((report_date - 3), format="%Y-%m-%d")

maintable %<>% mutate(`Week Ending` = week_ending_recent)

o_carehomes$`Week Ending` <- as.Date(o_carehomes$`Week Ending`)

o_carehomes %<>% filter(`Week Ending` < week_ending_recent)

g_carehomes <- rbind(o_carehomes, maintable)


write.csv(g_carehomes, glue(test_output, "CareHomes.csv"), row.names = FALSE)

rm(o_carehomes, i_carehomes, g_carehomes, summaryfigs, maintable, week_ending_recent)


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
