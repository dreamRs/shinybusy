# shinybusy 0.3.1

* Use correct HTML dependencies.
* Remove unnecessary CSS code in spinkit spinners.


# shinybusy 0.3.0

* Internal: use [{packer}](https://github.com/JohnCoene/packer) to manage JavaScript assets.
* New function `update_modal_spinner()` to update modal spinner text ([#19](https://github.com/dreamRs/shinybusy/issues/19)).
* New function `notify()` to send notifications (success, error, info or warning).
* New function `report()` to send extended notifications (success, error, info or warning).


# shinybusy 0.2.2

* Fixed a bug in `spin_kit()` ([#12](https://github.com/dreamRs/shinybusy/issues/12)).


# shinybusy 0.2.1

* New function `add_loading_state()` to add loading state to several outputs.
* New function `busy_start_up()` to add a start-up page before application is ready to be used.
* HTML dependencies used in package are now exported, see `html_dependency_*` functions.


# shinybusy 0.2.0

* New htmlwidgets for `progressbar.js` : see functions `progress_line()` and `progress_circle()`.
* New functions `show_modal_spinner()` and `remove_modal_spinner()` to show a modal with a spinner and remove it.
* New functions `show_modal_progress_line()`, `show_modal_progress_circle()`, `update_modal_progress()` and `remove_modal_progress()` to show a modal with a progress bar, update it and remove it.
* New spinners available, see `spin_epic()` for a demo, or the online version : https://dreamrs.github.io/shinybusy/articles/spinners.html
* Two new vignettes are available : `vignette("shinybusy-usage", package = "shinybusy")` and vignette("spinners", package = "shinybusy").


# shinybusy 0.1.3

* Fix bug in IE.


# shinybusy 0.1.2

* Bugfix: change color in 'busy-bar'.
* Bugfix: overlay in full page mode for spinner.


# shinybusy 0.1.1

* First release : add spinner, progress bar, gif to indicate if an application is busy.
