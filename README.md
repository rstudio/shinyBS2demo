Demo package for shinyBootstrap2
================================

The purpose of this package is to demonstrate how to use the the shinyBootstrap2 package.


## Quick start

```R
# Install Bootstrap 3 branch of Shiny
devtools::install_github('rstudio/shiny@feature/bootstrap3')

devtools::install_github('rstudio/shinyBootstrap2')

devtools::install_github('wch/bs2demo')
```


## Usage at the console.

Versions of Shiny up to and including 0.10.2, generate HTML that uses Bootstrap 2. After version 0.10.2, Shiny switched to Bootstrap 3, which is not fully compatible with Bootstrap 2. So, if you're using Shiny > 0.10.2, this would generate a page using Bootstrap 3 when run at the R console:

```R
library(shiny)

shinyApp(
  ui = fluidPage(
    numericInput("n", "n", 1),
    plotOutput("plot")
  ),
  server = function(input, output) {
    output$plot <- renderPlot( plot(head(cars, input$n)) )
  }
)

```


To use Bootstrap 2, simply wrap your code  which uses Bootstrap 2 in `shinyBootstrap2::withBootstrap2()`. For example:

```R
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
```

You'll notice that the appearance is slightly different. If you inspect the HTML source in your web browser, you'll see that this uses Bootstrap 2, while the previous code uses Bootstrap 3.

## Usage in a package

To use shinyBootstrap2 components in a package, the DESCRIPTION file should list it in Imports:

```
Imports:
    shinyBootstrap2
```

However, the NAMESPACE should _not_ contain `import(shinyBootstrap2)`. If you are using roxygen2 for documentation, this means you should not have `#' @import shinyBootstrap2` anywhere in your code.

There are two different ways you can use shinyBootstrap2 in a package:

* Use `shinyBootstrap2::withBootstrap2()`.
* Add `importFrom(shinyBootstrap2,withBootstrap2)` to your NAMESPACE file (if you are using roxygen2, you would add `#' @importFrom shinyBootstrap2 withBootstrap2` to your code), then use `withBootstrap2()` in your code. 

The examples below will use the first method, although the second method will work just as well.

### Functions that return a shiny app object

If your package has functions that return a shiny app object (by calling `shinyApp()`), then you can call `shinyBootstrap2::withBootstrap2()` inside those functions. For example, `testApp2` function in this package looks like this:

```R
testApp2 <- function() {
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
```

A user of this test package would run it with:

```R
library(bs2demo)
bs2App()
```

You can contrast it to the `testApp3()` function, which doesn't have `withBootstrap2()` and therefore uses the default Bootstrap 3 components from Shiny:

```R
bs3App()
```


### Shiny application files

Most Shiny applications consist of a `server.R` plus `ui.R`, or, for single file apps, `app.R`. To use these with shinyBootstrap2, simply wrap all the code in `shinyBootstrap2::withBootstrap2()`. The applications in the inst/ directory of this package use this format. To run them, you can do:


```R
# Uses shinyBootstrap2
runApp(system.file('bs2app', package='bs2demo'))

# Uses Bootstrap 3 components from shiny
runApp(system.file('bs3app', package='bs2demo'))
```

To create an app in inst/ like this, the code in ui.R would be wrapped in `withBootstrap2()`:

```R
## ui.R
shinyBootstrap2::withBootstrap2({
  fluidPage(
    selectInput("ui", "Input type", choices = c("numeric", "slider")),
    uiOutput("n_ui"),
    plotOutput("plot")
  )
})
```

The code in server.R needs `withBootstrap2()` only if it contains dynamic UI-generating code -- that is, code that is used with `renderUI()`. Here's an example server.R to go with the code above:

```R
## server.R
shinyBootstrap2::withBootstrap2({
  function(input, output) {
    output$n_ui <- renderUI({
      if (input$ui == "numeric")
        numericInput("n", "n", 1)
      else if (input$ui == "slider")
        sliderInput("n", "n", 1, 10, value = 1)
    })
    output$plot <- renderPlot( plot(head(cars, input$n)) )
  }
})
```



If you have `global.R`, or other files that generate UI code, all the UI-generating code must be wrapped in `shinyBootstrap2::withBootstrap2()`.


For a single-file app, you can simply wrap all the code in `shinyBootstrap2::withBootstrap2()`.


## Usage notes

Unlike most packages, the shinyBootstrap2 package should not be attached by calling `library(shinyBootstrap2)`; it should be used with `shinyBootstrap2::withBootstrap2()`. 

This is because attaching the package would cause Bootstrap 2 components mask the Bootstrap 3 objects from Shiny, even outside of `withBootstrap2()`. In order to restrict the scope of Bootstrap 2 components, always use `shinyBootstrap2::withBootstrap2()`.
