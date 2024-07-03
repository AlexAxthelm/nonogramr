# include for collation
#' @include grid.R
#' @include puzzle.R


plot_game <- function(self) {

  logger::log_trace("Getting game state plot.")
  game_plot <- self@state@plot

  if (self@solved) {
    title <- self@puzzle@title
  } else {
    title <- "[Not solved]"

    logger::log_debug("Adding clues to plot.")

    logger::log_trace("Preparing line labels.")
    line_labels_df <- data.frame()
    for (i in seq_along(self@clues@rows)) {
      # Note we're working backwards here
      row_labels <- rev(self@clues@rows[[i]])
      x_pos <- seq(from = 0.25, by = -0.25, length.out = length(row_labels))
      y_pos <- rep(i, length(row_labels))
      line_labels_df <- rbind(
        line_labels_df,
        data.frame(
          x = x_pos,
          y = y_pos,
          label = row_labels
        )
      )
    }
    for (i in seq_along(self@clues@columns)) {
      # Note we're working backwards here
      column_labels <- rev(self@clues@columns[[i]])
      x_pos <- rep(i, length(column_labels))
      y_pos <- seq(from = 0.25, by = -0.25, length.out = length(column_labels))
      line_labels_df <- rbind(
        line_labels_df,
        data.frame(
          x = x_pos,
          y = y_pos,
          label = column_labels
        )
      )
    }

    logger::log_trace("Adding line labels to plot.")
    game_plot <- game_plot +
      ggplot2::geom_text(
        data = line_labels_df,
        mapping = ggplot2::aes(
          x = .data[["x"]],
          y = .data[["y"]],
          label = .data[["label"]],
          fill = NULL
        )
      )
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

    logger::log_trace("Adding coordinate labels.")
    game_plot <- game_plot +
      ggplot2::annotate(
        geom = "text",
        x = self@state@width + 0.75,
        y = seq(1L, self@state@height, by = 1L),
        label = seq(1L, self@state@height, by = 1L),
        color = "grey75"
      )
    game_plot <- game_plot +
      ggplot2::annotate(
        geom = "text",
        x = seq(1L, self@state@width, by = 1L),
        y = self@state@height + 0.75,
        label = seq(1L, self@state@width, by = 1L),
        color = "grey75"
      )

  }

  logger::log_trace("Adding puzzle metadata to plot.")
  game_plot <- game_plot +
    ggplot2::labs(
      title = title,
      subtitle = paste("By", self@puzzle@author),
      caption = paste(
        "Source:", self@puzzle@puzzle_source, "/",
        "Copyright:", self@puzzle@copyright, "/",
        "License:", self@puzzle@license
      )
    ) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", hjust = 0.5),
      plot.subtitle = ggplot2::element_text(face = "italic", hjust = 0.5),
      plot.caption = ggplot2::element_text(
        margin = ggplot2::margin(
          t = 2L,
          r = 2L,
          b = 2L,
          l = 2L
        )
      )
    )

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
  constructor = function(puzzle, print = TRUE) {
    obj <- S7::new_object(
      S7::S7_object(),
      puzzle = puzzle,
      state = grid(
        width = puzzle@solution@width,
        height = puzzle@solution@height
      ),
      clues = puzzle@clues
    )
    if (print) {
      logger::log_trace("Printing game plot from constructor.")
      print(obj@plot)
    }
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

S7::method(cell_value, game) <- function(z, x, y) {
  logger::log_trace("Getting cell value.")
  cell_value(z@state, x = x, y = y)
}
