## default `sf` output
ext = terra::ext(c(25, 70, -5, 30))
spy = ext2spy(ext)

expect_inherits(
  spy
  , class = c("sf", "data.frame")
)

## `SpatVector` output
expect_inherits(
  ext2spy(
    ext
    , as_sf = FALSE
  )
  , class = "SpatVector"
)

## non-`SpatExtent` input
spy1 = ext2spy(
  terra::rast(ext)
)

expect_identical(
  spy1$geometry
  , target = spy$geometry
  , info = "also works with `SpatRaster` input"
)
