# Orcs 1.2.2.9001 (2022-12-20)

#### ✨ features and improvements

#### 🐛 bug fixes

#### 💬 documentation etc

  * `KiLi` built-in data is no longer available as `SpatRaster` objects do not 
    work with `save()` (see <https://github.com/rspatial/terra/issues/549>); use
    `terra::rast(system.file("extdata/KiLi.tif", package = "Orcs"))` instead.

#### 🍬 miscellaneous

  * Eliminates **rgdal** dependency (#9)
  * Replaces **raster** related code and objects with **terra** analogs


# Orcs 1.2.2 (2022-09-26)

#### 🍬 miscellaneous

  * Knocks package into shape (#7)

## Orcs 1.2.0

New features:

  * Moved coords2Lines(), coords2Polygons() from package 'mapview'.
  * substrC() as C++ version of base-R substr().

## Orcs 1.1.1

Changes:

  * Replaced devtools::install_github() with remotes::install_github().
