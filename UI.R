##### ..... =====
##### ui.R =====
##### ..... =====
##### Library =====
lib <- c("shiny",
         "shinyWidgets",
         "shinythemes",
         "PerformanceAnalytics",
         "quantmod",
         "DT", 
         "quadprog", 
         "data.table",
         "plotly",
         "readr"
         )
lapply(lib, require, character.only = TRUE)

##### ..... =====
##### Shiny =====
shinyUI(
  navbarPage(
    "Global Dynamic Asset Allocation",
    # theme = shinythemes::shinytheme("cosmo"),
    
    # Main Page: Portfolio Return
    tabPanel("Portfolio",
             tabsetPanel(
               type = "tabs",
               
               tabPanel("Cumulative Return",
                        br(),
                        dateRangeInput('range', 'Date Range',
                                       start = '2008-01-01',
                                       end = Sys.Date(),
                                       min = '2008-01-01',
                                       max = Sys.Date(),
                                       format = "yyyy-mm-dd",
                                       separator = " - "),
                        br(),
                        plotlyOutput("port_ret"),
                        br(),
                        plotlyOutput("port_ret_yr"),
                        br(),
                        br(),
                        fluidRow(
                          column(6, DT::dataTableOutput("port_table")),
                          column(6, DT::dataTableOutput("port_table_year"))
                        )
                        
               ),
               tabPanel("Weight",
                        br(),
                        plotlyOutput("wts_now"),
                        br(),
                        dateRangeInput('range2', 'Date Range',
                                       start = '2008-01-01',
                                       end = Sys.Date(),
                                       min = '2008-01-01',
                                       max = Sys.Date(),
                                       format = "yyyy-mm-dd",
                                       separator = " - "),
                        plotlyOutput("wts_hist"),
                        br(),
                        DT::dataTableOutput("wts_table")
               ),
               tabPanel("Raw Data",
                        br(),
                        dateRangeInput('range3', 'Date Range',
                                       start = '2008-01-01',
                                       end = Sys.Date(),
                                       min = '2008-01-01',
                                       max = Sys.Date(),
                                       format = "yyyy-mm-dd",
                                       separator = " - "),
                        plotlyOutput("raw_ret_chart"),
                        br(),
                        DT::dataTableOutput("raw_data"),
                        br(),
                        fluidRow(
                          column(1, offset = 10,
                                 downloadButton("downloadData", "Download Data")
                          )),
                        br())
               
             )
    ),
    
    # Description for strategy
    tabPanel("Description",
             tabsetPanel(
               type = "tabs",
               
               tabPanel("Strategy",
                        br(),
                        strong("Global Dynamic Asset Allocation"),
                        br(),
                        tags$ul(
                          tags$li("Strategy to perform asset allocation using momentum"),
                          tags$li("Invested in top 5 assets, which were among the top 10 global assets"),
                          tags$li("Calculate momentum indices using returns from 3 months to 12 months")
                        ),
                        br(),
                        strong("Weight of each asset"),
                        withMathJax(),
                        br(),
                        tags$ul(
                          tags$li("Variance of the portfolio is minimized"),
                          tags$li("The sum of the total weights is 1"),
                          tags$li("At least 10% and maximum 30% for each category to prevent corner solution")
                        ),
                        uiOutput('ex1'),
                        br(),
                        strong("ETC"),
                        br(),
                        tags$ul(
                          tags$li("Use a adjusted stock price that includes dividends"),
                          tags$li("Buy / sell commission 30bp"),
                          tags$li("Rebalancing by the end of the month")
                        )
               ),
               
               tabPanel("Universe",
                        br(),
                        tableOutput("univ")
               )
             )),
    
    # Author: Henry
    tabPanel("About Henry",
             strong("Education, Certificate"),
             tags$ul(
               tags$li("Ph.D. student, Finance, Hanyang University"),
               tags$li("M.S., Financial Engineering, KAIST"),
               tags$li("B.A., Business Management, Hanyang University"),
               tags$li("CFA, FRM")
             ),
             div(),
             strong("Job Experience"),
             tags$ul(
               tags$li("2019 ~ : Meritz Insurance, Data Analysis"),
               tags$li("2016 ~ 2019 : NH-Amundi Asset Management, Quant Manager"),
               tags$li("2014 ~ 2016 : Korea Investment & Securities, Equity Manager")
             ),
             div(),
             strong("Contact Information"),
             tags$ul(
               tags$li("http://henryquant.blogspot.com"),
               tags$li("https://kr.linkedin.com/in/hyunyul-lee-34952096"),
               tags$li("https://github.com/hyunyulhenry"),
               tags$li("leebisu@gmail.com")
             )
    )
    
  )
) 
