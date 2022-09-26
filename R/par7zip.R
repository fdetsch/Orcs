#' Parallelized 7-Zip Compression
#' 
#' @description
#' By calling the Unix terminal or Windows command prompt, this function 
#' performs parallelized 7-zip compression of selected files based on the 
#' built-in **parallel** package.
#' 
#' @param outfile Target file for compression as `character`. A file extension 
#'   compatible with 7-zip needs to be included, see 
#'   [supported formats](https://sevenzip.osdn.jp/chm/general/formats.htm). If 
#'   missing, this defaults to the found input file names with a `.7z` extension
#'   attached.
#' @param nodes Number of cores to use for parallelization as `integer`, 
#'   defaults to `1L`.
#' @param ... Additional arguments passed to [list.files()].
#' 
#' @return 
#' Output filename(s) as `character`.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' [list.files()], [system()]
#' 
#' @export
par7zip <- function(outfile, nodes = 1L, ...) {
  
  ## files/directories to compress 
  ch_fls <- list.files(...)
  
  if (missing(outfile) | 
      ((len1 <- length(outfile)) > 1 & len1 < (len2 <- length(ch_fls)))) {
    
    # if input and output lengths do not match, replace 'outfile'
    if (len1 > 1 & len1 < len2) {
      warning("Lengths of 'outfile' and found files do not match, "
              , "appending '.7z' to input file names.")
    }
    
    outfile = file.path(dirname(ch_fls), paste0(pureBasename(ch_fls), ".7z"))
    
  # else if only one target file is specified, disable parallelization  
  } else if (len1 == 1) {
    nodes = 1L
    outfile = rep(outfile, len2)
  } 

  ## parallelization
  cl <- parallel::makePSOCKcluster(nodes)
  on.exit(parallel::stopCluster(cl))
  
  ## perform 7-zip compression
  parallel::clusterExport(cl, c("ch_fls", "outfile"), envir = environment())
  jnk = parallel::parLapply(cl, 1:len2, function(i) {
    system(paste0('7z a "', outfile[i], '" "', ch_fls[i], '"'))
  })
  
  return(unique(outfile))
}
