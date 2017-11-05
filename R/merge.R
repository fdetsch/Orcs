if ( !isGeneric("merge") ) {
  setGeneric("merge", function(x, y, ...)
    standardGeneric("merge"))
}
#' Merge Objects Stored in a List
#' 
#' @description 
#' Complementing existing merge methods, eg \code{\link[raster]{merge}} for 
#' \code{Raster*} objects, which typically work with one or two inputs only, 
#' this function accepts a \code{list} of objects that are to be merged 
#' together.
#' 
#' @param x A \code{list} of objects of the same type (eg \code{Raster*}).
#' @param ... Additional arguments passed to the underlying merge method (eg 
#' arguments compatible with \code{\link[raster]{merge}} and 
#' \code{\link[raster]{writeRaster}} for \code{Raster*} input).
#' 
#' @return 
#' A merged object (eg a new \code{Raster*} object with a larger spatial 
#' extent).
#' 
#' @seealso \code{\link{merge}}, \code{\link{do.call}}.
#' 
#' @author Florian Detsch
#' 
#' @examples
#' ## Raster* input
#' dms = list.files(system.file("extdata", package = "Orcs")
#'                  , pattern = "ASTGTM2.*dem.tif$", full.names = TRUE)
#' dms = lapply(dms, raster)
#' 
#' dem = merge(dms, tolerance = 1e4)                  
#' plot(dem)
#' 
#' @name merge
#' @aliases merge,list-method
NULL

setMethod('merge', signature(x = 'list', y = 'missing'), 
          function(x, ...) {
            
  ## additional arguments
  dots <- list(...)
  args <- append(x, dots)
  
  ## perform merge
  do.call(merge, args)
})
