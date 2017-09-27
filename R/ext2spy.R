#' Convert Spatial Extent to Polygon
#' 
#' @description 
#' Convert a spatial extent to polygons.
#' 
#' @param x An \code{Extent} object, or any object from which an \code{Extent} 
#' can be extracted, eg. \code{Raster*}.
#' @param crs Coordinate reference system passed to \code{\link{proj4string}}.
#' 
#' @return A \code{SpatialPolygons} object.
#' 
#' @author Florian Detsch
#' 
#' @seealso \code{\link{extent}}.
#' 
#' @examples 
#' ext = extent(c(25, 70, -5, 30))
#'
#' @export ext2spy
#' @name ext2spy 
ext2spy = function(x, crs = "+init=epsg:4326") {
  if (!inherits(x, "Extent"))
    x = raster::extent(x)
    
  spy = as(x, "SpatialPolygons")
  sp::proj4string(spy) = crs
  
  return(spy)
}