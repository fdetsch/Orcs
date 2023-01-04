library(tinytest)
library(checkmate)
using("checkmate")

b = terra::rast(
  system.file(
    "ex/logo.tif"
    , package = "terra"
  )
)

lout = rgb2spLayout(b)

expect_list(
  lout
  , types = c("character", "ggmap", "numeric", "logical")
  , any.missing = FALSE
  , len = 8L
  , unique = TRUE
)

expect_names(
  names(lout)[nzchar(names(lout))]
  , identical.to = c("x", "y", "width", "height", "default.units", "first")
)
