#' @import shiny
NULL

#' A test application that uses Bootstrap 2
#'
#' In this example app, functions from the shinybootstrap2 package will override
#' those from shiny.
#' @export
bs2appObj <- function() {
  shinybootstrap2::withBootstrap2({
    shinyApp(
      ui = fluidPage(
        sidebarPanel(selectInput("n", "n", c(1, 5, 10))),
        mainPanel(plotOutput("plot"))
      ),
      server = function(input, output) {
        output$plot <- renderPlot({
          plot(head(cars, as.numeric(input$n)))
        })
      }
    )
  })
}

#' A test application that uses Bootstrap 3
#'
#' In this example app, functions from the shiny package will be used;
#' shinybootstrap2 won't be used at all.
#' @export
bs3appObj <- function() {
  shinyApp(
    ui = fluidPage(
      sidebarPanel(selectInput("n", "n", c(1, 5, 10))),
      mainPanel(plotOutput("plot"))
    ),
    server = function(input, output) {
      output$plot <- renderPlot({
        plot(head(cars, as.numeric(input$n)))
      })
    }
  )
}
