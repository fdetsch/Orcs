#' Remove Whitespace from Images
#' 
#' @description
#' This is a wrapper function around `convert -trim` to automatically remove any
#' whitespace from locally saved images. Note that 'ImageMagick' must be 
#' installed on your local system, see Source.
#' 
#' @param path File path leading to image files as `character`, defaults to the 
#'   current working directory.
#' @param pattern A regular expression as `character` accepted by 
#'   [list.files()], defaults to `c(".png$", ".tiff$")`.
#' 
#' @return
#' A `character` vector containing the names of the processed images.
#' 
#' @author 
#' Florian Detsch
#' 
#' @seealso
#' [system()] 
#' 
#' @source 
#' Ooms J (2018) The **magick** package: Advanced Image-Processing in R. 
#' Available online: <https://cran.r-project.org/package=magick/vignettes/intro.html>.
#' 
#' @examples
#' \dontrun{
#' ## trim image of bart simpson
#' download.file("http://pngimg.com/uploads/simpsons/simpsons_PNG93.png?i=1"
#'               , destfile = (ofl <- file.path(tempdir(), "bart.png", fsep = "\\"))
#'               , mode = "wb")
#' 
#' par(mfrow = c(1, 2))
#' 
#' img = brick(ofl)
#' plotRGB(img)
#' 
#' jnk = trimImages(tempdir(), "bart.png")
#' trm = brick(jnk)
#' plotRGB(trm)
#' 
#' dev.off()
#' }
#' 
#' @export
trimImages <- function(path = ".", pattern = c(".png$", ".tiff$")) {
  
  ## list files matching specified pattern
  lst_fls <- lapply(pattern, function(i) {
    list.files(path = path, pattern = i, full.names = TRUE)
  })
  chr_fls <- unlist(lst_fls)
  
  if (length(chr_fls) == 0)
    stop("No files found in ", path, " matching specified pattern.")
    
  ## trim images
  for (i in chr_fls) {
    ch_sysstring <- paste("magick", i, "-trim", i)
    system(ch_sysstring)
  }
  
  ## return list of processed files
  return(chr_fls)
}
