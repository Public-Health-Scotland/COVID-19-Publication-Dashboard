##### 22. Length of Stay data transfer



los = read_csv_with_options(glue("Input data/Hospital Admissions/{format(report_date -2,'%Y%m%d')}_LOS Table Dashboard.csv"))

names(los) = c("Age Group", "Week Ending", "Length of Stay", "n", "prop")


write.csv(los, glue("Test output/Length_of_Stay.csv"), row.names=FALSE)
