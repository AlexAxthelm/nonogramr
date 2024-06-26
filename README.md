# nonogramr

R package for importing, solving and vizualizing nonograms.

To get started:

```r
pak::pak("AlexAxthelm/nonogramr")
```

Just see the solution (cheater)

```r
plot(nonogramr::demo_puzzle)
```

## Tips for anyone using {S7}

Since this is an experiment in using S7, I'm marking the mistakes I made here as a warning to others.

This is not a place of honor. No highly esteemed deed is commemorated here.

### Constructors

If you're using constructors, be sure that the first argument to `S7::new_object` is a _call_ to an S7 class _function_.
It should have parentheses.
Seriously, learn from my mistake here.

 You know you've got something wrong if when you instantiate your class, it says "function"

For example:
```r
# This works fine
``` r
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
``` r
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
