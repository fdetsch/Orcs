#' Install and Load a Package from GitHub
#' 
#' @description
#' This function comprises multiple steps required to install and load a package
#' directly from GitHub.
#' 
#' @param repo Repository address as `character`, defaults to `"fdetsch/Orcs"`.
#' @param ... Additional arguments passed to [remotes::install_github()].
#' 
#' @author 
#' Florian Detsch
#' 
#' @examples
#' \dontrun{
#' ## install 'Orcs' from GitHub
#' loadFromGit("fdetsch/Orcs")
#' }
#' 
#' @export
loadFromGit <- function(repo = "fdetsch/Orcs", ...) {
  ## install desired package
  remotes::install_github(repo, ...)
  
  ## load package
  ls_pkg <- strsplit(repo, "/")
  ch_pkg <- sapply(ls_pkg, "[[", 2)
  library(ch_pkg, character.only = TRUE)
  
  return(invisible())
}
