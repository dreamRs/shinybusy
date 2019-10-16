context("busy-gif")

test_that("add_busy_gif works", {

  tag_busy_gif <- add_busy_gif(logo_silex())

  expect_is(tag_busy_gif, "shiny.tag.list")
  expect_true(length(htmltools::findDependencies(tag_busy_gif)) > 0)
})
