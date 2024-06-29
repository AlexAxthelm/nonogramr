# nolint start
# Testing puzzle
# 9x5 grid
# For testing clue labels, and empty row/columns
# Hacker glider (game of life)
# Should render as:
#
# X X XXX X 
# X X  X  X
# XXX  X  X
# X X  X   
# X X XXX X
#
# Where X is filled and . is a space
# nolint end

puzzle_cells <- data.frame(
  x = rep(1L:9L, 5L),
  y = rep(1L:5L, each = 9L),
  color = c(
    c(1L, 0L, 1L, 0L, 1L, 1L, 1L, 0L, 1L),
    c(1L, 0L, 1L, 0L, 0L, 1L, 0L, 0L, 0L),
    c(1L, 1L, 1L, 0L, 0L, 1L, 0L, 0L, 1L),
    c(1L, 0L, 1L, 0L, 0L, 1L, 0L, 0L, 1L),
    c(1L, 0L, 1L, 0L, 1L, 1L, 1L, 0L, 1L)
  )
)

puzzle_clues <- clues(
  rows = list(
    c(1L, 1L, 3L, 1L),
    c(1L, 1L, 1L),
    c(3L, 1L, 1L),
    c(1L, 1L, 1L, 1L),
    c(1L, 1L, 3L, 1L)
  ),
  columns = list(
    5L,
    1L,
    5L,
    0L,
    c(1L, 1L),
    5L,
    c(1L, 1L),
    0L,
    c(1L, 3L)
  )
)

hi_puzzle <- puzzle(
  solution = grid(
    width = 9L,
    height = 5L,
    cells = puzzle_cells
  ),
  clues = puzzle_clues,
  puzzle_source = "nonogramr package",
  title = "HI!",
  author = "Alex Axthelm",
  copyright = "Alex Axthelm, 2024",
  license = "MIT",
  description = "Text saying 'HI!"
)

usethis::use_data(hi_puzzle, overwrite = TRUE)
