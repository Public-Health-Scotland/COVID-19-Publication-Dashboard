# Dashboard data transfer for Vaccine Wastage data
# Sourced from ../dashboard_data_transfer.R

##### 23. Vaccine wastage

i_vaccine_wastage <- read_all_excel_sheets(glue(input_data, "{format(report_date -2,'%Y-%m-%d')}_vaccine_wastage.xlsx"))

g_vaccine_wastage <- i_vaccine_wastage$Sheet1
g_vaccine_wastage_reason <- i_vaccine_wastage$Sheet2

write.csv(g_vaccine_wastage, glue(output_folder, "VaccineWastage.csv"), row.names = FALSE)
write.csv(g_vaccine_wastage_reason, glue(output_folder, "VaccineWastageReason.csv"), row.names = FALSE)

rm(i_vaccine_wastage, g_vaccine_wastage, g_vaccine_wastage_reason)