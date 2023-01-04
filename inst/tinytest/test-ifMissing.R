## raster files
logo = system.file("ex/logo.tif", package = "terra")

ofl = file.path(tmp <- tempdir(), "rlogo.tif")

avl = file.exists(ofl)
if (avl) {
  jnk = file.rename(ofl, paste0(ofl, ".bu"))
}

s = ifMissing(logo)
expect_inherits(s, "SpatRaster")

s2 = ifMissing(ofl, arg1 = "filename", x = s, datatype = "INT1U")  
expect_inherits(s2, "SpatRaster")

s3 = ifMissing(ofl)
expect_inherits(s3, "SpatRaster")

jnk = file.remove(ofl)

if (avl) {
  jnk = file.copy(paste0(ofl, ".bu"), ofl, overwrite = TRUE)
  jnk = file.remove(paste0(ofl, ".bu"))
}

## text files
data(iris)

ofl = file.path(tmp, "iris.csv")

avl = file.exists(ofl)
if (avl) {
  jnk = file.rename(ofl, paste0(ofl, ".bu"))
}

jnk = ifMissing(ofl, fun1 = write.csv, x = iris, file = ofl, row.names = FALSE)
expect_null(jnk)

dat = ifMissing(ofl, fun0 = utils::read.csv)
dat$Species = factor(dat$Species)
expect_equal(dat, iris)

jnk = file.remove(ofl)

if (avl) {
  jnk = file.copy(paste0(ofl, ".bu"), ofl, overwrite = TRUE)
  jnk = file.remove(paste0(ofl, ".bu"))
}

fun = function(x, file = "", ...) {
  utils::write.csv(x, file, ...)
  utils::read.csv(file)
}
dat = ifMissing(ofl, fun1 = fun, arg1 = "file", x = iris, quote = FALSE, row.names = FALSE)
dat$Species = factor(dat$Species)
expect_equal(dat, iris)

jnk = file.remove(ofl)
