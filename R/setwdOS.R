#' Set working directory dependent on current OS
#' 
#' @description
#' Similar to \code{\link{setwd}}, this function sets the working directory to a
#' user-defined path. Rather than supplying a single \code{dir} argument, 
#' however, both an OS-sensitive path to the desired hard disk partition and, 
#' optionally, an extension of this file path are required.  
#' 
#' @param path_lin Character. Absolute file path to the Linux partition.
#' @param path_win Character. Absolute file path to the Windows partition.
#' @param path_ext Character. Optional file path extension that will be added to
#' either \code{path_lin} or \code{path_win} after OS determination.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' \code{\link{setwd}}, \code{\link{switch}}
#' 
#' @examples
#' # desired partition
#' setwdOS()
#' 
#' # including file path extension
#' setwdOS(path_ext = "kilimanjaro/nubiscope")
#' 
#' @export setwdOS
setwdOS <- function(path_lin = "/media/permanent/", 
                    path_win = "C:/Permanent/", 
                    path_ext = NULL) {
  
  ## determine os
  ch_dir_os <- switch(Sys.info()[["sysname"]], 
                      "Linux" = path_lin, 
                      "Windows" = path_win)
  
  ## setwd
  if (is.null(path_ext))
    setwd(ch_dir_os)
  else 
    setwd(paste(ch_dir_os, path_ext, sep = "/"))
  
  return(invisible())
}