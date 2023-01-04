if ( !isGeneric("meanDifference") ) {
  setGeneric("meanDifference", function(x, ...)
    standardGeneric("meanDifference"))
}
#' Calculate Mean Difference Between Two Datasets
#'
#' @description
#' Calculate the mean difference between two datasets as suggested by Wang 
#' *et al.* (2012). 
#'
#' @param x,y Pairwise objects of class `SpatRaster`, `RasterLayer` or 
#'   `numeric`. 
#'
#' @return
#' The mean difference between the two inputs as `numeric`.
#'  
#' @source 
#' Wang *et al.* (2012) Impact of sensor degradation on the MODIS NDVI time 
#' series. Remote Sensing of Environment 119, 55-61, 
#' \doi{10.1016/j.rse.2011.12.001}.
#' 
#' Detsch *et al.* (2016) A Comparative Study of Cross-Product NDVI 
#' Dynamics in the Kilimanjaro Region - A Matter of Sensor, Degradation 
#' Calibration, and Significance. Remote Sensing 8(2), 159, 
#' \doi{10.3390/rs8020159}.
#'     
#' @examples
#' x <- 1:10
#' y <- 2:11
#' meanDifference(x, y)
#'
#' @export meanDifference
#' @name meanDifference

################################################################################
### function using 'SpatRaster' objects ---------------------------------------
#' @aliases meanDifference,SpatRaster-method
#' @rdname meanDifference
setMethod(
  "meanDifference"
  , signature(x = 'SpatRaster')
  , function(x, y) {
    
    ## early exit: multi-layered inputs
    if (terra::nlyr(x) > 1L || terra::nlyr(y) > 1L) {
      stop(
        "Cannot calculate the mean difference for multi-layered rasters."
        , call. = FALSE
      )
    }
    
    ## merge values
    num_x <- terra::values(x, mat = FALSE)
    num_y <- terra::values(y, mat = FALSE)
    
    # TODO: 
    # * support for multi-layered inputs
    # * unify with `numeric` method
    if (length(num_x) != length(num_y)) {
      warning(
        "Elements 'x' and 'y' have unequal number of cells."
        , call. = FALSE
      )
    }
    
    num_xy <- cbind(num_x, num_y)
    num_xy <- num_xy[stats::complete.cases(num_xy), ]
    
    ## calculate mean difference
    mean(num_xy[, 1] - num_xy[, 2])
  }
)


################################################################################
### function using 'numeric' vectors -------------------------------------------
#' @aliases meanDifference,numeric-method
#' @rdname meanDifference
setMethod(
  "meanDifference"
  , signature(x = "numeric")
  , function(x, y) {
    
    # TODO: 
    # * also raises warning during `cbind()`
    #   <-> forbid inputs with unequal lengths altogether?
    if (length(x) != length(y)) {
      warning(
        "Elements 'x' and 'y' are of unequal length."
        , call. = FALSE
      )
    }
    
    ## merge values
    num_xy <- cbind(x, y)
    num_xy <- num_xy[stats::complete.cases(num_xy), ]
    
    ## calculate mean difference
    mean(num_xy[, 1] - num_xy[, 2])
  }
)
