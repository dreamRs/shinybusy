/*!
 * Copyright (c) 2019 dreamRs
 *
 * shinybusy, JavaScript bindings to add
 * automatic spinner to Shiny output
 * https://github.com/dreamRs/shinybusy
 *
 * @version 0.1.4
 */


var findOne = function (haystack, arr) {
  arr = [].slice.apply(arr);
  return arr.some(function (v) {
      return haystack.indexOf(v) >= 0;
  });
};
var outputClass = ["shiny-plot-output", "html-widget-output"];

$(document).on("shiny:outputinvalidated", function(event) {
  if ( findOne(outputClass, event.target.classList) ) {

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
      $(event.target)
        .find(".shinybusy-auto-recalculating" + event.target.id)
    );
    $(event.target).removeClass("recalculating");
    $(".shinybusy-auto-spinner")
      .clone()
      .removeClass("shinybusy-auto-spinner")
      .prependTo(event.target);


  }
});


$(document).on("shiny:recalculating", function(event) {
  console.log("HEre 1");
  if ( findOne(outputClass, event.target.classList) ) {
    console.log("HEre 2");
    $(event.target).removeClass("recalculating");
  }
});

$(document).on("shiny:recalculated", function(event) {
  if ( findOne(outputClass, event.target.classList) ) {
    $(event.target).removeClass("shinybusy-recalculating");
  }
});




