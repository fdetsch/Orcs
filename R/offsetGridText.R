#' Insert Offset Text Annotation into `trellis` Plot
#' 
#' @description
#' This is a wrapper function around `Orcs:::calcOffsetGridText` and **grid** 
#' based text drawing functions (currently including [grid::grid.text()] and 
#' [grid.stext()]) that automatically adds offset text annotations to a 
#' `trellis` plot.
#' 
#' @param x A `numeric` vector containing x coordinates, or a 2-column `matrix` 
#'   containing x and y coordinates.
#' @param y A `numeric` vector containing y coordinates, or `NULL` if 'x' is a 
#'   two-column `matrix`.
#' @param labels The text to be written as `character`.
#' @param xlim,ylim X and Y-axis limits (`c(min, max)`) of the current plot. If 
#'   not supplied, limits are automatically calculated from supplied x and y
#'   coordinates.
#' @param pos Text position specifier(s) as `integer` used by 
#'   [graphics::text()]. If not supplied, optimal text positions will be 
#'   determined with respect to neighboring locations using 
#'   [plotrix::thigmophobe()]. 
#' @param stext `logical`, defaults to `FALSE`. If `TRUE`, shadow text will be 
#'   drawn around 'labels'.
#' @param offset A `numeric` offset in normalized parent coordinates (`"npc"`, 
#'   see [grid::unit()]).
#' @param ... Additional arguments passed to the respective **grid** text 
#'   drawing function (depends on 'stext'). 
#' 
#' @author
#' Florian Detsch
#' 
#' @examples
#' stopifnot(
#'   require(sf)
#'   , require(latticeExtra)
#'   , require(grid)
#' )
#' 
#' # kilimanjaro peaks
#' peaks = data.frame(Peak = c("Kibo", "Mawenzi", "Shira")
#'                    , Lon = c(37.359031, 37.455061, 37.210408)
#'                    , Lat = c(-3.065053, -3.095436, -3.038222))
#' 
#' coordinates(peaks) = ~ Lon + Lat
#' proj4string(peaks) = "+init=epsg:4326"
#' 
#' # visualization
#' xlim_kili <- c(37.15, 37.55)
#' ylim_kili <- c(-3.25, -2.9)
#' 
#' p = spplot(KiLi[[1]], col.regions = "transparent", colorkey = FALSE, 
#'            xlim = xlim_kili, ylim = ylim_kili,
#'            scales = list(draw = TRUE, y = list(rot = 90)), 
#'            sp.layout = rgb2spLayout(KiLi, quantiles = c(0, 1), alpha = .8)) + 
#'   layer(sp.points(peaks, cex = 1.5, pch = 20, col = "black"))
#' 
#' print(p)
#' 
#' downViewport(trellis.vpname(name = "figure"))
#' offsetGridText(x = coordinates(peaks), labels = peaks$Peak,  
#'                xlim = xlim_kili, ylim = ylim_kili, stext = TRUE, offset = .02,
#'                gp = gpar(fontsize = 16))
#'                                
#' @export
offsetGridText <- function(x, y = NULL, labels, xlim = NULL, ylim = NULL, 
                           pos = NULL, stext = FALSE, offset = .02, ...) {

  if (is.matrix(x)) {
    y <- x[, 2]
    x <- x[, 1]
  }
  
  # best label locations (if 'pos' is not supplied)
  int_loc_lbl <- if (is.null(pos)) plotrix::thigmophobe(x, y) else pos
  ch_loc_lbl <- pos2just(int_loc_lbl)
  
  # calculate offset point coordinates
  mat_crd_rel_off <- calcOffsetGridText(x = x, y = y, xlim = xlim, ylim = ylim, 
                                        pos = pos, offset = offset)
  
  for (tmp_cnt in 1:nrow(mat_crd_rel_off)) {
    if (stext) {
      grid.stext(labels[tmp_cnt], 
                 x = grid::unit(mat_crd_rel_off[tmp_cnt, 1], "npc"), 
                 y = grid::unit(mat_crd_rel_off[tmp_cnt, 2], "npc"), 
                 just = ch_loc_lbl[tmp_cnt], ...)
    } else {
      grid::grid.text(labels[tmp_cnt], 
                      x = grid::unit(mat_crd_rel_off[tmp_cnt, 1], "npc"), 
                      y = grid::unit(mat_crd_rel_off[tmp_cnt, 2], "npc"),
                      just = ch_loc_lbl[tmp_cnt], ...)
    }
  }

  return(invisible())
}
