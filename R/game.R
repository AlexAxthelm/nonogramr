# include for collation
#' @include grid.R
#' @include puzzle.R


plot_game <- function(self) {
  if (self@solved) {
    title <- self@puzzle@title
  } else {
    title <- "[Not solved]"
  }
  game_plot <- self@state@plot +
    ggplot2::labs(
      title = title
    )

  logger::log_trace("Adding clues.")
  browser()
  for (clue in self@clues) {
    game_plot <- game_plot +
      ggplot2::annotate(
        geom = "text",
        x = clue$x + 0.5,
        y = clue$y + 0.5,
        label = clue$label,
        size = 10,
        color = "black"
      )
  }

  if (self@solved) {
    logger::log_info("Adding 'Solved!' label.")
    game_plot <- game_plot +
      ggplot2::annotate(
        geom = "label",
        x = (0.5 * self@state@width) + 0.5,
        y = (0.5 * self@state@height) + 0.5,
        label = "Solved!",
        size = 10,
        color = "black"
      )
  } else {
    logger::log_trace("Adding gridlines.")
    game_plot <- game_plot +
      ggplot2::annotate(
        geom = "segment",
        x = seq(0.5, self@state@width + 0.5, by = 1L),
        xend = seq(0.5, self@state@width + 0.5, by = 1L),
        y = 0.5,
        yend = self@state@height + 0.5,
        color = "grey75"
        ) +
      ggplot2::annotate(
        geom = "segment",
        x = 0.5,
        xend = self@state@width + 0.5,
        y = seq(0.5, self@state@height + 0.5, by = 1L),
        yend = seq(0.5, self@state@height + 0.5, by = 1L),
        color = "grey75"
        )
  }

  logger::log_trace("Returning game plot.")
  return(game_plot)
}

game <- S7::new_class("game",
  properties = list(
    puzzle = puzzle,
    state = grid,
    clues = clues,
    solved = S7::new_property(
      getter = function(self) {
        logger::log_trace("Checking state against solution.")
        identical(self@puzzle@solution@cells, self@state@cells)
      }
    ),
    plot = S7::new_property(
      getter = plot_game
    )
  ),
  constructor = function(puzzle) {
    obj <- S7::new_object(
      S7::S7_object(),
      puzzle = puzzle,
      state = grid(
        width = puzzle@solution@width,
        height = puzzle@solution@height
      ),
      clues = puzzle@clues
    )
    print(obj@plot)
    return(obj)
  },
  validator = function(self) {
    if (!identical(self@puzzle@solution@width, self@state@width) ||
          !identical(self@puzzle@solution@height, self@state@height)) {
      stop("solution and state must have the same dimensions")
    }
  }
)

S7::method(mark, game) <- function(z, x, y, color, plot = TRUE) {
  z@state <- mark(z@state, x = x, y = y, color = color)
  if (plot) {
    print(z@plot)
  }
  invisible(z)
}
