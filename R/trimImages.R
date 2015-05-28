#' Remove whitespace from images
#' 
#' @description
#' This is a wrapper function around \code{convert -trim} to automatically 
#' remove any whitespace from locally saved images. Note that 'ImageMagick' must
#' be installed on your local system.
#' 
#' @param path Character. File path leading to image files; defaults to the 
#' current working directory.
#' @param pttrn Character. A regular expression as taken by 
#' \code{\link{list.files}}; defaults to \code{".png$"}.
#' 
#' @return
#' A character vector containing the names of the processed images.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' \code{\link{list.files}}, \code{\link{system}}
#' 
#' @examples
#' ## trim images in current working directory
#' trimImages()
#' 
#' @export trimImages
trimImages <- function(path = ".", pttrn = ".png$") {
  
  ## list files matching specified pattern
  ch_fls <- list.files(path, pattern = pttrn, full.names = TRUE)
  if (length(ch_fls) == 0)
    stop("No files found in ", path, " matching specified pattern.")
    
  ## trim images
  for (i in ch_fls) {
    ch_sysstring <- paste("convert -trim", i, i)
    system(ch_sysstring)
  }
  
  ## return list of processed files
  return(ch_fls)
}