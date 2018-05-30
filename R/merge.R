if ( !isGeneric("merge") ) {
  setGeneric("merge", function(x, y, ...)
    standardGeneric("merge"))
}
#' Merge Objects Stored in a List
#' 
#' @description 
#' Complementing existing merge methods, e.g. \code{\link[raster]{merge}} for 
#' \code{Raster*} objects, which typically work with one or two inputs only, 
#' this function accepts a \code{list} of objects that are to be merged 
#' together.
#' 
#' @param x A \code{list} of objects of the same type (e.g. \code{Raster*} or 
#' \code{data.frame}).
#' @param ... Additional arguments passed to the underlying merge method (e.g. 
#' arguments compatible with \code{\link[raster]{merge}} and 
#' \code{\link[raster]{writeRaster}} for \code{Raster*} input).
#' 
#' @return 
#' A merged object (e.g. a new \code{Raster*} object with a larger spatial 
#' extent).
#' 
#' @seealso \code{\link{merge}}, \code{\link{do.call}}, \code{\link{Reduce}}.
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
#' ## data.frame input
#' mrg = merge(list(iris, iris, iris)
#'             , by = c("Species", "Sepal.Length", "Petal.Width"))
#' head(mrg)
#' 
#' @name merge
#' @aliases merge,list-method
NULL

setMethod('merge', signature(x = 'list', y = 'missing'), 
          function(x, ...) {
            
  ## additional arguments
  dots <- list(...)
  args <- append(x, dots)
  
  ## check list validity
  cls = sapply(x, class)
  if (length(unq <- unique(cls)) > 1) {
    stop("Not all list elements have the same class.")
  }
  
  ## perform merge
  if (unq == "data.frame") {
    Reduce(function(...) merge(..., unlist(dots)), x)
  } else {
    do.call(merge, args)
  }
})

