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

demo_puzzle <- grid(3L, 3L, demo_puzzle_cells)

usethis::use_data(demo_puzzle, overwrite = TRUE)
