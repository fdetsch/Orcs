#' Create \code{data.frame} from \code{list}
#' 
#' Create a \code{data.frame} from a \code{list} directly, \emph{i.e.} without 
#' being required to explicitly call \code{\link{rbind}} first.
#' 
#' @param x A \code{list} object.
#' @param ... Further arguments passed on to \code{\link{data.frame}}.
#' 
#' @return A \code{data.frame} object.
#' 
#' @seealso 
#' \code{\link{data.frame}}, \code{\link{rbind}}, \code{\link{do.call}}.
#' 
#' @examples 
#' lst <- list(letters[1:3], letters[4:6], letters[7:9])
#' 
#' do.call("rbind", lst) # results in matrix
#' list2df(lst)          # results in data.frame
#' 
#' @export list2df
#' @name list2df
list2df <- function(x, ...) {
  
  mat_x <- do.call("rbind", x)
  df_x <- data.frame(mat_x, ...)
  
  return(df_x)
}