#' Load multiple packages 
#' 
#' @description
#' Being a wrapper around \code{\link{library}}, this function allows you to 
#' load and attach multiple packages at once.
#' 
#' @param pkgs 'character'. Packages to load. 
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso 
#' \code{\link{library}}.
#' 
#' @examples
#' loadPkgs(c("raster", "rgdal"))
#' 
#' @export loadPkgs
#' @name loadPkgs
loadPkgs <- function(pkgs) {
  
  sapply(pkgs, function(x) {
    suppressPackageStartupMessages(
      library(x, character.only = TRUE)
    )
  })

  return(invisible())  
}