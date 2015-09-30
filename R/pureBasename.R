#' Return filename without extension
#' 
#' @description
#' As opposed to \code{\link{basename}}, this function returns the pure basename 
#' of a file path, i.e. without extension.
#' 
#' @param path Filename; see \code{\link{basename}}. 
#' @param slash If \code{TRUE}, a leading slash ("/") is added to the returned 
#' filename.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' \code{\link{basename}}
#' 
#' @examples 
#' ch_file <- "path/to/file.with.extension"
#' pureBasename(ch_file)
#' pureBasename(ch_file, slash = TRUE)
#' 
#' @export pureBasename
pureBasename <- function(path, slash = FALSE) {
  
  ## extract basename, split and remove extension
  ch_basename <- basename(path)
  ch_split <- unlistStrsplit(ch_basename, "\\.")
  ch_split <- ch_split[-length(ch_split)]
  ch_purebasename <- paste(ch_split, collapse = ".")
  
  ## optionally, add leading slash
  if (slash)
    ch_purebasename <- paste0("/", ch_purebasename)
  
  return(ch_purebasename)
}

