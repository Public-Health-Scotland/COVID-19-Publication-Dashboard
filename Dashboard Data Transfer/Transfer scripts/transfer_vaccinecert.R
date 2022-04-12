# Dashboard data transfer for Vaccine data
# Sourced from ../dashboard_data_transfer.R

##### 21. Vaccine certification

i_vaccine <- read_all_excel_sheets(glue(input_data, "{format(report_date -2,'%Y-%m-%d')}_vaccine_certifications.xlsx"))

g_vaccine <- i_vaccine$Sheet1

write.csv(g_vaccine, glue(test_output, "VaccineCertification.csv"), row.names = FALSE)

rm(i_vaccine, g_vaccine)