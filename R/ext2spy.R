#' Convert Spatial Extent to Polygon
#' 
#' @description 
#' Convert a spatial extent to polygons.
#' 
#' @param x An `Extent` object, or any object from which an `Extent` can be 
#'   extracted, e.g. `Raster*`.
#' @param crs Coordinate reference system passed to [sp::proj4string()].
#' @param as_sf `logical`. If `TRUE` (default), the returned object is of class 
#'   `sf` rather than `Spatial*`.
#' 
#' @return Depending on 'as_sf', either a `sf` or `SpatialPolygons` object.
#' 
#' @author Florian Detsch
#' 
#' @seealso [raster::extent()].
#' 
#' @examples 
#' ext = extent(c(25, 70, -5, 30))
#' ext2spy(ext) # 'sf' (default)
#' ext2spy(ext, as_sf = FALSE) # 'Spatial*'
#'
#' @export
ext2spy = function(x, crs = "+init=epsg:4326", as_sf = TRUE) {
  if (!inherits(x, "Extent"))
    x = raster::extent(x)
    
  spy = as(x, "SpatialPolygons")
  sp::proj4string(spy) = crs
  
  if (as_sf) {
    spy = sf::st_as_sf(spy)
  }
  
  return(spy)
}
