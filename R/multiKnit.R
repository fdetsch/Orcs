#' Convert Multiple R Markdown Files to Ordinary Markdown
#' 
#' @description
#' This function is a convenient wrapper around [knitr::knit()] as it 
#' automatically converts multiple R Markdown files (`.Rmd`) located in a 
#' specified folder (and, optionally, matching a particular pattern) to standard
#' Markdown (`.md`).
#' 
#' @param path_in Input file path as `character`, defaults to the current
#'   working directory.
#' @param path_out Output file path as `character`, defaults to 'path_in'.
#' @param pattern Passed to [list.files()], defaults to `"*.Rmd$"`.
#' @param ... Additional arguments passed to [knitr::knit()].
#' 
#' @return 
#' Output filenames as `character`.
#' 
#' @author 
#' Florian Detsch
#' 
#' @export
multiKnit <- function(path_in = ".", path_out = path_in, pattern = "*.Rmd$", ...) {
  
  ## input *.Rmd files
  ch_fls_in <- list.files(path_in, pattern = pattern, full.names = TRUE)
  
  ## output *.md files
  ch_fls_out <- gsub(".Rmd", ".md", ch_fls_in)
  
  ## different output path (optional)
  ch_fls_out <- file.path(path_out, basename(ch_fls_out))
  
  ## *.rmd to *.md
  for (i in 1:length(ch_fls_in))
    knitr::knit(ch_fls_in[i], ch_fls_out[i], ...)
  
  ## return output filenames
  return(ch_fls_out)
}
