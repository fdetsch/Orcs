if ( !isGeneric("coords2Lines") ) {
  setGeneric("coords2Lines", function(coords, ...)
    standardGeneric("coords2Lines"))
}
#' Convert Points to `SpatialLines*`
#'
#' @description
#' Create a `SpatialLines*` object from a `Line` object or set of point 
#' coordinates in one go, i.e. without being required to run through the single 
#' steps outlined in [sp::SpatialLines()].
#'
#' @param coords `Line` object or 2-column `numeric` `matrix` with x and y 
#'   coordinates.
#' @param ID `character`, see [sp::Lines()].
#' @param data `data.frame` with data to add to the output `SpatialLines*` 
#'   object (optional).
#' @param match.ID `logical`, see [sp::SpatialLinesDataFrame()].
#' @param ... Further arguments passed on to [sp::SpatialLines()], i.e. 
#'   `proj4string`.
#'
#' @return If 'data' is missing, a `SpatialLines` object; else a
#' `SpatialLinesDataFrame` object.
#'
#' @examples
#' library(sp)
#'
#' coords1 <- cbind(c(2, 4, 4, 1, 2), c(2, 3, 5, 4, 2))
#' sln1 <- coords2Lines(coords1, ID = "A")
#'
#' coords2 <- cbind(c(5, 4, 2, 5), c(2, 3, 2, 2))
#' sln2 <- coords2Lines(coords2, ID = "B")
#'
#' plot(sln1, col = "grey75")
#' plot(sln2, col = "grey25", add = TRUE)
#'
#' @name coords2Lines
NULL

### matrix method -----
#' @aliases coords2Lines,matrix-method
#' @rdname coords2Lines
#' @export
setMethod("coords2Lines",
          signature(coords = "matrix"),
          function(coords, ID, data, match.ID = TRUE, ...) {

            # convert coordinates matrix to 'Line' object
            ln <- sp::Line(coords)

            # pass object on to 'Line'-method
            coords2Lines(ln, ID, data, match.ID, ...)
          }
)


### Line method -----
#' @aliases coords2Lines,Line-method
#' @rdname coords2Lines
#' @export
setMethod("coords2Lines",
          signature(coords = "Line"),
          function(coords, ID, data, match.ID = TRUE, ...) {

            # convert 'Line' to 'Lines' object
            lns <- sp::Lines(list(coords), ID)

            # 'Lines' to 'SpatialLines'
            sln <- sp::SpatialLines(list(lns), ...)

            if (!missing(data)) {
              return(sp::SpatialLinesDataFrame(sln, data, match.ID))
            } else {
              return(sln)
            }
          }
)
