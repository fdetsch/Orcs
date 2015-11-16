rbind2df <- function(x, ...) {
  
  mat_x <- do.call("rbind", x)
  df_x <- data.frame(mat_x, ...)
  
  return(df_x)
}