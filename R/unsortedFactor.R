#' Factor with Unsorted Levels
#' 
#' @description
#' Casting [factor()] upon a (`character`) vector usually results in 
#' alphabetically ordered factor levels. Although this seems reasonable in most 
#' cases, the automated ordering of factor levels is seldomly desirable in the 
#' context of visualization, e.g. when working with tiled **lattice** or 
#' **ggplot2** figures. This function returns a `factor` with levels ordered 
#' according to their first appearance in the supplied vector.
#' 
#' @param x A `character` vector with elements to converted to `factor`. 
#' @param ... Additional arguments passed to [factor()].
#' 
#' @author 
#' Florian Detsch
#' 
#' @examples
#' mnth <- month.abb
#' 
#' ## factor levels are being sorted
#' fc_mnth <- factor(mnth)
#' levels(fc_mnth)
#' 
#' ## factor levels remain unsorted
#' fc_mnth2 <- unsortedFactor(mnth)
#' levels(fc_mnth2)
#' 
#' @export
unsortedFactor <- function(x, ...) {
  
  fc_x <- factor(x, ...)
  levels(fc_x) <- unique(x)

  return(fc_x)
}
