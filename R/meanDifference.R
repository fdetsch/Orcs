if ( !isGeneric("meanDifference") ) {
  setGeneric("meanDifference", function(x, ...)
    standardGeneric("meanDifference"))
}
#' Calculate mean difference between two datasets
#'
#' @description
#' Calculate the mean difference between two datasets as suggested by 
#' \emph{Wang et al. (2012)}. This function can be operated either with 'numeric' 
#' vectors or objects of class 'RasterLayer'.
#'
#' @param x,y Objects of class 'RasterLayer' or 'numeric' vectors. 
#'
#' @return
#' The mean difference between values of 'x' and 'y'.
#'  
#' @examples
#' x <- 1:10
#' y <- 2:11
#' meanDifference(x, y)
#'
#' @export meanDifference
#' @name meanDifference

# Function using 'RasterLayer' objects -----------------------------------------
#' 
#' @aliases meanDifference,RasterLayer-method
#' @rdname meanDifference
setMethod("meanDifference",
          signature(x = 'RasterLayer'),
          function(x, y) {
  
  ## merge values
  num_x <- x[]
  num_y <- y[]
  
  if (length(num_x) != length(num_y))
    cat("Warning: elements 'x' and 'y' have unequal number of cells.\n")
  
  num_xy <- cbind(num_x, num_y)
  num_xy <- num_xy[complete.cases(num_xy), ]
  
  ## calculate mean difference
  mean(num_xy[, 1] - num_xy[, 2])
})


# Function using 'numeric' vectors ---------------------------------------------
#' 
#' @aliases meanDifference,numeric-method
#' @rdname meanDifference
setMethod("meanDifference",
          signature(x = "numeric"),
          function(x, y) {

  if (length(x) != length(y))
    cat("Warning: elements 'x' and 'y' are of unequal length.\n")
  
  ## merge values
  num_xy <- cbind(x, y)
  num_xy <- num_xy[complete.cases(num_xy), ]
  
  ## calculate mean difference
  mean(num_xy[, 1] - num_xy[, 2])
})
