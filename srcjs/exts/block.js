import "shiny";
import { Block } from "notiflix/build/notiflix-block-aio";

Shiny.addCustomMessageHandler("shinybusy-block-output", function(data) {
  if (data.hasOwnProperty("text")) {
    Block[data.type](data.selector, data.text, data.config);
  } else {
    Block[data.type](data.selector, data.config);
  }
});
Shiny.addCustomMessageHandler("shinybusy-unblock-output", function(data) {
  Block.remove(data.selector, data.timeout);
});

$(document).on("shiny:outputinvalidated shiny:bound", ".shinybusy-block-element", function(
  event
) {
  var el = document.getElementById(event.target.id);
  var type = el.getAttribute("data-shinybusy-block-type");
  var text = el.getAttribute("data-shinybusy-block-text");
  var config = el.getAttribute("data-shinybusy-block-config");
  config = JSON.parse(config);
  Block[type]("#" + event.target.id, text, config);
  //if (!el.classList.contains("shinybusy-blocked")) {
  //  el.classList.add("shinybusy-blocked");
  //}
});
$(document).on("shiny:value shiny:error", ".shinybusy-block-element", function(
  event
) {
  var el = document.getElementById(event.target.id);
  var timeout = el.getAttribute("data-shinybusy-block-timeout");
  //if (el.classList.contains("shinybusy-blocked")) {
  //  el.classList.remove("shinybusy-blocked");
    Block.remove("#" + event.target.id, timeout);
  //}
});

