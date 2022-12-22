#' Convert Spatial Extent to Polygon
#' 
#' @description 
#' Convert a spatial extent to polygons.
#' 
#' @param x A `SpatExtent` object, or any object from which such an object can 
#'   be extracted, e.g. `SpatRaster`.
#' @param crs Coordinate reference system set via [terra::crs()].
#' @param as_sf `logical`. If `TRUE` (default), the returned object is of class 
#'   `sf` rather than `Spatial*`.
#' 
#' @return Depending on 'as_sf', either a `c(sf, data.frame)` or `SpatVector` 
#'   object.
#' 
#' @author Florian Detsch
#' 
#' @seealso [terra::ext()].
#' 
#' @examples 
#' ext = terra::ext(c(25, 70, -5, 30))
#' ext2spy(ext) # 'sf' (default)
#' ext2spy(ext, as_sf = FALSE) # 'Spatial*'
#' 
#' @importFrom sf st_as_sf
#' @importFrom terra as.polygons crs ext
#' 
#' @export
ext2spy = function(x, crs = "EPSG:4326", as_sf = TRUE) {
  
  if (!inherits(x, "SpatExtent")) {
    x = terra::ext(x)
  }
  
  spy = terra::as.polygons(x)
  terra::crs(spy) = crs
  
  if (as_sf) {
    spy = sf::st_as_sf(spy)
  }
  
  return(spy)
}
