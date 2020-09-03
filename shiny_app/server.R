#Server side

function(input, output, session) {
  
  # For debugging
  # observeEvent(input$browser, browser())
  
  ###############################################.
  ## Functions 
  # Sourcing file with functions code
  source(file.path("functions_server.R"),  local = TRUE)$value
  
  ###############################################.
  # Summary trends tab  
  source(file.path("summary_tab.R"),  local = TRUE)$value
  
  ###############################################.
  # Data tab
  source(file.path("data_tab.R"),  local = TRUE)$value
  
  ###############################################.
  
  ## Observe events to improve navigation between tabs of the app
  # To jump to data pages    
  observeEvent(input$jump_to_summary, {updateTabsetPanel(session, "intabset", selected = "summary")})
  observeEvent(input$jump_to_table, {updateTabsetPanel(session, "intabset", selected = "table")})
  

  # # To jump to commentary tab from Trends
  observeEvent(input$jump_commentary_summary, {updateTabsetPanel(session, "intabset", selected = "comment")})  

  
  # ## ObserveEvents to open collapsepanels in commentary tab when sidepanel option clicked
  # observeEvent(input$summary_button, ({
  #   updateCollapse(session, "collapse_commentary", open = "Key trends")}))
  # 
  # observeEvent(input$positivecases_button, ({
  #   updateCollapse(session, "collapse_commentary", open = "Positive Cases")}))
  # 
  # observeEvent(input$admissions_button, ({
  #   updateCollapse(session, "collapse_commentary", open = "Admissions")}))
  # 
  # observeEvent(input$ICU_button, ({
  #   updateCollapse(session, "collapse_commentary", open = "ICU")}))
  # 
  # observeEvent(input$NHS24_button, ({
  #   updateCollapse(session, "collapse_commentary", open = "NHS24")}))
  # 
  # observeEvent(input$AssessmentHub_button, ({
  #   updateCollapse(session, "collapse_commentary", open = "Assessment Hubs")}))
  # 
  # observeEvent(input$SAS_button, ({
  #   updateCollapse(session, "collapse_commentary", open = "SAS")}))
  
} # server end