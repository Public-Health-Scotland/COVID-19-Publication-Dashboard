##### 22. Length of Stay data transfer



los = read_csv_with_options(glue(input_data, "/{format(report_date -2,'%Y-%m-%d')}_LOS Table Dashboard.csv"))

names(los) = c("Age Group", "Week Ending", "Length of Stay", "n", "prop")


write.csv(los, glue(output_folder, "Length_of_Stay.csv"), row.names=FALSE)
