context("test-busy-spinner")

test_that("busy_spinner works", {

  tag_busy_spinner <- busy_spinner()

  expect_is(tag_busy_spinner, "shiny.tag.list")
  expect_true(length(htmltools::findDependencies(tag_busy_spinner)) > 0)
})



test_that("busy_spinner works", {

  spins <- c(
    "circle", "bounce", "folding-cube", "rotating-plane", "cube-grid",
    "fading-circle", "double-bounce", "dots", "cube"
  )

  for (spin in spins) {
    tag_spinner <- spinner(spin = spin)

    expect_true(inherits(tag_spinner, c("shiny.tag", "shiny.tag.list")))
  }
})


