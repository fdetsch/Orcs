#' Parallelized 7zip-based compression
#' 
#' @description
#' By calling the Terminal (UNIX-based OS) or Command Prompt (Windows OS) from 
#' within R, this function performs parallelized 7zip-based compression of 
#' selected files based on the built-in \strong{parallel} package.
#' 
#' @param path_in Character. Input file path; defaults to the current
#' working directory.
#' @param nodes Integer. Number of cores to use for parallelization; defaults to 
#' \code{1}.
#' @param ... Further arguments passed on to \code{\link{list.files}}.
#' 
#' @return 
#' Output filename(s).
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' \code{\link{list.files}}, \code{\link{system}}
#' 
#' @export par7zip
par7zip <- function(path_in = getwd(), nodes = 1L, ...) {
  
  ## parallelization
  cl <- parallel::makePSOCKcluster(nodes)
  
  ## files/directories to compress 
  ch_fls <- list.files(path_in, full.names = TRUE, ...)
  
  ## perform 7zip-based compression
  parallel::clusterExport(cl, "ch_fls", envir = environment())
  parallel::parLapply(cl, ch_fls, function(i) {
    system(paste("7z a", paste(i, "7z", sep = "."), i, sep = " "))
  })
  
  ## deregister parallel backend
  parallel::stopCluster(cl)
  
}