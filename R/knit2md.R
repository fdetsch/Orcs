#' Convert a R Markdown file to ordinary Markdown
#' 
#' @description
#' This function is a convenient wrapper around \code{\link{knit}} as
#' it automatically converts all R Markdown files (*.Rmd) located in 
#' a specified folder and, optionally, matching a particular pattern 
#' to standard Markdown (*.md).
#' 
#' @param path_in Character. Input file path; defaults to the current
#' working directory.
#' @param path_out Character. Output file path; if \code{NULL}, 
#' defaults to \code{path_in}.
#' @param pttrn Character. A regular expression as taken by 
#' \code{\link{list.files}}; defaults to \code{"*.Rmd$"}.
#' @param ... Further arguments passed on to \code{\link{knit}}.
#' 
#' @return 
#' Output filename(s).
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' \code{\link{list.files}}, \code{\link{knit}}
#' 
#' @export knit2md
knit2md <- function(path_in = getwd(), path_out = NULL, pttrn = "*.Rmd$", ...) {
  
  ## input *.Rmd files
  ch_fls_in <- list.files(path_in, pattern = pttrn, full.names = TRUE)
  
  ## output *.md files
  ch_fls_out <- gsub(".Rmd", ".md", ch_fls_in)
  
  ## different output path (optional)
  if (!is.null(path_out))
    ch_fls_out <- paste(path_out, basename(ch_fls_out), sep = "/")
  
  ## *.rmd to *.md
  for (i in 1:length(ch_fls_in))
    knitr::knit(ch_fls_in[i], ch_fls_out[i], ...)
  
  ## return output filenames
  return(ch_fls_out)
}