#' Unlist the Outcome of `strsplit()`
#' 
#' @description
#' Per default, [strsplit()] returns a `list`, with each entry holding the 
#' vector of splits of the initial string(s). This function is a simple wrapper 
#' that casts [unlist()] upon the returned list to produce a concatenated 
#' `character` vector consisting of the single split elements. 
#' 
#' @param x A `character` vector with elements to be split. 
#' @param split A `character` vector used for splitting, see [strsplit()]. 
#' @param ... Additional arguments passed to [strsplit()].
#' 
#' @author 
#' Florian Detsch
#' 
#' @examples
#' ## 1st example
#' x <- "This is a test."
#' unlistStrsplit(x, " ")
#' 
#' ## 2nd example; note that 'split' defaults to 'whitespace'
#' x2 <- "This is a 2nd test."
#' unlistStrsplit(c(x, x2))
#' 
#' @export
unlistStrsplit <- function(x, split, ...) {
  
  if (missing(split))
    split <- " "
  
  ls_split <- strsplit(x, split = split, ...)
  ch_split <- unlist(ls_split)
  
  return(ch_split)
}
