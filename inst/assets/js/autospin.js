/*!
 * Copyright (c) 2019 dreamRs
 *
 * shinybusy, JavaScript bindings to add
 * automatic spinner to Shiny output
 * https://github.com/dreamRs/shinybusy
 *
 * @version 0.1.4
 */

$(document).on("shiny:outputinvalidated", function(event) {
  console.log(event);
  var children = $(event.target).children();
  //$( event.target ).empty();
  event.target.innerHTML = "";
  $(event.target).addClass("shinybusy-recalculating");

  $(".shinybusy-auto-recalculating")
    .clone()
    .removeClass("shinybusy-auto-recalculating")
    .addClass("shinybusy-auto-recalculating" + event.target.id)
    .appendTo(event.target);
  children.appendTo(
    $(event.target).find(".shinybusy-auto-recalculating" + event.target.id)
  );
  $(event.target).removeClass("recalculating");
  $(".shinybusy-auto-spinner")
    .clone()
    .removeClass("shinybusy-auto-spinner")
    .prependTo(event.target);
});

$(document).on("shiny:recalculating", function(event) {
  $(event.target).removeClass("recalculating");
});

$(document).on("shiny:recalculated", function(event) {
  $(event.target).removeClass("shinybusy-recalculating");
});
