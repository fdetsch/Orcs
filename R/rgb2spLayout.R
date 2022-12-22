#' Convert an RGB `Raster*` to Use with `spplot()`
#'
#' @description
#' This function takes a red-green-blue `SpatRaster` or `Raster*` object and 
#' produces a list with color information that can be passed on as 'sp.layout' 
#' to [sp::spplot()].
#'
#' @param x A 3-layered `SpatRaster*` or `Raster*` object.
#' @param quantiles Upper and lower quantiles used for color stretching.
#' @param alpha Level of transparency.
#'
#' @seealso [terra::plotRGB()].
#'
#' @author
#' Tim Appelhans, Florian Detsch
#'
#' @examples
#' b = terra::rast(system.file("ex/logo.tif", package="terra"))
#'
#' ## using plotRGB
#' terra::plotRGB(b)
#'
#' ## convert raster to list
#' lout = rgb2spLayout(b)
#' lout_alph = rgb2spLayout(b, alpha = 0.5)
#'
#' ## create random spatial points for plotting
#' df = data.frame(
#'   dat = rnorm(100, 2, 1)
#'   , x = rnorm(100, 50, 20)
#'   , y = rnorm(100, 50, 25)
#' )
#' 
#' df = sf::st_as_sf(df, coords = c("x", "y"))
#'
#' ## plot spatial points with rgb background
#' if (require(sp, quietly = TRUE)) {
#'   spplot(as(df, "Spatial"), sp.layout = lout)
#'   spplot(as(df, "Spatial"), sp.layout = lout_alph)
#' }
#'
#' @export
rgb2spLayout <- function(x,
                         quantiles = c(0.02, 0.98),
                         alpha = 1) {
  
  if (inherits(x, "Raster")) {
    x = as(x, "SpatRaster")
  } else if (!inherits(x, "SpatRaster")) {
    stop(
      "'x' needs to be a `SpatRaster` or `Raster` object"
      , call. = FALSE
    )
  }
  
  ## reclassify image
  rcls = list(
    cbind(NA, 1) # `NA` -> 1
    , cbind(-Inf, 0, 1) # negative values -> 1
  )
  
  for (rcl in rcls) {
    x = terra::classify(
      x
      , rcl = rcl
      , right = FALSE
    )
  }
  
  ### use downloaded map for sp raster layout definition
  mat = terra::values(x)
  
  for(i in seq(ncol(mat))){
    z <- mat[, i]
    lwr <- stats::quantile(z, probs = quantiles[1], na.rm = TRUE)
    upr <- stats::quantile(z, probs = quantiles[2], na.rm = TRUE)
    z <- (z - lwr) / (upr - lwr)
    z[z < 0] <- 0
    z[z > 1] <- 1
    mat[, i] <- z
  }
  
  cols <- grDevices::rgb(mat[, ], alpha = alpha)
  
  map.cols = matrix(
    cols
    , nrow = terra::nrow(x)
    , ncol = terra::ncol(x)
  )
  
  attr(map.cols, "class") <- c("ggmap", "raster")
  attr(map.cols, "bb") <- data.frame(
    ll.y = terra::ymin(x)
    , ll.x = terra::xmin(x)
    , ur.y = terra::ymax(x)
    , ur.x = terra::xmax(x)
  )
  
  bbMap <- attr(map.cols, 'bb')
  latCenter <- with(bbMap, ll.y + ur.y) / 2
  lonCenter <- with(bbMap, ll.x + ur.x) / 2
  height <- with(bbMap, ur.y - ll.y)
  width <- with(bbMap, ur.x - ll.x)
  
  ## Use sp.layout of spplot: a list with the function and its arguments
  sp.raster <- list('grid.raster', map.cols,
                    x = lonCenter, y = latCenter,
                    width = width, height = height,
                    default.units = 'native',
                    first = TRUE)
  
  return(sp.raster)
}
