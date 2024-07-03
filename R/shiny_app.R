# https://stackoverflow.com/a/30808472

nonogramr_shiny <- function(puzzle = hi_puzzle) {

  find_cell <- function(e, mygame = mygame) {
    if (is.null(e)) {
      return(NULL)
    }
    if (
      e[["x"]] < 0.5 || e[["x"]] > (mygame@state@width + 0.5) ||
        e[["y"]] < 0.5 || e[["y"]] > (mygame@state@height + 0.5)
    ) {
      return(NULL)
    }
    x <- as.integer(round(e[["x"]], 0L))
    y <- as.integer(round(e[["y"]], 0L))
    list(x = x, y = y)
  }

  ui <- shiny::fluidPage(
    shiny::plotOutput("plot", click = "plot_click"),
    shiny::verbatimTextOutput("info")
  )

  server <- function(input, output, session) {

    mygame <- game(puzzle, print = FALSE)

    output[["plot"]] <- shiny::renderPlot({
      mygame@plot

    })

    output[["info"]] <- shiny::renderText({
      cell_string <- function(e) {
        cell <- find_cell(e, mygame)
        if (is.null(cell)) {
          return("NULL\n")
        }
        paste0(
          "x=", round(cell[["x"]], 2L), "\n",
          "y=", round(cell[["y"]], 2L), "\n",
          "value=", cell_value(mygame, x = cell[["x"]], y = cell[["y"]]), "\n"
        )

      }

      paste0(
        "click:\n", cell_string(input[["plot_click"]])
      )

    })
  }

  shiny::shinyApp(ui, server)
}
