#' Set Working Directory Dependent on Current OS
#' 
#' @description
#' Similar to [setwd()], this function sets the working directory to a 
#' user-defined path. Rather than supplying a single 'dir' argument, however, 
#' both an OS-sensitive path to the desired hard disk partition and, optionally, 
#' an extension of this file path are required.  
#' 
#' @param lin,win Absolute file paths to the Linux and Windows partition as 
#'   `character`.
#' @param ext Optional file path extension as `character` that will be added to 
#'   'lin' or 'win' after automatic OS determination.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' [switch()].
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
#' @export
setwdOS <- function(lin = "/media/permanent/", 
                    win = "C:/", 
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
