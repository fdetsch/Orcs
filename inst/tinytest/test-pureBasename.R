logo = system.file(
  "ex/logo.tif"
  , package = "terra"
)

expect_identical(
  pureBasename(logo)
  , target = "logo"
)

expect_identical(
  pureBasename(
    logo
    , slash = TRUE
  )
  , target = "/logo"
  , info = "respects 'slash' input"
)
