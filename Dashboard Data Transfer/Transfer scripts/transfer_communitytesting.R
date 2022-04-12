# Dashboard data transfer for Community Testing
# Sourced from ../dashboard_data_transfer.R


# First copy file from input data to folder for analysis

copyfile <- glue(input_data, "{format(report_date -2,'%Y%m%d')}_Community Testing_pub_output.xlsx")
copyloc <- "/conf/PHSCOVID19_Analysis/COVID-19-Publication-Dashboard/Data Formatting/MTU DATA/"

copied_bool <- file.copy(copyfile, copyloc, overwrite = TRUE)

if (copied_bool == FALSE) { # Check whether file successfully copied across

  stop(glue("Community Testing file '{copyfile}' could not be copied to '{copyloc}'. Terminating script."))

} else { # Continue the script

  message(glue("Community Testing file '{copyfile}' successfully copied to '{copyloc}'.") )
}

# Next run data prep script

source("/conf/PHSCOVID19_Analysis/COVID-19-Publication-Dashboard/Data Formatting/MTU DATA/MTU data prep V1.0.R")

# Check date MTU data prep script was run with the correct date

todaystring <- strftime(report_date-2,format='%Y%m%d')

if (todaystring == date){

  message("Checked MTU data prep script for community testing used correct date.")

} else {

  stop(glue("MTU data prep script for community testing used date '{date}' but today's date is '{todaystring}'. Please amend {copyloc}/MTU data prep V1.0.R to use today's date."))
}

rm(copyfile, copyloc, date)


setwd("/conf/PHSCOVID19_Analysis/COVID-19-Publication-Dashboard/Dashboard Data Transfer")