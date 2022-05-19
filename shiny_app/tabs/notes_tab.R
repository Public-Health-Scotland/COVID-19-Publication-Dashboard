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
    p("The purpose of COVID-19 testing has shifted from population-wide testing to reduce transmission, to targeted testing and surveillance. The ",
      tags$a("Scottish Government Test and Protect Transition Plan", href = "https://www.gov.scot/publications/test-protect-transition-plan/"),
      " came into effect on 01 May 2022, which set out changes to testing, contact tracing and isolation. Therefore, testing remains in place
      only for certain groups to protect high risk settings and support clinical care, and will no longer be representative of all COVID-19 cases in Scotland"),
    p("This data is published on Mondays and Thursdays on the ",
      tags$a("COVID-19 Dashboard", href = "https://public.tableau.com/app/profile/phs.covid.19/viz/COVID-19DailyDashboard_15960160643010/Dailyupdate"),
      ". The number of daily confirmed cases may differ slightly from data published on this dashboard because the data has some
            cases added retrospectively and assigned to days based on the most up to date records. This has no impact on the overall
            number of confirmed cases."),
    p(strong("Source: ECOSS")),
    br(),
    p("Please note:"),
    tags$li("The number of daily confirmed cases may differ slightly from data published on the ",
            tags$a("COVID-19 Dashboard",
                   href = "https://public.tableau.com/app/profile/phs.covid.19/viz/COVID-19DailyDashboard_15960160643010/Dailyupdate"),
            " on Mondays and Thursdays, because the data has some cases added retrospectively and assigned to days based on the most up to date records.
            Overall number of confirmed cases should not be affected."),
    tags$li("The total number of people within Scotland who have, or have had, COVID-19 since the coronavirus outbreak began is unknown.
            The number of confirmed cases is likely to be an underestimate."),
    # This point will need removed when case data goes from daily to weekly
    tags$li("The drop in the number of confirmed cases at weekends likely reflects that laboratories are doing fewer tests at the weekend."),
    tags$li("Reported cases prior to 01 March 2022 were based on an individual's first positive test result only."),
    tags$li("Due to changes in testing strategy outlined above, caution is advised when comparing trends over time."),
    br(),
    h4("Reinfections"),
    p("From 01 March 2022, episodes of reinfection are included in COVID-19 reporting. Prior to this date, COVID-19 cases were based on an individual's
      first positive test only. The new daily calculation includes both new infections and possible reinfections. Possible reinfections are defined as
      individuals who test positive, by PCR or LFD, 90 days or more after their last positive test."),
      p("More information is available on the ",
        tags$a("Public Health Scotland website", href = "https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/"),
        "."),
    #p(strong("Source: ")),
    br(),
    bsButton("jump_to_inf_cases_n", label = "Go to tab"),
    bsButton("jump_to_inf_cases_data_n", label = "Go to data")
    )
  }) # render UI close bracket

# LFDs
output$LFD_notes <-renderUI({

  tagList(
    p("LFDs are clinically validated swab antigen tests that do not require a laboratory for processing, producing rapid results at the location of the test.
      From November 2020, LFD tests were made available across a wide range of workforces and universally to the public. From 26 April 2021, LFD testing expanded
      to include asymptomatic testing."),
    p("As of 01 May 2022, LFDs are no longer distributed for universal offer, but are still available for those visiting a hospital or care home, unpaid carers,
      those eligible for COVID treatments and those applying for the self-isolation support grant."),
    p("For information regarding LFD testing during term time as part of the Schools Asymptomatic Testing Programme, please visit the ",
      tags$a("COVID-19 Education Surveillance Report", href = "https://scotland.shinyapps.io/phs-covid19-education/_w_f53417bb/#tab-9333-2"), "."),
    #p(strong("Source: ")),
    br(),
    p("Please note:"),
    tags$li("Test results and test group are self-reported, so numbers of tests and positives do not include tests which have not been registered on the UK Gov Portal."),
    tags$li("Before 28 July 2021, tests for Universal Offer were entered on the system as 'Other'."),
    #tags$li("The data in this tab only cover submissions with a valid CHI."),
    tags$li("Test results may still be uploaded by those who have a stock of tests ordered before the changes in testing guidance."),
    br(),
    h4("Demographics"),
    p("This section contains the total number of individuals tested and the number of individuals testing positive at least once within Scotland.
      Data are available by age, gender and Scottish Index of Multiple Deprivation (SIMD) quintile (where 1 represents the most deprived and 5 represents the least deprived).
      Please see ", tags$a("here", href = "https://www.gov.scot/collections/scottish-index-of-multiple-deprivation-2020/?utm_source=redirect&utm_medium=shorturl&utm_campaign=simd"),
      " for more information on SIMD."),
    br(),
    bsButton("jump_to_LFD_n", label = "Go to tab"),
    bsButton("jump_to_LFDdemo_n", label = "Go to demographics tab")
    )
}) # render UI close bracket

# Severe illness
output$severe_illness_notes <-renderUI({

  tagList(
    h4("Hospital admissions"),
    p("These admissions are defined as: A patient's first positive PCR or LFD test of the episode of infection (including reinfections at 90 days or more after
      their last positive test) for COVID-19 up to 14 days prior to admission to hospital, on the day of their admission or during their stay in hospital."),
    p(strong("Source: Rapid and Preliminary Inpatient Data (RAPID)")),
    br(),
    p("Please note:"),
    tags$li("Episodes of reinfection were included from 01 March 2022, so care should be taken when interpreting trends over time. For more information, see ",
            tags$a("here", href = "https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/"), "."),
    tags$li("Patients are not included in the analysis if their first positive PCR or LFD test of the episode of infection is after their date of discharge from hospital."),
    tags$li("People who were admitted for a non-COVID-19 reason, who tested positive upon admission, may be included, as analysis does not take into account
            reason for hospitalisation."),
    tags$li("An admission is defined as a period of stay in a single hospital. There may be multiple admissions for a single patient if they have moved between
            locations during a continuous inpatient stay, or if they have been admitted to hospital on separate occasions."),
    br(),

    h4("Length of stay (LOS)"),
    p("Length of stay, i.e. the length of time an individual spends in hospital, is an important indicator for measuring the severity of COVID-19."),
    p(strong("Source: Rapid and Preliminary Inpatient Data (RAPID)")),
    br(),
    p("Please note:"),
    tags$li("LOS can be influenced by a variety of factors including age, reason for admission, co-morbidities and hospital pressures. The LOS analysis
            presented in the hospital admissions tab has not been adjusted to account for these factors."),
    br(),

    h4("Ethnicity"),
    p("Please note that the data on hospital admissions by ethnicity only refers to laboratory confirmed (PCR) COVID-19 tests."),
    br(),

    h4("ICU admissions"),
    p("COVID-19 varies in severity from very mild symptoms through to those requiring hospital admission and the most ill who require intensive care treatment and
      supported ventilation in an Intensive Care Unit (ICU). Monitoring the admission frequency to critical care units in Scotland (ICU) is therefore an important
      measure of the severity of COVID-19."),
    #p("Counts include any patient with a confirmed positive COVID-19 test taken prior to discharge from an ICU in Scotland."),
    p("Includes any patient admitted to ICU with:"),
    tags$li("a valid linkage to laboratory data ", strong("AND")),
    tags$li("with laboratory confirmation for COVID-19 during the 21 days before the date of ICU admission ", strong("OR")),
    tags$li("with laboratory confirmation for COVID-19 during their ICU stay, from the date of ICU admission up to and including the date of ICU discharge."),
    p(strong("Source: SICSAG")),
    br(),
    p("Please note:"),
    tags$li("SICSAG data are stored in a dynamic database and subject to ongoing validations, so data may change weekly."),
    tags$li("Counts do not include any COVID-19 suspected cases who have not yet been lab confirmed. Therefore, there may be a lag for recent days where patients
            may still be awaiting the results of COVID-19 tests."),
    tags$li("Data excludes any patient under the age 15."),
    tags$li("Individual patients are identified using their CHI number as recorded within the ICU admissions system. There may be a very small number of patients
            where CHI was not recorded, for whom linkage to ECOSS for COVID-19 status may not have been possible."),
    tags$li("On 30 October 2020, Public Health Scotland became aware of an ongoing issue when linking ICU data to laboratory data for COVID-19 test results.
            Any COVID-19 positive patients with a missing a CHI number that had a first positive test in the community are unable to be linked to ICU data.
            As a result, the COVID-19 positive ICU patients could be underreported by up to 10%."),
    br(),
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
      p("")),
    #p(strong("Source: ")),
    br(),
    bsButton("jump_to_pop_interest_n", label = "Go to tab")
    )
}) # render UI close bracket

# Surveillance
output$surveillance_notes <-renderUI({

  tagList(
    h4("NHS24"),
    p("NHS24 is a phone line which provided support and medical advice to those concerned about coronavirus symptoms. The launch of the Redesign of Urgent Care programme
      has seen an increase in NHS24 activity from 01 December 2020 onwards. For more information on this programme, see ",
      tags$a("here", href = "https://www.gov.scot/policies/healthcare-standards/unscheduled-care/")),
    #p(strong("Source:")),
    br(),
   # p("Please note:"),
   # tags$li(""),
   # tags$li(""),
   # br(),
    h4("Scottish Ambulance Service (SAS)"),
    p("SAS currently publish weekly unscheduled care operational statistics", tags$a("here.",
                                                                                     href = "https://www.scottishambulance.com/publications/unscheduled-care-operational-statistics/")),
      p("This publication details unscheduled care demand, response times and turnaround times."),
    #p(strong("Source: ")),
    br(),
    p("Please note:"),
    tags$li("Data published by SAS are sourced from a different operational system than that used for the Public Health Scotland (PHS) reporting, meaning that the data published by SAS will sometimes
            be slightly different to those reported by a PHS source. The data published by PHS are less timely than the data used for the SAS publication, however the PHS data here can be linked in order
            to gain further insight into patient flow through unscheduled care. "),
    tags$li("Data for the most recent 3 weeks should be treated as provisional."),
    tags$li("From 01 April 2022, the definition of SAS response times has changed. For more information, see the link above."),
    br(),
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
    #p(strong("Source: NSS Service Now wastage form")),
    br(),
    p("Please note:"),
    tags$li("The vaccine wastage form is populated by health board clinicians which can impact the timeliness and accuracy of the data."),
    tags$li("Data excludes GP practice information and wastage from clinical trials"),
    br(),
    bsButton("jump_to_vaccinations_n", label = "Go to tab")
    )
}) # render UI close bracket


