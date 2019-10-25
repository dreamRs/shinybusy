/*!
 * Copyright (c) 2019 dreamRs
 *
 * shinybusy, JavaScript bindings to add
 * automatic spinner to Shiny output
 * https://github.com/dreamRs/shinybusy
 *
 * @version 0.1.4
 */

var findOne = function(haystack, arr) {
  arr = [].slice.apply(arr);
  return arr.some(function(v) {
    return haystack.indexOf(v) >= 0;
  });
};
var idIn,
  idOut,
  outputClass = ["shiny-plot-output", "html-widget-output"];

$(function() {
  var config = document.querySelector(
    'script[data-for="shinybusy-autospinner"]'
  );
  config = JSON.parse(config.innerHTML);
  if (config) {
    outputClass = config.class_in;
    idIn = config.id_in;
    idOut = config.id_out;
  }

  $(document).on("shiny:outputinvalidated", function(event) {
    var elIdIn = false;
    if (idIn.length === 0) {
      elIdIn = true;
    } else {
      if (findOne(idIn, event.target.id)) {
        elIdIn = true;
      }
    }
    if (idOut.length !== 0) {
      if (findOne(idOut, event.target.id)) {
        elIdIn = false;
      }
    }
    var elClassIn = findOne(outputClass, event.target.classList);
    if (elIdIn) {
      elClassIn = true;
    }

    if (elIdIn & elClassIn) {
      var children = $(event.target).children();
      event.target.innerHTML = "";
      $(event.target).addClass("shinybusy-recalculating");
      // $(event.target).css("position", "relative");

      $(".shinybusy-auto-recalculating")
        .clone()
        .removeClass("shinybusy-auto-recalculating")
        .addClass("shinybusy-auto-recalculating" + event.target.id)
        .addClass("recalculating")
        .appendTo(event.target);
      children.appendTo(
        $(event.target).find(".shinybusy-auto-recalculating" + event.target.id)
      );
      $(event.target).removeClass("recalculating");
      $(".shinybusy-auto-spinner")
        .clone()
        .removeClass("shinybusy-auto-spinner")
        .prependTo(event.target);
    }
  });

  $(document).on("shiny:recalculating", function(event) {
    var elIdIn = false;
    if (idIn === undefined) {
      elIdIn = true;
    } else {
      if (findOne(idIn, event.target.id)) {
        elIdIn = true;
      }
    }
    if (idOut !== undefined) {
      if (findOne(idOut, event.target.id)) {
        elIdIn = false;
      }
    }
    var elClassIn = findOne(outputClass, event.target.classList);
    if (elIdIn) {
      elClassIn = true;
    }

    if (elIdIn & elClassIn) {
      $(event.target).removeClass("recalculating");
    }
  });

  $(document).on("shiny:recalculated", function(event) {
    var elIdIn = false;
    if (idIn === undefined) {
      elIdIn = true;
    } else {
      if (findOne(idIn, event.target.id)) {
        elIdIn = true;
      }
    }
    if (idOut !== undefined) {
      if (findOne(idOut, event.target.id)) {
        elIdIn = false;
      }
    }
    var elClassIn = findOne(outputClass, event.target.classList);
    if (elIdIn) {
      elClassIn = true;
    }

    if (elIdIn & elClassIn) {
      $(event.target).removeClass("shinybusy-recalculating");
    }
  });
});

