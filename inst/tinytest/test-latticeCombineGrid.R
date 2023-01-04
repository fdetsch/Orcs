p1 = lattice::xyplot(1:10 ~ 1:10)
p2 = lattice::xyplot(10:1 ~ 1:10)

p = latticeCombineGrid(
  list(p1, p2)
  , scales = list(
    x = list(
      alternating = FALSE
    )
  )
)

expect_inherits(
  p
  , class = "trellis"
)

expect_identical(
  p$x.scales$alternating
  , target = 1
  , info = "additional args passed via '...' are respected"
)
