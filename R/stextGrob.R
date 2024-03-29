#' Draw Shadow Text
#'
#' @description 
#' Create and draw shadow text by wrapping a textual expression into a colored 
#' framing.
#' 
#' @param label A `character` or `expression` vector, see [grid::textGrob()].
#' @param x,y Horizontal and vertical text position as [grid::unit()] objects 
#'   passed to [grid::grid.text()].
#' @param r Blur radius of colored framing as `numeric`.
#' @param col,fill Framing and fill color passed to [grid::gpar()].
#' @param name,gp,vp Graphical parameters passed to [grid::gTree()].
#' @param ... Additional arguments passed to \[grid::grid.text()].
#' 
#' @return A text grob created by [grid::gTree()].
#' 
#' @author Baptiste Auguie, Florian Detsch
#' @family grob userlevel
#' 
#' @examples
#' library(grid)
#' grid.newpage()
#' grid.rect(gp = gpar(fill = "grey"))
#' grid.stext("test")
#' 
#' @export stextGrob
#' @aliases stextGrob grid.stext 
stextGrob <- function(label, x = grid::unit(0.5, "npc"), y = grid::unit(0.5, "npc")
                      , col = "white", fill = "black", r = 0.1 
                      , gp = grid::gpar(), vp = NULL, name = NULL, ...) {
  
  let <- grid::textGrob("a")
  
  tg <- grid::textGrob(label, x, y, gp = grid::gpar(col = fill), ...)
  
  tgl <- c(lapply(seq(0, 2 * pi, length = 18), function(theta) {
    grid::textGrob(label, x + cos(theta) * r * grid::grobWidth(let),
             y + sin(theta) * r * grid::grobHeight(let), gp = grid::gpar(col = col), ...)
  }), list(tg))
  
  
  grid::gTree(children = do.call(grid::gList, tgl), vp = vp, name = name, gp = gp)
}

#' @export
grid.stext <- function(...){
  g <- stextGrob(...)
  grid::grid.draw(g)
  invisible(g)
}
