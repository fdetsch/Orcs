if ( !isGeneric("coords2Polygons") ) {
  setGeneric("coords2Polygons", function(coords, ...)
    standardGeneric("coords2Polygons"))
}
#' Convert Points to `SpatialPolygons*`
#'
#' @description
#' Create a `SpatialPolygons*` object from a `Polygon` object or set of point 
#' coordinates in one go, i.e. without being required to run through the single 
#' steps outlined in [sp::SpatialPolygons()].
#'
#' @param coords `Polygon` object or 2-column `numeric` matrix with x and y 
#'   coordinates.
#' @param hole `logical`, see [sp::Polygon()].
#' @param ID `character`, see [sp::Polygons()].
#' @param data `data.frame` with data to add to the output `SpatialPolygons*` 
#'   object (optional).
#' @param match.ID `logical`, see [sp::SpatialPolygonsDataFrame()].
#' @param ... Further arguments passed on to [sp::SpatialPolygons()], i.e. `p0` 
#'   and `proj4string`.
#'
#' @return If 'data' is missing, a `SpatialPolygons` object; else a
#' `SpatialPolygonsDataFrame` object.
#'
#' @examples
#' library(sp)
#'
#' coords1 <- cbind(c(2, 4, 4, 1, 2), c(2, 3, 5, 4, 2))
#' spy1 <- coords2Polygons(coords1, ID = "A")
#'
#' coords2 <- cbind(c(5, 4, 2, 5), c(2, 3, 2, 2))
#' spy2 <- coords2Polygons(coords2, ID = "B")
#'
#' plot(spy1, col = "grey75")
#' plot(spy2, col = "grey25", add = TRUE)
#'
#' @name coords2Polygons
NULL

### matrix method -----
#' @aliases coords2Polygons,matrix-method
#' @rdname coords2Polygons
#' @export
setMethod("coords2Polygons",
          signature(coords = "matrix"),
          function(coords, hole = NA, ID, data, match.ID = TRUE, ...) {

            # convert coordinates matrix to 'Polygon' object
            py <- sp::Polygon(coords, hole)

            coords2Polygons(py, ID = ID, data = data, match.ID = match.ID, ...)
          }
)


### polygon method -----
#' @aliases coords2Polygons,Polygon-method
#' @rdname coords2Polygons
#' @export
setMethod("coords2Polygons",
          signature(coords = "Polygon"),
          function(coords, ID, data, match.ID = TRUE, ...) {

            # convert input 'Polygon' to 'Polygons' object
            pys <- sp::Polygons(list(coords), ID)

            # 'Polygons' to 'SpatialPolygons'
            spy <- sp::SpatialPolygons(list(pys), ...)

            if (!missing(data)) {
              return(sp::SpatialPolygonsDataFrame(spy, data, match.ID))
            } else {
              return(spy)
            }
          }
)
