#' @import shiny
NULL

#' A test application that uses Bootstrap 2
#'
#' In this example app, functions from the shinyBootstrap2 package will override
#' those from shiny.
#' @export
bs2App <- function() {
  shinyBootstrap2::withBootstrap2({
    shinyApp(
      ui = fluidPage(
        numericInput("n", "n", 1),
        plotOutput("plot")
      ),
      server = function(input, output) {
        output$plot <- renderPlot( plot(head(cars, input$n)) )
      }
    )
  })
}

#' A test application that uses Bootstrap 3
#'
#' In this example app, functions from the shiny package will be used;
#' shinyBootstrap2 won't be used at all.
#' @export
bs3App <- function() {
  shinyApp(
    ui = fluidPage(
      numericInput("n", "n", 1),
      plotOutput("plot")
    ),
    server = function(input, output) {
      output$plot <- renderPlot( plot(head(cars, input$n)) )
    }
  )
}
