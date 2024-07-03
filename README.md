# nonogramr

R package for nonograms (also called griddlers, hanjie, and picross).

## Installation

Installing the package is as easy as:

```r
pak::pak("AlexAxthelm/nonogramr")
```

## Usage Demonstration

```r
mygame <- game(demo_puzzle)

# Specify color = 1 for black cells, and 0 for white cells
# Marking multiple cells in a line is possible by specifying a vector
mygame <- mark(mygame, x = c(1:3), y = 1L, color = 1L)

mygame <- mark(mygame, x = c(1:2), y = 2L, color = 0)
mygame <- mark(mygame, 2, 3, 1)
mygame <- mark(mygame, 3, 2, 1)
mygame <- mark(mygame, c(1, 3), 3, 0)
```

## Important Classes

Note that there is no class- or function-level documentation at the moment.

### `puzzle`

`puzzle` is the definition of an individual nonogram puzzle.
Namely, it defines the solution, clues, and metadata, such as author and license.
See the `data-raw/` directory for examples of puzzles being constructed.

### `game`

The `game` class provides a mechanism for interacting with a puzzle.
upon creating a new `game` object (with `mygame <- game(demo_puzzle)`), a `ggplot2` representation of the game state is rendered on the default graphics device.
The game state can be updated using the `mark()` method, which will render a new plot and present it to the user
Note that when `mark`ing a game, you must include a reassignment to the object:

```r
# this works
mygame <- mark(mygame, 1, 2, 3) 

# this will plot the update, but the update will be lost at the next action.
mark(mygame, 1, 2, 3) 
```

### `grid`

Note that `nonogramr` uses a `data.frame` to store the cells in a given grid (both for solutions and for game state).
This is in contrast to most other nonogram applications, which either do not store solutions, or store them as strings.

Important for puzzle creators, `nonogramr`'s coordinate system is a traditional x-y axis system (moving out from the bottom left corner of the grid), while most other systems use a "reading order" definition, with the first row being the top row, and working down from there.

## Motivation

As someone whose day job involves a lot of programming in R, and whose hobbies include nonograms, this is a natural synthesis of the two.

Beyond that, this is as much as anything else my experiment in working with the [`S7` OOP system](https://github.com/RConsortium/S7).

### Tips for anyone using `S7`

Since this is an experiment in using S7, I'm marking the mistakes I made here as a warning to others.

This is not a place of honor. No highly esteemed deed is commemorated here.

#### Constructors

If you're using constructors, be sure that the first argument to `S7::new_object` is a _call_ to an S7 class _function_.
It should have parentheses.
Seriously, learn from my mistake here.

 You know you've got something wrong if when you instantiate your class, it says "function"

For example:

```r
# This works fine
foo <- S7::new_class("foo",
  properties = list(
    bar = S7::class_integer
  ),
  constructor = function(x) {
    x <- as.integer(x)
    S7::new_object(
      S7::S7_object(), # <-- Note those parens. they're beautiful.
      bar = x
    )
  }
)

foo(5)
#> <foo> # <-- This is what it's supposed to look like.
#>  @ bar: int 5
```

But note what it looks like if you omit the parens:

```r
# This will give you a couple hours of headaches.
badfoo <- S7::new_class("badfoo",
  properties = list(
    bar = S7::class_integer
  ),
  constructor = function(x) {
    x <- as.integer(x)
    S7::new_object(
      S7::S7_object, # <-- No parens here. Problems inbound
      bar = x
    )
  }
)
badfoo(5)
#> <badfoo> function () # <-- You see the function() here? That's trouble
#>  @ bar: int 5
```

### Collation

When defining classes, you need to make sure that class that is used in the definition of another is loaded by the package before the one that calls it.

For example if you have

```r
# ingredient.R
ingredient <- S7::new_class("ingredient",
  properties = list(
    name = S7::class_character
  )
)
```

and

```r
# cocktail.R
cocktail <- S7::new_class("cocktail",
  properties = list(
    ingredient = ingredient
  )
)
```

Then by default this will fail when loading:

```txt
Error in `load_all()`:
! Failed to load R/cocktail.R
Caused by error:
! object 'ingredient' not found
```

This is because loading the package in alphabetical order is not appropriate here (`I` comes before `C`).
This can be resolved by adding the `Collate` field to description, or more easily, specifying the internal dependencies using the `@include` directive in file-level documentation:

```r
# cocktail.R
#' @include puzzle.R

cocktail <- S7::new_class("cocktail",
  properties = list(
    ingredient = ingredient
  )
)
```

## TODO

- [ ] Importing
  - [ ] `.non` files
  - [ ] webpbn files
- [ ] Vizualizing
  - [X] Plotting
  - [ ] Shiny App?
- [ ] Solving
  - [ ] Line Solving
- [ ] Tracking Game State
