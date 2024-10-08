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

demo_puzzle_cells <- data.frame(
  x = rep(1L:3L, 3L),
  y = rep(1L:3L, each = 3L),
  color = c(
    c(1L, 1L, 1L),
    c(0L, 0L, 1L),
    c(0L, 1L, 0L)
  )
)

demo_clues <- clues(
  rows = list(3L, 1L, 1L),
  columns = list(1L, c(1L, 1L), 2L)
)

demo_puzzle <- puzzle(
  solution = grid(3L, 3L, cells = demo_puzzle_cells),
  clues = demo_clues,
  puzzle_source = "nonogramr package",
  title = "Glider",
  author = "Alex Axthelm (original by Richard Guy)",
  copyright = "Alex Axthelm, 2024, Richard Guy 1969",
  license = "MIT",
  description = "Glider from Conway's Game of Life"
)

usethis::use_data(demo_puzzle, overwrite = TRUE)
