#Server side

function(input, output, session) {

  ###############################################.
  # Chart layout
  source(file.path("functions/functions_chart_layout.R"),  local = TRUE)$value
  # Functions for graphs
  source(file.path("functions/functions_server.R"),  local = TRUE)$value
  # Data table
  source(file.path("functions/functions_tables.R"),  local = TRUE)$value
  ###############################################.
  # Sourcing individual tabs
  ###############################################.
  # Notes
  source(file.path("tabs/notes_tab.R"), local = TRUE)$value
  # Summary info
  source(file.path("tabs/summary_tab.R"), local = TRUE)$value
  source(file.path("tabs/data_tab.R"), local = TRUE)$value
  # LFDs
  source(file.path("tabs/lfd_tab.R"),  local = TRUE)$value
  source(file.path("tabs/lfd_demo_tab.R"), local = TRUE)$value
  # Populations of interest
  source(file.path("tabs/populations_of_interest_tab.R"), local = TRUE)$value
  # Vaccinations
  source(file.path("tabs/vaccinations_tab.R"), local = TRUE)$value
  ###############################################.
  # Archived tabs
  source(file.path("tabs/archived_tabs/contact_tracing_tab.R"),  local = TRUE)$value
  source(file.path("tabs/archived_tabs/contact_tracing_data_tab.R"),  local = TRUE)$value
  source(file.path("tabs/archived_tabs/travel_tab.R"),  local = TRUE)$value
  source(file.path("tabs/archived_tabs/setting_tab.R"),  local = TRUE)$value
  source(file.path("tabs/archived_tabs/health_care_workers_data_tab.R"),  local = TRUE)$value
  source(file.path("tabs/archived_tabs/quarantine_tab.R"),  local = TRUE)$value
  source(file.path("tabs/archived_tabs/care_home_data_tab.R"),  local = TRUE)$value
  source(file.path("tabs/archived_tabs/mtu_key_points_function.R"), local = TRUE)$value
  source(file.path("tabs/archived_tabs/mtu_tab.R"),  local = TRUE)$value
  source(file.path("tabs/archived_tabs/vaccine_certification_tab.R"), local = TRUE)$value

  ## Observe events to improve navigation between tabs of the app
  # To jump to tabs and data pages
  observeEvent(input$jump_to_notes, {updateTabsetPanel(session, "intabset", selected = "Notes")})
  observeEvent(input$jump_to_inf_cases, {updateTabsetPanel(session, "intabset", selected = "InfCases")})
  observeEvent(input$jump_to_inf_cases_data, {updateTabsetPanel(session, "intabset", selected = "InfCasesData")})
  observeEvent(input$jump_to_LFD, {updateTabsetPanel(session, "intabset", selected = "LFDData")})
  observeEvent(input$jump_to_LFDdemo, {updateTabsetPanel(session, "intabset", selected = "LFDdemoData")})
  observeEvent(input$jump_to_severe_illness, {updateTabsetPanel(session, "intabset", selected = "SevereIllness")})
  observeEvent(input$jump_to_severe_illness_data, {updateTabsetPanel(session, "intabset", selected = "SevereIllnessData")})
  observeEvent(input$jump_to_pop_interest, {updateTabsetPanel(session, "intabset", selected = "PopInterest")})
  observeEvent(input$jump_to_care_homes_testing, {updateTabsetPanel(session, "intabset", selected = "CareHomesTesting")})
  observeEvent(input$jump_to_care_homes_visitors, {updateTabsetPanel(session, "intabset", selected = "CareHomesVisitors")})
  observeEvent(input$jump_to_surveillance, {updateTabsetPanel(session, "intabset", selected = "Surveillance")})
  observeEvent(input$jump_to_surveillance_data, {updateTabsetPanel(session, "intabset", selected = "SurveillanceData")})
  observeEvent(input$jump_to_vaccinations, {updateTabsetPanel(session, "intabset", selected = "Vaccinations")})
  observeEvent(input$jump_to_vax_cert, {updateTabsetPanel(session, "intabset", selected = "vaccinetab")})

  # To jump to tabs and data pages for notes tab
  observeEvent(input$jump_to_notes_n, {updateTabsetPanel(session, "intabset", selected = "Notes")})
  observeEvent(input$jump_to_inf_cases_n, {updateTabsetPanel(session, "intabset", selected = "InfCases")})
  observeEvent(input$jump_to_inf_cases_data_n, {updateTabsetPanel(session, "intabset", selected = "InfCasesData")})
  observeEvent(input$jump_to_inf_cases_n2, {updateTabsetPanel(session, "intabset", selected = "InfCases")})
  observeEvent(input$jump_to_inf_cases_data_n2, {updateTabsetPanel(session, "intabset", selected = "InfCasesData")})
  observeEvent(input$jump_to_LFD_n, {updateTabsetPanel(session, "intabset", selected = "LFDData")})
  observeEvent(input$jump_to_LFDdemo_n, {updateTabsetPanel(session, "intabset", selected = "LFDdemoData")})
  observeEvent(input$jump_to_severe_illness_n, {updateTabsetPanel(session, "intabset", selected = "SevereIllness")})
  observeEvent(input$jump_to_severe_illness_data_n, {updateTabsetPanel(session, "intabset", selected = "SevereIllnessData")})
  observeEvent(input$jump_to_pop_interest_n, {updateTabsetPanel(session, "intabset", selected = "PopInterest")})
  observeEvent(input$jump_to_surveillance_n, {updateTabsetPanel(session, "intabset", selected = "Surveillance")})
  observeEvent(input$jump_to_surveillance_data_n, {updateTabsetPanel(session, "intabset", selected = "SurveillanceData")})
  observeEvent(input$jump_to_vaccinations_n, {updateTabsetPanel(session, "intabset", selected = "Vaccinations")})

  # To jump to commentary tab and ensures correct panel is expanded
  # action buttons must have unique ID
  observeEvent(input$jump_to_notes_inf_cases, {updateTabsetPanel(session, "intabset", selected = "Notes")
    updateCollapse(session, "collapse_notes", open = "Cases & infection levels")})
  observeEvent(input$jump_to_timeline, {updateTabsetPanel(session, "intabset", selected = "Notes")
    updateCollapse(session, "collapse_notes", open = "Changes in COVID-19 testing policy")})
  observeEvent(input$jump_to_notes_LFD, {updateTabsetPanel(session, "intabset", selected = "Notes")
    updateCollapse(session, "collapse_notes", open = "Lateral Flow Devices (LFDs)")})
  observeEvent(input$jump_to_notes_LFDdemo, {updateTabsetPanel(session, "intabset", selected = "Notes")
    updateCollapse(session, "collapse_notes", open = "Lateral Flow Devices (LFDs)")})
  observeEvent(input$jump_to_notes_severe_illness, {updateTabsetPanel(session, "intabset", selected = "Notes")
    updateCollapse(session, "collapse_notes", open = "Severe illness")})
  observeEvent(input$jump_to_notes_pop_interest, {updateTabsetPanel(session, "intabset", selected = "Notes")
    updateCollapse(session, "collapse_notes", open = "Populations of interest")})
  observeEvent(input$jump_to_notes_surveillance, {updateTabsetPanel(session, "intabset", selected = "Notes")
    updateCollapse(session, "collapse_notes", open = "Surveillance")})
  observeEvent(input$jump_to_notes_vaccinations_waste, {updateTabsetPanel(session, "intabset", selected = "Notes")
    updateCollapse(session, "collapse_notes", open = "Vaccinations")})
  observeEvent(input$jump_to_notes_vaccinations_cert, {updateTabsetPanel(session, "intabset", selected = "Notes")
    updateCollapse(session, "collapse_notes", open = "Vaccinations")})

  # Archived
  observeEvent(input$jump_to_CT, {updateTabsetPanel(session, "intabset", selected = "CT")})
  observeEvent(input$jump_to_CTtable, {updateTabsetPanel(session, "intabset", selected = "CTtable")})
  observeEvent(input$jump_to_travel, {updateTabsetPanel(session, "intabset", selected = "travelData")})
  observeEvent(input$jump_to_HCW, {updateTabsetPanel(session, "intabset", selected = "HCWtable")})
  observeEvent(input$jump_to_care_homes, {updateTabsetPanel(session, "intabset", selected = "CareHomes")})
  observeEvent(input$jump_to_quarantine, {updateTabsetPanel(session, "intabset", selected = "QData")})
  observeEvent(input$jump_to_CH, {updateTabsetPanel(session, "intabset", selected = "CHData")})
  observeEvent(input$jump_to_mtu, {updateTabsetPanel(session, "intabset", selected = "MTUtab")})
  observeEvent(input$jump_to_vaccine, {updateTabsetPanel(session, "intabset", selected = "vaccinetab")})
  observeEvent(input$jump_to_surveillance_archive, {updateTabsetPanel(session, "intabset", selected = "SurveillanceArchive")})


} # server end