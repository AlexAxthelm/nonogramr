# include for collation
#' @include grid.R

game <- S7::new_class("game",
  properties = list(
    solution = grid,
    state = grid,
    solved = S7::new_property(
      getter = function(self) {
        identical(self@solution@cells, self@state@cells)
      }
    )
  ),
  constructor = function(solution) {
    S7::new_object(
      S7::S7_object,
      solution = solution,
      state = grid(width = solution@width, height = solution@height)
    )
  },
  validator = function(self) {
    if (!identical(self@solution@width, self@state@width) ||
        !identical(self@solution@height, self@state@height)) {
      stop("solution and state must have the same dimensions")
    } 
  },
)
