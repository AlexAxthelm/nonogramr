grid <- S7::new_class("grid",
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
        color = rep(NA_integer_, times = width * height)
      )
    }
    new_object(S7_object, width = width, height = height, cells = cells)
  }
)
