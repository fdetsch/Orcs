#' Set working directory dependent on current OS
#' 
#' @description
#' Similar to \code{\link{setwd}}, this function sets the working directory to a
#' user-defined path. Rather than supplying a single \code{dir} argument, 
#' however, both an OS-sensitive path to the desired hard disk partition and, 
#' optionally, an extension of this file path are required.  
#' 
#' @param lin Character. Absolute file path to the Linux partition.
#' @param win Character. Absolute file path to the Windows partition.
#' @param ext Character. Optional file path extension that will be added to
#' either \code{lin} or \code{win} after OS determination.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' \code{\link{setwd}}, \code{\link{switch}}
#' 
#' @examples
#' \dontrun{
#' # desired partition
#' setwdOS()
#' 
#' # including file path extension
#' setwdOS(ext = "kilimanjaro/nubiscope")
#' }
#' 
#' @export setwdOS
#' @name setwdOS
setwdOS <- function(lin = "/media/permanent/", 
                    win = "D:/", 
                    ext = NULL) {
  
  ## determine os
  ch_dir_os <- switch(Sys.info()[["sysname"]], 
                      "Linux" = lin, 
                      "Windows" = win)
  
  ## setwd
  if (is.null(ext))
    setwd(ch_dir_os)
  else 
    setwd(paste(ch_dir_os, ext, sep = "/"))
  
  return(invisible())
}