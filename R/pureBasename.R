#' Return File Name without Extension
#' 
#' @description
#' As opposed to [basename()], this function returns the pure basename of one or
#' multiple file names, i.e. without extension.
#' 
#' @param path File name(s) as `character`. 
#' @param slash A `logical` determining whether to add a leading slash (`"/"`) 
#' to the returned file name.
#' 
#' @return 
#' File name(s) without extension as `character`.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' [tools::file_path_sans_ext()].
#' 
#' @examples
#' ifl = tempfile(fileext = ".tif")
#' pureBasename(ifl)
#' pureBasename(ifl, slash = TRUE)
#' 
#' @export
pureBasename <- function(path, slash = FALSE) {
  
  ## extract basename, split and remove extension
  ch_purebasename = sapply(path, function(i) {
    ch_basename <- basename(i)
    ch_split <- unlistStrsplit(ch_basename, "\\.")
    ch_split = ifelse((len <- length(ch_split)) > 1, ch_split[-len], ch_split)
    paste(ch_split, collapse = ".")
  })
  
  ## optionally, add leading slash
  if (slash) {
    ch_purebasename = file.path("", ch_purebasename)
  }
  
  return(as.character(ch_purebasename))
}
