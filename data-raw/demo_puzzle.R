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
  rows = list(3, 1, 1),
  columns = list(1, c(1,1), 2)
)



demo_puzzle <- puzzle(
  solution = grid(3, 3, cells = demo_puzzle_cells),
  clues = demo_clues,
  puzzle_source = "nonogramr package",
  title = "Glider",
  author = "Alex Axthelm",
  copyright = "Richard Guy",
  license = "MIT",
  description = "Glider from Conway's Game of Life"
)

usethis::use_data(demo_puzzle, overwrite = TRUE)
