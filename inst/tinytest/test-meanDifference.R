### `numeric` ----

x = 1:10
y = 2:11

expect_identical(
  meanDifference(x, y)
  , target = -1
)

expect_warning(
  meanDifference(x, y[1:9])
  , pattern = "Elements 'x' and 'y' are of unequal length"
)


### `SpatRaster` ----

r = terra::rast(
  system.file(
    "ex/logo.tif"
    , package = "terra"
  )
)

expect_inherits(
  meanDifference(
    r[[1]]
    , r[[2]]
  )
  , class = "numeric"
)

## early exit: multi-layered input(s)
expect_error(
  meanDifference(
    r[[1:2]]
    , r[[3]]
  )
  , pattern = "Cannot calculate the mean difference for multi-layered rasters"
)

## warning: inputs of unequal lengths
r1 = terra::rast(
  system.file(
    "ex/meuse.tif"
    , package = "terra"
  )
)

expect_warning(
  meanDifference(
    r[[1]]
    , r1
  )
  , pattern = "Elements 'x' and 'y' have unequal number of cells"
)
