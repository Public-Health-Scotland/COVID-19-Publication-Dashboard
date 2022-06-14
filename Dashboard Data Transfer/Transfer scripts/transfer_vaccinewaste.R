# Dashboard data transfer for Vaccine Wastage data
# Sourced from ../dashboard_data_transfer.R

##### 23. Vaccine wastage

i_vaccine_wastage <- read_all_excel_sheets(glue(input_data, "{format(report_date -2,'%Y-%m-%d')}_vaccine_wastage.xlsx"))

g_vaccine_wastage <- i_vaccine_wastage$Sheet1

write.csv(g_vaccine_wastage, glue(output_folder, "VaccineWastage.csv"), row.names = FALSE)

rm(i_vaccine_wastage, g_vaccine_wastage)