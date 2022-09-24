#' Load Multiple Packages
#' 
#' @description
#' Load and attach multiple packages at once.
#' 
#' @param pkgs Packages to load as `character`. 
#' @param ... Additional arguments passed to [library()], except for 
#'   'character.only' which is set to `TRUE`.
#' 
#' @author 
#' Florian Detsch
#' 
#' @note 
#' Package start-up messages are automatically disabled.
#' 
#' @examples
#' loadPkgs(c("raster", "rgdal"))
#' 
#' @export
loadPkgs <- function(pkgs, ...) {
  
  ## if 'character.only' has been specified, remove it from '...'
  dots = list(...)
  if ("character.only" %in% names(dots)) {
    dots = dots[-grep("character.only", names(dots))]
  }
  
  jnk = sapply(pkgs, function(x) {
    dots_sub = append(list(package = x, character.only = TRUE), dots)
    suppressPackageStartupMessages(
      do.call(library, args = dots_sub)
    )
  })

  return(invisible())  
}
