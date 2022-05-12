#### Notes tab

output$notes_output <-renderUI({

  tagList(
    # Cases & infection levels
    h3("Cases & infection levels"),
    h4("Reported cases"),
    p("This data is published on Mondays and Thrusdays on the "),
    p(tags$a("COVID-19 Dashboard",
             href = "https://public.tableau.com/app/profile/phs.covid.19/viz/COVID-19DailyDashboard_15960160643010/Dailyupdate"),
    p(". The number of daily confirmed cases may differ slightly from data published on this dashboard because the data has some
            cases added retrospectively and assigned to days based on the most up to date records. This has no impact on the overall
            number of confirmed cases."),

    # Lateral Flow Devices (LFDs)
    h3("Lateral Flow Devices (LFDs)"),
    p("LFD info here..."),
    h3("Severe illness"),

    # Hospital admissions
    h3("Hospital admissions"),
    p("..."),
    h4("Length of stay (LOS)"),
    p("..."),
    h4("Ethnicity"),
    p("..."),
    h4("ICU admissions"),
    p("..."),

    # Populations of interest
    h3("Populations of interest"),
    h4("Care homes"),
    p("..."),

    # Surveillance
    h3("Surveillance"),
    h4("NHS24"),
    p("..."),
    h4("Scottish Ambulance Service (SAS)"),
    p("..."),

    # Vaccinations
    h3("Vaccinations"),
    h4("Vaccine wastage"),
    p("...")


          ))
  }) # render UI close bracket