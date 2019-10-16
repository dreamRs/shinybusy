context("busy-spinner")

test_that("busy_spinner works", {

  tag_busy_spinner <- busy_spinner()

  expect_is(tag_busy_spinner, "shiny.tag.list")
  expect_true(length(htmltools::findDependencies(tag_busy_spinner)) > 0)

  tag_busy_spinner <- use_busy_spinner()

  expect_is(tag_busy_spinner, "shiny.tag.list")
  expect_true(length(htmltools::findDependencies(tag_busy_spinner)) > 0)

  tag_busy_spinner <- add_busy_spinner()

  expect_is(tag_busy_spinner, "shiny.tag.list")
  expect_true(length(htmltools::findDependencies(tag_busy_spinner)) > 0)
})



test_that("spin_kit works", {

  spins <- c(
    "circle", "bounce", "folding-cube", "rotating-plane", "cube-grid",
    "fading-circle", "double-bounce", "dots", "cube"
  )

  for (spin in spins) {
    tag_spinner <- spin_kit(spin = spin)

    expect_true(inherits(tag_spinner, c("shiny.tag", "shiny.tag.list")))
  }
})

test_that("spin_epic works", {

  spins <- c("flower", "pixel", "hollow-dots",
             "intersecting-circles", "orbit", "radar",
             "scaling-squares", "half-circle", "trinity-rings",
             "fulfilling-square", "circles-to-rhombuses",
             "semipolar", "self-building-square", "swapping-squares",
             "fulfilling-bouncing-circle", "fingerprint", "spring",
             "atom", "looping-rhombuses", "breeding-rhombus")

  for (spin in spins) {
    tag_spinner <- spin_epic(spin = spin)

    expect_true(inherits(tag_spinner, c("shiny.tag", "shiny.tag.list")))
  }
})
