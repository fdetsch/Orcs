#' Return file name without extension
#' 
#' @description
#' As opposed to \code{\link{basename}}, this function returns the pure basename 
#' of a file path, i.e. without extension.
#' 
#' @param path A file name as \code{character}. 
#' @param slash A \code{logical} determining whether to add a leading slash 
#' ("/") to the returned file name.
#' 
#' @return 
#' A file name without extension as \code{character}.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' \code{\link{basename}}, \code{\link{file_path_sans_ext}}.
#' 
#' @examples 
#' fls <- system.file("external/rlogo.grd", package = "raster")
#' pureBasename(fls)
#' pureBasename(fls, slash = TRUE)
#' 
#' @export pureBasename
#' @name pureBasename  
pureBasename <- function(path, slash = FALSE) {
  
  ## extract basename, split and remove extension
  ch_basename <- basename(path)
  ch_split <- unlistStrsplit(ch_basename, "\\.")
  ch_split <- ch_split[-length(ch_split)]
  ch_purebasename <- paste(ch_split, collapse = ".")
  
  ## optionally, add leading slash
  if (slash)
    ch_purebasename <- file.path("", ch_purebasename)
  
  return(ch_purebasename)
}

