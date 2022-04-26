## mtu_keypoints objects
parse_mtu_key_points <- function(data){
  
  get_figure <- function(flag, time, measure){
    
    flag <- case_when(flag == "s" ~ "Symptomatic",
                      flag == "a" ~ "Asymptomatic",
                      flag == "t" ~ "Total")
    
    period <- case_when(time == "f" ~ "Full",
                             time == "w" ~ "Latest Week")
    
    
    var <- case_when(measure == "num" ~ "Number of Tests",
                     measure == "perc" ~ "Percentage Positive")
    
    mtu_keypoints %>% 
      mutate(`Percentage Positive` = paste0(`Percentage Positive`, "%"),
             `Number of Tests` = format(`Number of Tests`, big.mark = ",")) %>%
      filter(flag_covid_symptomatic == flag,
                             time_period == period) %>%
      pull(var) %>% paste0
  }
  
  get_dates <- function(period){
    period <- case_when(period == "w" ~ "Latest Week",
                       period == "f" ~ "Full")
  
    date <- mtu_keypoints %>% filter(time_period == period) %>%
      pull(time_period_dates) %>% unique() %>% paste0
    
    paste0("(", date, ")")
    }
  
  get_mtu_ats <- function(period, measure){
    period <- case_when(period == "w" ~ "Latest Week",
                        period == "f" ~ "Full")
    
    mtu_keypoints %>% filter(time_period == period) %>%
      pull(measure) %>% unique() %>% format(big.mark = ",")
    
  }
  
  tagList(
    h3("Key Points"),
    p("In the latest week", get_dates("w"), "the Community Testing Programme carried out:"),
    tags$ul(
      tags$li(strong(get_figure("t", "w", "num")), "tests, of which", 
              strong(get_figure("t", "w", "perc")), "were positive."),
      tags$li(strong(get_figure("a", "w", "num")), "asymptomatic tests, of which", 
              strong(get_figure("a", "w", "perc")), "were positive."),
      tags$li(strong(get_figure("s", "w", "num")), "symptomatic tests, of which", 
              strong(get_figure("s", "w", "perc")), "were positive."),
      tags$li(strong(get_mtu_ats("w", "MTU")), "tests through Mobile Testing Units and",
              strong(get_mtu_ats("w", "ATS")), "tests through Asymptomatic Test Sites.")),
    br(),
    p("Overall", get_dates("f"), "the Community Testing Programme carried out:"),
    tags$ul(
      tags$li(strong(get_figure("t", "f", "num")), "tests, of which", 
              strong(get_figure("t", "f", "perc")), "were positive."),
      tags$li(strong(get_figure("a", "f", "num")), "asymptomatic tests, of which", 
              strong(get_figure("a", "f", "perc")), "were positive."),
      tags$li(strong(get_figure("s", "f", "num")), "symptomatic tests, of which", 
              strong(get_figure("s", "f", "perc")), "were positive."),
    tags$li(strong(get_mtu_ats("f", "MTU")), "tests through Mobile Testing Units and",
            strong(get_mtu_ats("f", "ATS")), "tests through Asymptomatic Test Sites."))
    
  )
}
