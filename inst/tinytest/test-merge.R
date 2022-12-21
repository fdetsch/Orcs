### `SpatRaster` input ----

dms = list.files(
  system.file(
    "extdata"
    , package = "Orcs"
  )
  , pattern = "ASTGTM2.*dem.tif$"
  , full.names = TRUE
)

dms = lapply(
  dms
  , terra::rast
)

for (i in 1:3) {
  dms[[i]] = terra::resample(
    dms[[i]]
    , dms[[4]]
  )
}

mrg = merge(dms)

expect_inherits(
  mrg
  , "SpatRaster"
)
