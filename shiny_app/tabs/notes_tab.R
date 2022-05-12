#### Notes tab

# Cases & infection levels
output$cases_inf_notes <-renderUI({

  tagList(
    h4("Reported cases"),
    p("From 05 January 2022, reported cases included both polymerase chain reaction (PCR) and lateral flow device (LFD) positive test results.
      Prior to this, cases consisted only of positive PCR tests."),
    p("From 01 March 2022, reported cases included episodes of reinfection at least 90 days after initial infection."),
    p("From mid-April 2022, asymptomatic testing was no longer recommended. PCR testing continued for those with symptoms and LFD testing for hospital and care home visitors,
      close contacts of an index case and for early release from isolation after 7 days."),
    p("This data is published on Mondays and Thursdays on the ",
      tags$a("COVID-19 Dashboard", href = "https://public.tableau.com/app/profile/phs.covid.19/viz/COVID-19DailyDashboard_15960160643010/Dailyupdate"),
      ". The number of daily confirmed cases may differ slightly from data published on this dashboard because the data has some
            cases added retrospectively and assigned to days based on the most up to date records. This has no impact on the overall
            number of confirmed cases."),
    p("incomplete..."), br(),
    h4("Reinfections"),
    p("From 01 March 2022, episodes of reinfection are included in COVID-19 reprting. Prior to this date, COVID-19 cases were based on an individual's
      first positive test only. The new daily calculation includes both new infections and possible reinfections. Possible reinfections are defined as
      individuals who test positive, by PCR or LFD, 90 days or more after their last positive test."),
      p("More information is available on the ",
        tags$a("Public Health Scotland website", href = "https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/"),
        "."),
    bsButton("jump_to_inf_cases_n", label = "Go to tab"),
    bsButton("jump_to_inf_cases_data_n", label = "Go to data")
    )
  }) # render UI close bracket

# LFDs
output$LFD_notes <-renderUI({

  tagList(
    p("LFDs are clinically validated swab antigen tests that do not require a laboratory for processing, producing rapid results at the location of the test."),
    p("...unfinished"),
    bsButton("jump_to_LFD_n", label = "Go to tab"),
    bsButton("jump_to_LFDdemo_n", label = "Go to demographics tab")
    )
}) # render UI close bracket

# Severe illness
output$severe_illness_notes <-renderUI({

  tagList(
    h4("Hospital admissions"),
    p("These admissions are identified from Rapid and Preliminary Inpatient Data (RAPID) and defined as the following: A positive PCR or LFD test of the episode of
      infection (including reinfections at 90 days or more after their last positive test) for COVID-19 up to 14 days prior to admission to hospital, on the day of
      their admission or during their stay in hospital."), br(),
    h4("Length of stay (LOS)"),
    p("Length of stay, i.e. the length of time an individual spends in hospital, is an important indicator for measuring the severity of COVID-19."), br(),
    h4("Ethnicity"),
    p("Please note that the data on hospital admissions by ethnicity only refers to laboratory confirmed (PCR) COVID-19 tests."), br(),
    h4("ICU admissions"),
    p("COVID-19 varies in severity from very mild symptoms through to those requiring hospital admission and the most ill who require intensive care treatment and
      supported ventilation in an Intensive Care Unit (ICU). Counts include any patient with a confirmed positive COVID-19 test (confirmed by linkage to ECOSS) taken
      prior to discharge from an ICU in Scotland."),
    p("etc"),
    bsButton("jump_to_severe_illness_n", label = "Go to tab"),
    bsButton("jump_to_severe_illness_data_n", label = "Go to data")
    )
}) # render UI close bracket

# Populations of interest
output$population_int_notes <-renderUI({

  tagList(
    h4("Care homes"),
    p("As of 06 April 2022, Public Health Scotland are reporting weekly data on COVID-19 cases in adult Care Homes in Scotland, previously reported by the ",
      tags$a("Scottish Government", href = "https://www.gov.scot/publications/coronavirus-covid-19-data-for-scotland/"),
      ". A positive case includes both new infections and possible reinfections, which are defined as individuals who test positive by PCR or LFD, 90 or more
      clear days after their last positive test.",
      p("etc")),
    bsButton("jump_to_pop_interest_n", label = "Go to tab")
    )
}) # render UI close bracket

# Surveillance
output$surveillance_notes <-renderUI({

  tagList(
    h4("NHS24"),
    p("info here"), br(),
    h4("Scottish Ambulance Service (SAS)"),
    p("SAS currently publish weekly unscheduled care operational statistics", tags$a("here.",
                                                                                     href = "https://www.scottishambulance.com/publications/unscheduled-care-operational-statistics/")),
      p("etc"),
    bsButton("jump_to_surveillance_n", label = "Go to tab"),
    bsButton("jump_to_surveillance_data_n", label = "Go to data")
    )
}) # render UI close bracket

# Vaccinations
output$vaccinations_notes <-renderUI({

  tagList(
    #bsButton("jump_to_inf_cases_data", label = "Go to data"), # this is
    #h3("Cases & infection levels"),
    h4("Vaccine wastage"),
    p("Given the scale of the Covid-19 vaccination programme, some vaccine wastage has been unavoidable for a variety of reasons including logistical issues,
      storage failure and specific clinical situations."),
    bsButton("jump_to_vaccinations_n", label = "Go to tab")
    )
}) # render UI close bracket



