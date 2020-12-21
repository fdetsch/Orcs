#' Extend Method for \strong{sf} Objects
#' 
#' @description 
#' Extend simple feature bounding analogous to \strong{raster} 
#' \code{\link[raster]{extend}} method.
#' 
#' @param x A \strong{sf} object.
#' @param ... Arguments passed to \code{\link[sf]{st_buffer}}
#' 
#' @return See \code{\link[sf]{st_bbox}}.
#' 
#' @examples 
#' \dontrun{
#' data(KiLi)
#' 
#' strs = stars::st_as_stars(KiLi)
#' 
#' ## extend by .05 deg
#' xtd = st_extend(
#'   strs
#'   , dist = 0.05
#' )
#' 
#' ## view on map
#' mapview::viewRGB(as(strs, "Raster"), r = 1, b = 3, quantiles = c(0, 1)) + xtd
#' }
#' 
#' @export
#' @name st_extend
st_extend = function(x, ...) {
  sf::st_bbox(
    sf::st_buffer(
      sf::st_as_sfc(
        sf::st_bbox(x)
      )
      , ...
    )
  )
}