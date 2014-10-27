fluidPage(
  titlePanel("Tabsets"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("dist", "Distribution type:",
                   c("Normal" = "norm",
                     "Uniform" = "unif",
                     "Log-normal" = "lnorm",
                     "Exponential" = "exp")),
      br(),
      
      sliderInput("n", 
                  "Number of observations:", 
                   value = 500,
                   min = 1, 
                   max = 1000)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
        tabPanel("Plot", plotOutput("plot")), 
        tabPanel("Summary", verbatimTextOutput("summary")), 
        tabPanel("Table", tableOutput("table"))
      )
    )
  )
)
