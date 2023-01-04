if ( !isGeneric("merge") ) {
  setGeneric("merge", function(x, y, ...)
    standardGeneric("merge"))
}
#' Merge Objects Stored in a List
#' 
#' @description 
#' Complementing existing merge methods, e.g. [terra::merge()] for `Spat*` 
#' objects, which typically work with one or two inputs only, this function 
#' accepts a `list` of objects that are to be merged together.
#' 
#' @param x A `list` of objects of the same type (e.g. `Spat*` or `data.frame`).
#' @param by,all See [merge.data.frame()]. Ignored if data stored in 'x' is not 
#'   of class `data.frame`.
#' @param ... Additional arguments passed to the underlying merge method (e.g. 
#'   arguments compatible with [terra::merge()] and [terra::writeRaster()] for
#'   `Spat*` input). Ignored if data stored in 'x' is of class `data.frame`.
#' 
#' @return 
#' A merged object (e.g. a new `Spat*` object with a larger spatial extent).
#' 
#' @seealso [do.call()], [Reduce()].
#' 
#' @author Florian Detsch
#' 
#' @examples
#' ## `SpatRaster` input
#' dms = list.files(system.file("extdata", package = "Orcs")
#'                  , pattern = "ASTGTM2.*dem.tif$", full.names = TRUE)
#' dms = lapply(dms, terra::rast)
#' 
#' dem = merge(dms[3:4])
#' terra::plot(dem)
#' 
#' ## data.frame input
#' mrg = merge(list(iris, iris, iris)
#'             , by = c("Species", "Sepal.Length", "Petal.Width"))
#' head(mrg)
#' 
#' @export
#' @docType methods
#' @name merge
#' @rdname merge-methods
#' @aliases merge,list,missing-method
setMethod('merge', signature(x = 'list', y = 'missing'), 
          function(x, by = 1L, all = TRUE, ...) {
            
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
    
    # # if 'by' is specified and character, reorder data.frames (Reduce() call 
    # # cannot find character column names for reasons unknown)
    # if ("by" %in% names(dots)) {
    #   if (inherits(dots$by, "character")) {
    #     ids = sapply(x, function(i) grep(dots$by, names(i)))
    #     for (i in 1:length(x)) {
    #       x[[i]] = x[[i]][, c(ids[i], (tmp <- 1:ncol(x[[i]]))[!tmp == ids[i]])]
    #     }
    #     dots$by = 1L
    #   }
    # }
    
    Reduce(function(...) merge(..., by = by, all = all), x)
  } else {
    do.call(merge, args)
  }
})

