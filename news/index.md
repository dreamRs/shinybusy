# Changelog

## shinybusy (development version)

- New functions
  [`show_loading()`](https://dreamrs.github.io/shinybusy/reference/loading-overlay.md),
  [`update_loading()`](https://dreamrs.github.io/shinybusy/reference/loading-overlay.md)
  and
  [`remove_loading()`](https://dreamrs.github.io/shinybusy/reference/loading-overlay.md)
  to display a full-page loading indicator from the server, using the
  Notiflix Loading module.

## shinybusy 0.3.3

CRAN release: 2024-03-09

- New function
  [`block_output()`](https://dreamrs.github.io/shinybusy/reference/block_output.md)
  to block an output until it is recalculated directly in the UI.

## shinybusy 0.3.2

CRAN release: 2023-11-23

- New functions
  [`block()`](https://dreamrs.github.io/shinybusy/reference/block.md)
  and
  [`unblock()`](https://dreamrs.github.io/shinybusy/reference/block.md)
  to block/unblock elements (like outputs) during a lonng calculation.
- Notiflix related dependencies are now exported
  ([`notify()`](https://dreamrs.github.io/shinybusy/reference/notify.md),
  [`report()`](https://dreamrs.github.io/shinybusy/reference/report.md),
  [`block()`](https://dreamrs.github.io/shinybusy/reference/block.md)).

## shinybusy 0.3.1

CRAN release: 2022-05-10

- Use correct HTML dependencies.
- Remove unnecessary CSS code in spinkit spinners.

## shinybusy 0.3.0

CRAN release: 2022-02-22

- Internal: use [{packer}](https://github.com/JohnCoene/packer) to
  manage JavaScript assets.
- New function
  [`update_modal_spinner()`](https://dreamrs.github.io/shinybusy/reference/modal-spinner.md)
  to update modal spinner text
  ([\#19](https://github.com/dreamRs/shinybusy/issues/19)).
- New function
  [`notify()`](https://dreamrs.github.io/shinybusy/reference/notify.md)
  to send notifications (success, error, info or warning).
- New function
  [`report()`](https://dreamrs.github.io/shinybusy/reference/report.md)
  to send extended notifications (success, error, info or warning).

## shinybusy 0.2.2

CRAN release: 2020-09-27

- Fixed a bug in
  [`spin_kit()`](https://dreamrs.github.io/shinybusy/reference/spin_kit.md)
  ([\#12](https://github.com/dreamRs/shinybusy/issues/12)).

## shinybusy 0.2.1

CRAN release: 2020-09-10

- New function
  [`add_loading_state()`](https://dreamrs.github.io/shinybusy/reference/add_loading_state.md)
  to add loading state to several outputs.
- New function
  [`busy_start_up()`](https://dreamrs.github.io/shinybusy/reference/busy-start-up.md)
  to add a start-up page before application is ready to be used.
- HTML dependencies used in package are now exported, see
  `html_dependency_*` functions.

## shinybusy 0.2.0

CRAN release: 2019-10-29

- New htmlwidgets for `progressbar.js` : see functions
  [`progress_line()`](https://dreamrs.github.io/shinybusy/reference/progress.md)
  and
  [`progress_circle()`](https://dreamrs.github.io/shinybusy/reference/progress.md).
- New functions
  [`show_modal_spinner()`](https://dreamrs.github.io/shinybusy/reference/modal-spinner.md)
  and
  [`remove_modal_spinner()`](https://dreamrs.github.io/shinybusy/reference/modal-spinner.md)
  to show a modal with a spinner and remove it.
- New functions
  [`show_modal_progress_line()`](https://dreamrs.github.io/shinybusy/reference/modal-progress.md),
  [`show_modal_progress_circle()`](https://dreamrs.github.io/shinybusy/reference/modal-progress.md),
  [`update_modal_progress()`](https://dreamrs.github.io/shinybusy/reference/modal-progress.md)
  and
  [`remove_modal_progress()`](https://dreamrs.github.io/shinybusy/reference/modal-progress.md)
  to show a modal with a progress bar, update it and remove it.
- New spinners available, see
  [`spin_epic()`](https://dreamrs.github.io/shinybusy/reference/spin_epic.md)
  for a demo, or the online version :
  <https://dreamrs.github.io/shinybusy/articles/spinners.html>
- Two new vignettes are available :
  `vignette("shinybusy-usage", package = "shinybusy")` and
  vignette(“spinners”, package = “shinybusy”).

## shinybusy 0.1.3

CRAN release: 2019-08-19

- Fix bug in IE.

## shinybusy 0.1.2

CRAN release: 2019-05-07

- Bugfix: change color in ‘busy-bar’.
- Bugfix: overlay in full page mode for spinner.

## shinybusy 0.1.1

CRAN release: 2019-04-23

- First release : add spinner, progress bar, gif to indicate if an
  application is busy.
