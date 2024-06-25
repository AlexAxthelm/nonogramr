# Testing puzzle
# 3x3 grid
# Hacker glider (game of life)
# Should render as:
#
# .X.
# ..X
# XXX
#
# Where X is filled and . is a space

testing_grid <- data.frame(
  x = rep(1L:3L, 3L),
  y = rep(1L:3L, each = 3L),
  color = c(
    c(1L, 1L, 1L),
    c(0L, 0L, 1L),
    c(0L, 1L, 0L)
  )
)

ggplot2::ggplot(
  data = testing_grid,
  mapping = ggplot2::aes(
    x = x,
    y = y,
    fill = color
    )
  ) +
  ggplot2::geom_tile(width = 1L, height = 1L) +
  ggplot2::scale_fill_gradient(low = "white", high = "black") +
  ggplot2::theme_void() +
  ggplot2::coord_fixed() +
  ggplot2::theme(legend.position = "none")

library(S7) #nolint

grid <- new_class("grid",
  properties = list(
    width = class_integer,
    height = class_integer,
    cells = class_data.frame
  ),
  constructor = function(width, height, cells) {
    if (missing(cells)) {
      cells <- data.frame(
        x = rep(seq(from = 1L, to = width), times = height),
        y = rep(seq(from = 1L, to = height), each = width),
        color = rep(as.integer(NA), times = width * height)
      )
    }
    new_object(S7_object, width = width, height = height, cells = cells)
  }
)


empty_grid <- grid(3L, 3L)

testing_grid_s7 <- grid(3L, 3L, testing_grid)

plot <- new_generic("plot", "grid")
method(plot, grid) <- function(grid){
  ggplot2::ggplot(
    data = grid@cells,
    mapping = ggplot2::aes(
      x = x,
      y = y,
      fill = color
    )
  ) +
    ggplot2::geom_tile(width = 1L, height = 1L) +
    ggplot2::scale_fill_gradient(low = "white", high = "black") +
    ggplot2::theme_void() +
    ggplot2::coord_fixed() +
    ggplot2::geom_vline(
      xintercept = seq(0.5, grid@width + 0.5, by = 1),
      color = "grey75"
      ) +
    ggplot2::geom_hline(
      yintercept = seq(0.5, grid@height + 0.5, by = 1),
      color = "grey75"
      ) +
    ggplot2::theme(legend.position = "none")
}

plot(empty_grid)

plot(testing_grid_s7)


