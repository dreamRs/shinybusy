# shinybusy

> Minimal busy indicator for Shiny apps

[![Travis build status](https://travis-ci.org/dreamRs/shinybusy.svg?branch=master)](https://travis-ci.org/dreamRs/shinybusy)
[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)


## Installation

You can install `shinybusy` from GitHub:

``` r
remotes::install_github("dreamRs/shinybusy")
```

## Examples


### Gif

Animate a Gif when server is busy and pause animation when server is idle :

```r
# Somewhere in UI
add_busy_gif(src = "https://jeroen.github.io/images/banana.gif", height = 70, width = 70)
```
![](imgs/shinybusy-gif.gif)



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


