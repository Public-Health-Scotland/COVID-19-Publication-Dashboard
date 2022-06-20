# Dashboard data transfer for NHS Proximity app
# Sourced from ../dashboard_data_transfer.R

##### 17. NHS Proximity app

i_ps <- read_all_excel_sheets(glue(input_data, "Contact Tracing/Protect Scotland Template.xlsx"))

o_ps <- read.csv(glue("{output_folder}/ProximityApp.csv"), header = TRUE, stringsAsFactors = FALSE, check.names=FALSE)

g_ps <- i_ps$Weekly %>%
  select(`Week beginning`,  CONTACT_NOTIFICATION, UPLOAD) %>%
  dplyr::rename(`Contact notifications` = CONTACT_NOTIFICATION,
                `Exposure key uploads` = UPLOAD)

write.csv(g_ps, glue(output_folder, "ProximityApp.csv"), row.names = FALSE)

rm(i_ps, o_ps, g_ps)