#' Create `data.frame` from `list`
#' 
#' Create a `data.frame` from a `list` directly, i.e. without being required to 
#' explicitly call [rbind()] first.
#' 
#' @param x A `list` object.
#' @param bind Binding direction. Available options are `"rows"` (default) and 
#'   `"cols"` for [rbind()] and [cbind()], respectively.
#' @param ... Additional arguments passed to [data.frame()].
#' 
#' @return A `data.frame` object.
#' 
#' @examples 
#' lst <- list(letters[1:3], letters[4:6], letters[7:9])
#' 
#' do.call("rbind", lst) # results in matrix
#' list2df(lst)          # results in data.frame created using rbind()
#' list2df(lst, bind = "cols") # same for cbind()
#' 
#' @export
list2df <- function(x, bind = c("rows", "cols"), ...) {
  
  bind = bind[1]
  
  mat_x = if (bind == "rows") {
    mat_x = do.call("rbind", x)
  } else if (bind == "cols") {
    do.call("cbind", x)
  } else {
    stop("Binding direction unknown, choose either 'rows' or 'cols'.\n")
  }
  
  data.frame(mat_x, ...)
}
