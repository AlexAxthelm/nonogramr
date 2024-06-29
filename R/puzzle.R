# include for collation
#' @include grid.R
#' @include clues.R


puzzle <- S7::new_class("puzzle",
  properties = list(
    solution = grid,
    clues = clues,
    puzzle_source = S7::class_character,
    title = S7::class_character,
    author = S7::class_character,
    copyright = S7::class_character,
    license = S7::class_character,
    description = S7::class_character
  )
)
