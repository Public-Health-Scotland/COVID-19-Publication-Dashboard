# COVID-19-Publication-Dashboard
Dashboard for weekly COVID-19 publication

Since the start of the COVID-19 outbreak Public Health Scotland (PHS) has been working closely with Scottish Government and health and care colleagues in supporting the surveillance and monitoring of COVID-19 amongst the population.

Each week, a statistical report covering COVID-19 in Scotland is published. This report can be found [here](https://beta.isdscotland.org/find-publications-and-data/population-health/covid-19/covid-19-statistical-report/).

This GitHub repository contains the R project for the accompanying [interactive shiny dashboard](https://scotland.shinyapps.io/nhs-covid19-weekly/).

## Workflow

### Data transfer

* The necessary data will be assembled in the weekly report data folder each week on a Monday/Tuesday
* Copy the data to /conf/C19_Test_and_Protect/Test & Protect - Warehouse/Weekly Dashboard Data/Input/
* Check you have the latest (or appropriate) version of this repository
* Run dashboard data transfer by sourcing the script and interacting with R Studio as necessary to select the correct files

### App preparation

* Obtain uncommitted files from colleagues `shiny_app/www/google-analytics.html` and `shiny_app/AppDeployment.R`
* Update paths in `AppDeployment.R` so that they match where your dashboard copy is located
* Run `app_data_preparation.R` to transfer the processed data to your `shiny_app/data` folder as .rds files
* Go to `global.R` and change the report date to this week's report date
* Run `global.R` and check through the app

### App deployment

* Go to `AppDeployment.R` and run file (run first section only for PRA deployment)

## Development

### Code layout

* `app_data_preparation.R` is a script for copying .csv files from shared filepath to local `shiny_app/data/` folder
* `Dashboard Data Transfer` contains the files for processing data for the app. The process is orchestrated from `dashboard_data_transfer.R`, which successively runs the scripts inside `Dashboard Data Transfer/Transfer scripts`.
* `shiny_app` contains the code for the app.
  * `ui.R`, `server.R` and `global.R` are the primary app scripts
  * `www` contains the css stylesheet and PHS logo and favicon
  * `functions` contains functions for the app 
    * `functions_tables.R` contains functions for tables
    * `functions_chart_layout.R` contains functions for organising charts and titles
    * `functions_server.R` contains other functions including those for graphs
  * `tabs` contains R files with content for each of the tabs
  
 


