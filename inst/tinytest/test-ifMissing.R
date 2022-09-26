## raster files
logo = system.file("external/rlogo.grd", package = "raster")

ofl = file.path(tmp <- tempdir(), "rlogo.tif")
if (file.exists(ofl)) jnk = file.remove(ofl)

s = ifMissing(logo)
expect_inherits(s, "RasterBrick")

s2 = ifMissing(ofl, arg1 = "filename", x = s, datatype = "INT1U")  
expect_inherits(s2, "RasterBrick")

s3 = ifMissing(ofl)
expect_inherits(s3, "RasterBrick")

jnk = file.remove(ofl)

## text files
data(iris)

ofl = file.path(tmp, "iris.csv")
if (file.exists(ofl)) jnk = file.remove(ofl)

jnk = ifMissing(ofl, fun1 = write.csv, x = iris, file = ofl, row.names = FALSE)
expect_null(jnk)

dat = ifMissing(ofl, fun0 = utils::read.csv)
dat$Species = factor(dat$Species)
expect_equal(dat, iris)

jnk = file.remove(ofl)
expect_true(jnk)

fun = function(x, file = "", ...) {
  write.csv(x, file, ...)
  read.csv(file)
}
dat = ifMissing(ofl, fun1 = fun, arg1 = "file", x = iris, quote = FALSE, row.names = FALSE)
dat$Species = factor(dat$Species)
expect_equal(dat, iris)

jnk = file.remove(ofl)
