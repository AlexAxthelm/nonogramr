grid <- S7::new_class("grid",
  properties = list(
    width = S7::class_integer,
    height = S7::class_integer,
    cells = S7::class_data.frame
  ),
  constructor = function(width, height, cells) {
    log_trace("Casting length and height to integer.")
    width <- as.integer(width)
    height <- as.integer(height)
    log_debug("Creating {width} by {height} grid.")
    if (missing(cells)) {
      log_debug("Filling grid with empty cells.")
      cells <- data.frame(
        x = rep(seq(from = 1L, to = width), times = height),
        y = rep(seq(from = 1L, to = height), each = width),
        color = rep(NA_integer_, times = width * height)
      )
    }
    logger::log_trace("Creating S7 grid object.")
    S7::new_object(
      S7::S7_object(),
      width = width,
      height = height,
      cells = cells
    )
  }
)

plot <- S7::new_generic("plot", "grid")
S7::method(plot, grid) <- function(grid) {
  log_debug("Plotting grid.")
  ggplot2::ggplot(
    data = grid@cells,
    mapping = ggplot2::aes(
      x = .data[["x"]],
      y = .data[["y"]],
      fill = .data[["color"]]
    )
  ) +
    ggplot2::geom_tile(width = 1L, height = 1L) +
    ggplot2::scale_fill_gradient(low = "white", high = "black") +
    ggplot2::theme_void() +
    ggplot2::coord_fixed() +
    ggplot2::geom_vline(
      xintercept = seq(0.5, grid@width + 0.5, by = 1L),
      color = "grey75"
    ) +
    ggplot2::geom_hline(
      yintercept = seq(0.5, grid@height + 0.5, by = 1L),
      color = "grey75"
    ) +
    ggplot2::theme(legend.position = "none")
}

mark <- S7::new_generic("mark", "z")
S7::method(mark, grid) <- function(z, x, y, color) {
  log_debug("Marking cell ({x}, {y}) as {color}.")
  index <- which(z@cells[["x"]] == x & z@cells[["y"]] == y)
  z@cells[["color"]][[index]] <- color
  z
}
