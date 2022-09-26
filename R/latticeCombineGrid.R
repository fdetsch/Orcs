#' Combine Multiple Lattice Plots in a Faceted Grid (Panels)
#' 
#' @description
#' This function combines multiple **lattice** plot objects in a faceted grid. 
#' Note that the global plot settings (e.g. 'xlim', 'ylim', ...) are taken from 
#' the first object though the user can specify whether 'scales' should be 
#' identical or not. This is particularly useful when looping over large amounts
#' of data using [lapply()] (see Examples).
#' 
#' @param trellis.list A `list` containing **lattice** plot objects.
#' @param between Space between panels.
#' @param as.table If `TRUE` (default), drawing is top left to bottom right.
#' @param ... Additional arguments passed to [latticeExtra::c.trellis()].
#' 
#' @return
#' A single **lattice** plot object.
#' 
#' @author
#' Tim Appelhans
#' 
#' @seealso
#' [latticeExtra::c.trellis()].
#' 
#' @examples
#' #load data
#' #Use a probability map assuming high potential for city expansion is just 
#' #resulting from proximity to current urban area:
#' pred <- raster(system.file("extdata/probability.rst", package = "Orcs"))
#' 
#' #observed city growth between 1990 and 2006
#' obs <- raster(system.file("extdata/citygrowth.tif", package = "Orcs"))
#' 
#' #masking current urban area since these pixels have no potential for change
#' mask <- raster(system.file("extdata/citymask.tif", package = "Orcs"))
#' 
#' #create data list
#' dat <- list(pred, obs, mask)
#' 
#' #create list of lattice plots
#' plist <- lapply(seq(dat), function(i) {
#'   spplot(dat[[i]], scales = list(draw = TRUE))
#' })
#' 
#' \donttest{
#' #draw individually
#' plist[[1]]
#' plist[[2]]
#' plist[[3]]
#' }
#' 
#' #combine to grid, using c(1, 3) layout
#' p <- latticeCombineGrid(plist, layout = c(1, 3))
#' print(p)
#' 
#' @export
latticeCombineGrid <- function(trellis.list,
                               between = list(y = 0.3, x = 0.3),
                               as.table = TRUE,
                               ...) {
  stopifnot(
    requireNamespace("lattice"),
    requireNamespace("latticeExtra")
  )
  
  ## combine plot objects
  outLayout <- function(x, y, ...) {
    update(c(x, y, ...), between = between, as.table = as.table)
  }
  
  out <- suppressWarnings(Reduce(outLayout, trellis.list))
  
  ## apply additional customizations
  dots = list(...)
  if (length(dots) > 0) {
    out <- do.call(update, args = append(list(object = out), dots))
  }
  
  return(out)
}
