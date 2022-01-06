# Dashboard data transfer for Quarantine Data
# Sourced from ../dashboard_data_transfer.R

##### 16. Quarantine

i_quarantine <- read_all_sheets(glue("Input data/{format(report_date -2,'%Y%m%d')}--Border Control - Quarantine Statistics.xlsx"))

o_quarantine <- read.csv(glue("{output_folder}/Quarantine.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

quarantine_date <- report_date - 3

# Extract info from relevant cells in spreadsheet
extract <- i_quarantine$Sheet1[6:18, 1:3]

newrow <- c(as.character(quarantine_date), extract[1,3], extract[3,3], extract[4,3], 
            extract[7,3], extract[10,3], extract[11,3], extract[13,3])

cumrow <- c("Cumulative", extract[1,2], extract[3,2], extract[4,2], 
            extract[7,2], extract[10,2], extract[11,2], extract[13,2])

# Filter out cumulative column and any overlap dates
o_quarantine$`Week Ending` <- as.Date(o_quarantine$`Week Ending`, format="%Y-%m-%d") 
o_quarantine %<>% filter(`Week Ending` < quarantine_date) 
o_quarantine$`Week Ending` <- as.character(o_quarantine$`Week Ending`)

# Add new rows
g_quarantine <- o_quarantine %>% rbind(newrow) %>% rbind(cumrow)

write.csv(g_quarantine, glue("Test output/Quarantine.csv"), row.names = FALSE)

rm(quarantine_date, i_quarantine, o_quarantine, g_quarantine, newrow, cumrow)