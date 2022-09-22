#### Notes tab

# Cases & infection levels
output$cases_inf_notes <-renderUI({

  tagList(
    h4("Reported cases"),
    p("Reported cases include both polymerase chain reaction (PCR) and lateral flow device (LFD) positive test results."),
    p("There have been changes in testing practices in ",
      tags$a("May", href="https://www.gov.scot/publications/test-protect-transition-plan/?msclkid=69623e15ba4711ecb8a394934cbaa327"),
      " (end of universal testing) and ",
      tags$a("September", href="https://www.sehd.scot.nhs.uk/dl/DL(2022)32.pdf"),
      "(end of asymptomatic testing) which make it difficult
      to draw any conclusions from these data on community prevalence, therefore, caution is advised when comparing trends in cases over time.
      LFD/PCR data precedes the ONS data by approximately two weeks, and therefore, can give an early estimate of the trends in infection rates in Scotland.
      The ONS COVID-19 household survey gives robust estimates of community incidence over time."),
    p("These data are published on Wednesdays on the ",
      tags$a("COVID-19 Dashboard", href = "https://public.tableau.com/app/profile/phs.covid.19/viz/COVID-19DailyDashboard_15960160643010/Dailyupdate"),
      ". The number of daily confirmed cases may differ slightly from data published on this dashboard because some
            cases are added retrospectively and assigned to days based on the most up to date records. Overall
            number of confirmed cases should not be affected."),
    p(strong("Source: PCR - Electronic Communication of Surveillance in Scotland (ECOSS); LFD - UK Government self-reported / NSS Portal")),
    br(),
    p("Please note:"),
    tags$li("The total number of people within Scotland who have, or have had, COVID-19 since the coronavirus outbreak began is unknown.
            The number of confirmed cases is likely to be an underestimate."),
    tags$li("The purpose of COVID-19 testing has now shifted from population-wide testing to reduce transmission, to targeted, symptomatic
            testing in clinical care settings. Data are continuously updated, therefore figures for previous weeks may differ
            from published data in previous weeks’ reports."),
    # This point will need removed when case data goes from daily to weekly
    tags$li("The drop in the number of confirmed cases at weekends likely reflects that laboratories are doing fewer tests at the weekend."),
    tags$li("Due to changes in testing strategy outlined below, caution is advised when comparing trends over time."),
    br(),
    h4("Reinfections"),
    p("Possible reinfections are defined as
      individuals who test positive, by PCR or LFD, 90 days or more after their last positive test."),
      p("More information is available on the ",
        tags$a("Public Health Scotland website", href = "https://publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/"),
        "."),
    br(),
    bsButton("jump_to_timeline", label = "Go to timeline of changes in testing policy"),
    bsButton("jump_to_inf_cases_n", label = "Go to cases and infection levels charts"),
    bsButton("jump_to_inf_cases_data_n", label = "Go to cases and infection levels data")
    )
  }) # render UI close bracket

# LFDs
output$LFD_notes <-renderUI({

  tagList(
    p("LFDs are clinically validated swab antigen tests that do not require a laboratory for processing, producing rapid results at the location of the test.
      From November 2020, LFD tests were made available across a wide range of workforces and universally to the public, and from 26 April 2021, LFD testing expanded
      to include asymptomatic testing."),
    p("There have been significant changes to testing policy, with the Universal Offer ending in ",
      tags$a("May", href="https://www.gov.scot/publications/test-protect-transition-plan/?msclkid=69623e15ba4711ecb8a394934cbaa327"),
   " and the end of asymptomatic testing in most settings in ",
   tags$a("September", href="https://www.sehd.scot.nhs.uk/dl/DL(2022)32.pdf"),
      " Please take caution when comparing trends over time."),
    p("For information regarding LFD testing during term time as part of the Schools Asymptomatic Testing Programme, please visit the ",
      tags$a("COVID-19 Education Surveillance Report", href = "https://scotland.shinyapps.io/phs-covid19-education/_w_f53417bb/#tab-9333-2"), "."),
    p(strong("Source: UK Government self-reported / NSS Portal")),
    br(),
    p("Please note:"),
    tags$li("Asymptomatic testing for Health and Social Care Workers will be paused from 28 September 2022. There is consensus that we are now in a downward trajectory
            from the most recent wave, with prevalence and other epidemiological indicators improving. Symptomatic testing of Health and Social Care Workers will continue using LFDs.
            More information is available", tags$a("here.", href="https://www.sehd.scot.nhs.uk/dl/DL(2022)32.pdf")),
    tags$li("Asymptomatic adult care home staff testing and visitor and visiting professional will be paused from 28 September 2022. Symptomatic care home resident testing (PCR)
            and symptomatic staff testing (LFD) and admission testing from the community for care homes (LFD) will continue. More information is available ",
            tags$a("here.", href="https://www.sehd.scot.nhs.uk/dl/DL(2022)32.pdf")),
    tags$li("Test results and test group are self-reported, so numbers of tests and positives do not include tests which have not been registered on the UK Gov Portal."),
    tags$li("Before 28 July 2021, tests for Universal Offer were entered on the system as 'Other'."),
    tags$li("Test results may still be uploaded by those who have a stock of tests ordered before the changes in testing guidance."),
    br(),
    bsButton("jump_to_timeline_2", label = "Go to timeline of changes in testing policy"),
    bsButton("jump_to_LFD_n", label = "Go to LFD tab")
  )
}) # render UI close bracket

# Testing policy timeline
output$timeline_notes <-renderUI({

  tagList(
    p("Please note the following changes to testing policy in 2022:"),
    tags$li("From 05 January 2022, reported cases included both PCR and Lateral Flow Device (LFD) positive tests. See ",
            tags$a("here", href="https://publichealthscotland.scot/news/2022/february/update-on-enhancements-to-covid-19-reporting/"), " for more information"),
    tags$li("From 01 March 2022, reported cases included episodes of reinfection at least 90 days after initial infection.
            Prior to this date, COVID-19 cases were based on an individual’s first positive test only. More information
            is available on the PHS website ",
            tags$a("here", href="https://www.publichealthscotland.scot/news/2022/february/covid-19-reporting-to-include-further-data-on-reinfections/")),
    tags$li("From mid-April 2022, as part of the Scottish Government’s  ",
            tags$a("Test and Protect transition plan", href="https://www.gov.scot/publications/test-protect-transition-plan/?msclkid=69623e15ba4711ecb8a394934cbaa327"),
             " asymptomatic testing was no longer recommended. Symptomatic PCR testing was still available, and LFD testing was still
            encouraged for hospital and care home visitors,
            those who had been in close contact with a case and to allow cases to finish their isolation after 7 days"),
    tags$li("01 May 2022 marks the beginning of updated testing policy. The purpose of COVID-19 testing has now shifted
            from population-wide testing to reduce transmission, to targeted testing.
            Therefore, reported cases will primarily include clinical care settings, health and social care workforce, surveillance, and outbreak response."),
    tags$li("Asymptomatic testing for Health and Social Care Workers will be paused from 28 September 2022. There is consensus that we are now in a downward
            trajectory from the most recent wave, with prevalence and other epidemiological indicators improving. Symptomatic testing of Health and Social
            Care Workers will continue using LFDs. More information is available  ",
            tags$a("here.", href="https://www.sehd.scot.nhs.uk/dl/DL(2022)32.pdf")),
    tags$li("Admission and pre-elective surgery testing will be paused from 28 September 2022. Pre-elective surgery testing of immunocompromised patients will
            continue (LFD), as will testing of symptomatic patients (LFD/PCR). More information is available  ",
            tags$a("here.", href="https://www.sehd.scot.nhs.uk/dl/DL(2022)32.pdf")),
    tags$li("Asymptomatic adult care home staff testing and visitor and visiting professional will be paused from 28 September 2022. Symptomatic care home resident testing
            (PCR) and symptomatic staff testing (LFD) and admission testing from the community for care homes (LFD) will continue. More information is available  ",
            tags$a("here.", href="https://www.sehd.scot.nhs.uk/dl/DL(2022)32.pdf")),
    br(),
    bsButton("jump_to_inf_cases_n2", label = "Go to cases and infection levels charts"),
    bsButton("jump_to_inf_cases_data_n2", label = "Go to cases and infection levels data")
    )
}) # render UI close bracket

# Severe illness
output$severe_illness_notes <-renderUI({

  tagList(
    h4("Hospital admissions"),
    p("COVID-19 hospital admissions are defined as: A patient’s first PCR or PCR confirmed test of the episode of infection (including reinfections at 90 days or more after their last positive test)
      for COVID-19 up to 14 days prior to admission to hospital or within two days of admission. COVID-19 hospital admissions only include emergency admissions to medical or paediatric specialties,
      excluding emergency admissions for injuries."),
    p(strong("Source: PCR - Electronic Communication of Surveillance in Scotland (ECOSS); LFD - UK Government self-reported / NSS Portal; Rapid and Preliminary Inpatient Data (RAPID)")),
    br(),
    p("Please note:"),
    tags$li("RAPID is a weekly submission of people who have been admitted to and discharged from hospital. Further, figures are subject to change as hospital records are updated.
            It can take on average 6-8 weeks before a record is finalised, particularly discharge details. "),
    tags$li("Hospital admissions for the most recent week may be incomplete for some Boards and should be treated as provisional and interpreted with caution.
            Where no data are available at the time of publication, the number of admissions for the previous week will be rolled forward for affected Boards.
            Missing data will either be due to a board not submitting on time or there being zero COVID-19 admissions in the latest week.
            These provisional data will be refreshed the following week. "),
    tags$li("These data include admissions to acute hospitals only and do not include psychiatric or maternity/obstetrics specialties.
            In the data presented here, an admission is defined as a period of stay in a single hospital. There may be multiple admissions for a single patient
            if they have moved between locations during a continuous inpatient stay (CIS), or if they have been admitted to hospital on separate occasions. "),
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
    tags$li("Length of stay in hospital can be influenced by a variety of factors including age, reason for admission, co-morbidities, and hospital pressures.
            The analysis presented in this publication has not been adjusted to account for these factors. "),
    tags$li("This information is subject to future revisions due to the completeness of discharge information (approximately 8% of records excluded due to missing discharge information)."),
    br(),
    br(),
    h4("ICU admissions"),
    p("COVID-19 varies in severity from very mild symptoms through to those requiring hospital admission and the most ill who require intensive care treatment and
      supported ventilation in an Intensive Care Unit (ICU). Monitoring the admission frequency to critical care units in Scotland (ICU) is therefore an important
      measure of the severity of COVID-19."),
    p("COVID-19 related ICU admissions have been identified as the following: A patient who has tested positive for COVID at any time in the 21 days prior to admission
      to ICU, or who has tested positive from the date of admission up to and including the date of ICU discharge. "),
    #p("Counts include any patient with a confirmed positive COVID-19 test taken prior to discharge from an ICU in Scotland."),
    p("Includes any patient admitted to ICU with:"),
    tags$li("a valid linkage to laboratory data ", strong("AND")),
    tags$li("with laboratory confirmation for COVID-19 during the 21 days before the date of ICU admission ", strong("OR")),
    tags$li("with laboratory confirmation for COVID-19 during their ICU stay, from the date of ICU admission up to and including the date of ICU discharge."),
    br(),
    p(strong("Source: Scottish Intensive Care Society Audit Group (SICSAG)")),
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
    bsButton("jump_to_severe_illness_n", label = "Go to severe illness charts"),
    bsButton("jump_to_severe_illness_data_n", label = "Go to severe illness data")
    )
}) # render UI close bracket

# Populations of interest
output$population_int_notes <-renderUI({

  tagList(
    h3("COVID-19 in care homes"),
    h4("Cases"),
    p("As of 06 April 2022, Public Health Scotland are reporting weekly data on COVID-19 cases in adult Care Homes in Scotland, previously reported by the ",
      tags$a("Scottish Government",
             href = "https://www.gov.scot/publications/coronavirus-covid-19-data-for-scotland/"),
      ". A positive case includes both new infections and possible reinfections, which are defined as individuals who test positive by PCR or LFD, 90 or more
      clear days after their last positive test."),
    p("PCR and LFD tests are linked to care homes through a variety of measures, dependent on the source. This includes the test centre ID, organisation ID
        and organisation role. Residents and staff are identified using the organisation role and test reason."),
    p(strong("Source: PCR - Electronic Communication of Surveillance in Scotland (ECOSS); LFD - UK Government self-reported / NSS Portal (health and social care cohorts)")),
    br(),
    p("Please note:"),
    tags$li("The source data are dynamic, and additional test results received will be reflected in future calculations of cases, which may affect figures retrospectively."),
    tags$li("Asymptomatic adult care home staff testing and visitor and visiting professional will be paused from 28 September 2022. Symptomatic care home resident testing (PCR)
            and symptomatic staff testing (LFD) and admission testing from the community for care homes (LFD) will continue. More information is available here. "),
    br(),
    h4("Care home visiting status by Health Board and outbreak status"),
    p("As of 24 February 2021, care home visiting guidance was updated to allow care homes to update their own visiting plans depending on COVID-19 outbreak status.
      Outbreak status is self-reported by care homes and capture status at the time of data extraction."),
    p("Care homes report indoor visiting level as one of the following: Up to two visits per week, Daily visits, or Multiple visitors. Where indoor visiting is not possible,
      outdoor and essential visits will be reported."),
    p(strong("Source: Turas Care Home Management System")),
    br(),
    p("Please note:"),
    tags$li("Data should be treated as provisional"),
    tags$li("There may be a lag between a change in care home visiting guidance and a care home updating their corresponding visiting status in the tool. Therefore,
            these data are to be interpreted as a guide, and may not be representative of current visiting status. For this reason, weekly data is not comparable"),
    tags$li("As these data are self-reported, quality of information is dependent on accurate data entry, although there are some data checks for robustness"),
    tags$li("Outbreak status reported may not match information from the Care Inspectorate (link) as timely data entry can be impacted by external factors"),
    tags$li("Not all care homes submit information on a daily basis so there will be care homes where no information is available on a certain day, and this can vary considerably daily and weekly"),
    tags$li("A small number of homes have not submitted outbreak data for an extended period, so data presented only include care homes that have submitted data in the last 30 days"),
    tags$li("Where care homes have submitted data on multiple days within the time period, the latest status is reported. Therefore data are to be interpreted as a snapshot from within the reporting week"),
    tags$li("“Other visiting status” represents outdoor visits only"),
    tags$li("Data for individual NHS Health Boards reflect local circumstances. Therefore, caution is advised when drawing comparisons between boards"),
    bsButton("jump_to_care_homes_testing", label = "Go to care home COVID-19 cases"),
    bsButton("jump_to_care_homes_visitors", label = "Go to care home visiting status")
    )
}) # render UI close bracket

# Surveillance
output$surveillance_notes <-renderUI({

  tagList(
    p("SAS currently publish weekly unscheduled care operational statistics", tags$a("here.",
                                                                                     href = "https://www.scottishambulance.com/publications/unscheduled-care-operational-statistics/")),
      p("This publication details unscheduled care demand, response times and turnaround times."),
    p(strong("Source: SAS and Unscheduled Care Datamart")),
    br(),
    p("Please note:"),
    tags$li("Data published by SAS are sourced from a different operational system than that used for the Public Health Scotland (PHS) reporting, meaning that the data published by SAS will sometimes
            be slightly different to those reported by a PHS source. The data published by PHS are less timely than the data used for the SAS publication, however the PHS data here can be linked in order
            to gain further insight into patient flow through unscheduled care. "),
    tags$li("Data for the most recent 3 weeks should be treated as provisional."),
    tags$li("From 01 April 2022, the definition of SAS response times has changed. For more information, see the link above."),
    br(),
    bsButton("jump_to_surveillance_n", label = "Go to SAS charts"),
    bsButton("jump_to_surveillance_data_n", label = "Go to SAS data")
    )
}) # render UI close bracket

# Vaccinations
output$vaccinations_notes <-renderUI({

  tagList(
    h4("COVID-19 vaccine certification"),
    p("The NHS Covid Status App was launched on 30 September 2021. It is free and offers digital proof of vaccination via a QR code for each vaccination received. You can request a
      vaccine certificate if you are aged 12 and over and have been vaccinated in Scotland."),
    p("You can show your COVID-19 vaccine status by using the ", tags$a("NHS Scotland Covid Status app",
                                                                        href = "https://www.nhsinform.scot/covid-status"),
      ", download a PDF copy of your status from the app or ", tags$a("get a paper record of your vaccine status from NHS Inform",
                                                                      href = "https://www.nhsinform.scot/nhs-scotland-covid-status/"), "."),
    # p("Check the vaccine certification scheme guidance for ", tags$a("businesses and event organisers",
    #                                                                  href = ""), "and for", tags$a("customers",
    #                                                                                                href = ""), "."),
    p("For further information, you can refer to the ", tags$a("Scottish Government website",
                                                           href = "https://www.gov.scot/news/living-safely-with-covid/"), "."),
    br(),
    p("The app downloads figure refers to the combined number of downloads of the NHS Scotland Covid Status App from Google Play and Apple App Store. The number of PDFs and Letters
      are taken from the citizen portal where users can choose to request a paper copy or download a PDF of their vaccination certificate."),
    #p(strong("Source: ")), #tbc
    br(),
    p("Please note:"),
    tags$li("Vaccine certifications are no longer legally required in Scotland, but the app will remain available for any business that wishes to continue certification
            on a voluntary basis to reassure customers."),
    tags$li("The record will not show any vaccinations given outside of Scotland."),
    br(),
    h4("Vaccine wastage"),
    p("Given the scale of the Covid-19 vaccination programme, some vaccine wastage has been unavoidable for a variety of reasons including logistical issues,
      storage failure and specific clinical situations."),
    p("The initial planning assumption for the vaccination programme was that there would be around 5% vaccine wastage."),
    p(strong("Source: NSS Service Now wastage form")),
    br(),
    p("Please note:"),
    tags$li("Percent wasted is calculated as (Number of Doses Wasted x 100) / (Number of Doses Wasted + Administered)"),
    tags$li("The vaccine wastage form is populated by health board clinicians which can impact the timeliness and accuracy of the data."),
    tags$li("Data excludes GP practice information and wastage from clinical trials."),
    tags$li("Excess stock is defined: Where a vaccination team reach the end of an allotted shift or job, and have surplus vaccines that cannot be returned to stock,
            or used before it expires. This includes any unused doses in opened vials at the end of a clinic."),
    br(),
    bsButton("jump_to_vax_cert", label = "Go to vaccine certification tab"),
    bsButton("jump_to_vaccinations_n", label = "Go to vaccine wastage tab")
    )
}) # render UI close bracket



