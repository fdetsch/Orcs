# 2022-12-22 ----

### convert built-in data to `SpatRaster` ----

KiLi = as(KiLi, "SpatRaster")
terra::crs(KiLi) = "EPSG:4326"

terra::writeRaster(KiLi, "inst/extdata/KiLi.tif")
