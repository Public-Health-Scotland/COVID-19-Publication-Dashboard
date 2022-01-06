# Dashboard data transfer for Care Homes
# Sourced from ../dashboard_data_transfer.R

##### 11. Care Homes

i_carehomes <- read_excel(glue("Input data/{format(report_date -1,'%Y%m%d')}_CareHomeWeekly.xlsx"), col_names=FALSE)

o_carehomes <- read.csv(glue("{output_folder}/CareHomes.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

# Pulling summary figures from care home weekly file
summaryfigs <- dplyr::pull(i_carehomes, names(i_carehomes)[[length(i_carehomes)]])
summaryfigs <- summaryfigs[!is.na(summaryfigs)]

# Getting main table
maintable <- i_carehomes[,1:4] %>% tail(-3) 

names(maintable) <- names(o_carehomes)[2:5]

maintable$`Health Board`[maintable$`Health Board` == "SCOTLAND"] <- "Scotland"

week_ending_recent <- as.Date((report_date - 3), format="%Y-%m-%d")

maintable %<>% mutate(`Week Ending` = week_ending_recent) 

o_carehomes$`Week Ending` <- as.Date(o_carehomes$`Week Ending`)

o_carehomes %<>% filter(`Week Ending` < week_ending_recent) 

g_carehomes <- rbind(o_carehomes, maintable)


write.csv(g_carehomes, glue("Test output/CareHomes.csv"), row.names = FALSE)

rm(o_carehomes, i_carehomes, g_carehomes, summaryfigs, maintable, week_ending_recent)