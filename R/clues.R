clues <- S7::new_class("clues",
  properties = list(
    rows = S7::class_list,
    columns = S7::class_list,
    dimensions = S7::class_integer
  ),
  validator = function(self) {
    if (!setequal(names(self@dimensions), c("rows", "columns"))) {
      stop("dimensions must have names 'rows' and 'columns'")
    } else if (length(self@rows) != self@dimensions[["rows"]]) {
      stop("rows must have length equal to dimensions$rows")
    } else if (length(self@columns) != self@dimensions[["columns"]]) {
      stop("columns must have length equal to dimensions$columns")
    }
  },
  constructor = function(rows, columns, dimensions) {
    log_trace("Constricting clues object.")
    log_trace("Casting rows to list of integers.")
    rows <- lapply(rows, as.integer)
    log_trace("Casting columns to list of integers.")
    columns <- lapply(columns, as.integer)
    if (missing(dimensions)) {
      log_trace("Dimensions not provided, calculating from rows and columns.")
      dimensions <- c(rows = length(rows), columns = length(columns))
    } else {
      log_trace("Casting dimensions to list of integers.")
      dimensions <- lapply(dimensions, as.integer)
    }
    S7::new_object(
      S7::S7_object(),
      rows = rows,
      columns = columns,
      dimensions = dimensions
    )
  }
)
