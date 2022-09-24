#' Convert Between DOS and UNIX Line Endings
#' 
#' @description
#' This function converts between DOS and UNIX style line endings by invoking 
#' `unix2dos` (or `dos2unix`) upon a text file (see also 
#' `system("unix2dos --help")`). Note that 'unix2dos' must be installed on your 
#' local system, see Source.
#' 
#' @param infile Input filename(s). 
#' @param pattern See [list.files()]. This will be ignored if 'infile' is 
#'   specified.
#' @param outfile Output filename. If not supplied, 'infile' will be 
#'   overwritten.
#' @param to Either `"dos"` or `"unix"`.
#' @param ... Additional arguments passed to [list.files()], only applicable if 
#'   'infile' is not specified.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso 
#' [list.files()], [system()].
#' 
#' @source 
#' [Dos2Unix/Unix2Dos Text file format converters](https://waterlan.home.xs4all.nl/dos2unix.html).
#' 
#' @examples
#' ## input file
#' infile <- paste(system.file(package = "Orcs"), "DESCRIPTION", sep = "/")
#' 
#' ## convert to dos line endings and write to output file
#' ofl = file.path(tempdir(), "DESCRIPTION4wd")
#' lineEnding(infile, outfile = ofl, to = "dos")
#' 
#' @export
lineEnding <- function(infile, pattern = NULL, outfile = NULL, 
                       to = c("dos", "unix"), ...) {

  ## if not specified, convert to dos format
  to <- to[1]
  
  ## if not supplied, only files matching a given pattern are processed
  if (missing(infile))
    infile <- list.files(pattern = pattern, ...)
  
  ## overwrite infile or create outfile string
  ch_ext = ifelse(is.null(outfile), infile, paste0('-n "', infile, '" "', outfile, '"'))

  ## conversion to dos or unix format
  ch_sys = paste(ifelse(to == "dos", "unix2dos", "dos2unix"), ch_ext)

  ## execute conversion
  for (i in ch_sys)
    system(i)

  return(invisible())
}
