#' Remove duplicated columns from data frame
#' 
#' @description
#' This function automatically detects and removes columns from a data frame 
#' based on duplicated headers.
#' 
#' @param x \code{data.frame}. Input data set to be processed.
#' @param keep_first Logical. Determines whether the first column of an otherwise 
#' duplicated header should be kept; defaults to \code{TRUE}. 
#' @param ... Currently not in use.
#' 
#' @return 
#' Revised \code{data.frame}.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' \code{\link{duplicated}}
#' 
#' @examples
#' ## sample data
#' mat <- matrix(rnorm(24), nc = 6)
#' df <- data.frame(mat)
#' names(df) <- c("Col1", "Col1", "Col1", "Col2", "Col3", "Col3")
#' 
#' df
#' rmDuplCols(df)
#' rmDuplCols(df, keep_first = FALSE)
#' 
#' 
#' @export rmDuplCols
rmDuplCols <- function(x, keep_first = TRUE, ...) {
  
  ## Identify duplicated column names
  dupl.cols.ff <- duplicated(names(x))
  dupl.cols.fl <- duplicated(names(x), fromLast = TRUE)
  
  if (keep_first) {
    dupl.cols <- which(dupl.cols.ff)
  } else {
    dupl.cols <- unique(c(which(dupl.cols.ff), which(dupl.cols.fl)))
  }
  
  #   # Build new dataframe with duplicated columns 
  #   data2 <- x[, dupl.cols]
  #   names(data2) <- names(x)[dupl.cols]
  
  # Remove duplicated columns from initial dataframe
  x <- x[, -dupl.cols]
  return(x)
}