#Server side

function(input, output, session) {

  ###############################################.
  # Sourcing file with functions code
  source(file.path("functions_server.R"),  local = TRUE)$value
  
  ###############################################.
  # Summary trends tab  
  source(file.path("summary_tab.R"),  local = TRUE)$value
  
  
  ###############################################.
  # Data tab
  source(file.path("data_tab.R"),  local = TRUE)$value
  
  
  ###############################################.
  # Contact Tracing tab
  source(file.path("contact_tracing_tab.R"),  local = TRUE)$value
  
  
  ###############################################.
  # Contact Tracing Data tab  
  source(file.path("contact_tracing_data_tab.R"),  local = TRUE)$value  
  
  ###############################################.
  # Settings tab  
  source(file.path("setting_tab.R"),  local = TRUE)$value  
  
  ###############################################.
  # HCW tab  
  source(file.path("health_care_workers_data_tab.R"),  local = TRUE)$value
  
  ###############################################.
  # Care Homes tab  
  source(file.path("care_home_data_tab.R"),  local = TRUE)$value
  
  ###############################################.
  # Ethnicity chart tab  
  #source(file.path("ethnicity_tab.R"),  local = TRUE)$value
  
  ###############################################.
  
  ## Observe events to improve navigation between tabs of the app
  # To jump to data pages    
  observeEvent(input$jump_to_summary, {updateTabsetPanel(session, "intabset", selected = "summary")})
  observeEvent(input$jump_to_table, {updateTabsetPanel(session, "intabset", selected = "table")})
  observeEvent(input$jump_to_CTtable, {updateTabsetPanel(session, "intabset", selected = "CTtable")})
  observeEvent(input$jump_to_HCW, {updateTabsetPanel(session, "intabset", selected = "HCWtable")})
  observeEvent(input$jump_to_CH, {updateTabsetPanel(session, "intabset", selected = "CHData")})
  
  
} # server end