#' Install and load a package from GitHub
#' 
#' @description
#' This function comprises multiple steps required to install and load a 
#' package directly from GitHub.
#' 
#' @param repo Character. Repository address, see \code{\link{install_github}}. 
#' Defaults to "environmentalinformatics-marburg/Rsenal".
#' @param ... Further arguments passed on to \code{\link{install_github}}.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' \code{\link{install_github}}
#' 
#' @examples
#' \dontrun{
#' ## install 'Rsenal' package directly from GitHub
#' loadFromGit()
#' }
#' 
#' @export loadFromGit
loadFromGit <- function(repo = "environmentalinformatics-marburg/Rsenal", ...) {
  ## install desired package
  devtools::install_github(repo, ...)
  
  ## load package
  ls_pkg <- strsplit(repo, "/")
  ch_pkg <- sapply(ls_pkg, "[[", 2)
  library(ch_pkg, character.only = TRUE)
  
  return(invisible())
}