#' Convert between DOS and UNIX line endings
#' 
#' @description
#' This function converts between DOS and UNIX style line endings by envoking 
#' \code{unix2dos} (or \code{dos2unix}) upon a text file (see also 
#' \code{system("unix2dos --help")}). Note that this function requires the 
#' installation of external software in order to work!
#' 
#' @param infile Input filename(s). 
#' @param pattern See \code{\link{list.files}}. This will be ignored if 'infile' 
#' is specified.
#' @param outfile Output filename. If not supplied, 'infile' will be 
#' overwritten.
#' @param to Either 'dos' or 'unix'.
#' @param ... Further arguments passed on to \code{\link{list.files}}, e.g. 
#' 'path', 'full.names'.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso 
#' \code{\link{list.files}}, \code{\link{system}}
#' 
#' @examples
#' ## input file
#' infile <- paste(system.file(package = "Orcs"), "DESCRIPTION", sep = "/")
#' 
#' ## convert to dos line endings and write to output file
#' lineEnding(infile, outfile = "~/Desktop/DESCRIPTION4wd", to = "dos")
#' 
#' @export lineEnding
lineEnding <- function(infile, pattern = NULL, outfile = NULL, 
                       to = c("dos", "unix"), ...) {

  ## if not specified, convert to dos format
  to <- to[1]
  
  ## if not supplied, only files matching a given pattern are processed
  if (missing(infile))
    infile <- list.files(pattern = pattern, ...)
  
  ## overwrite infile or...
  if (is.null(outfile)) {
    ch_ext <- infile
    
    ## ...write to newfile  
  } else {
    ch_ext <- paste("-n", infile, outfile)
  }
  
  ## conversion to dos format or...
  if (to == "dos") {
    ch_sys <- paste("unix2dos", ch_ext)
  
  ## ...conversion to unix format    
  } else {
    ch_sys <- paste("dos2unix", ch_ext)
  }
  
  ## execute conversion
  for (i in ch_sys)
    system(i)

  return(invisible())
}
