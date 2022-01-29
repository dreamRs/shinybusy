import $ from "jquery";
import "shiny";
import { Block } from "notiflix/build/notiflix-block-aio";

if (window.NodeList && !NodeList.prototype.forEach) {
  NodeList.prototype.forEach = function(callback, thisArg) {
    thisArg = thisArg || window;
    for (var i = 0; i < this.length; i++) {
      callback.call(thisArg, this[i], i, this);
    }
  };
}

$(function() {
  var configsLoadState = document.querySelectorAll(
    "script[data-for='shinybusy-loading-state']"
  );
  configsLoadState.forEach(function(el) {
    var config = JSON.parse(el.innerHTML);
    Block.init(config.options);
    $(document).on(
      "shiny:outputinvalidated shiny:bound",
      config.selector,
      function(event) {
        Block[config.spinner]("#" + event.target.id, config.text);
        if (!$("#" + event.target.id).hasClass("shinybusy-block")) {
          $("#" + event.target.id).addClass("shinybusy-block");
        }
      }
    );
    $(document).on("shiny:value shiny:visualchange", config.selector, function(event) {
      if ($("#" + event.target.id).hasClass("shinybusy-block")) {
        $("#" + event.target.id).removeClass("shinybusy-block");
        Block.remove("#" + event.target.id, config.timeout);
      }
    });
  });
});
