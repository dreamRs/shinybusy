# shinybusy

> Minimal busy indicator for Shiny apps


## Installation

You can install `shinybusy` from GitHub:

``` r
remotes::install_github("dreamRs/shinybusy")
```

## Examples

### Spinner

Add a spinner when server is busy on top right corner of the page with:


```r
# UI
add_busy_spinner(spin = "fading-circle")
```
Classic Shiny:
![](imgs/spin-classic.png)

Shinydashboard:
![](imgs/spin-dash.png)

Shinythemes:
![](imgs/spin-theme.png)


