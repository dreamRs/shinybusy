import $ from "jquery";
import "shiny";
import "../css/shinybusy.css";

if (window.NodeList && !NodeList.prototype.forEach) {
  NodeList.prototype.forEach = function(callback, thisArg) {
    thisArg = thisArg || window;
    for (var i = 0; i < this.length; i++) {
      callback.call(thisArg, this[i], i, this);
    }
  };
}

$(function() {
  var configsStartUp = document.querySelectorAll(
    "script[data-for='shinybusy-start-up']"
  );
  var startup = document.getElementsByClassName("shinybusy-startup");
  configsStartUp.forEach(function(el) {
    var config = JSON.parse(el.innerHTML);
    if (config.mode == "timeout") {
      setTimeout(function() {
        while (startup[0]) {
          startup[0].parentNode.removeChild(startup[0]);
        }
      }, config.timeout);
    }
    if (config.mode == "auto") {
      $(document).on("shiny:idle", function(event) {
        setTimeout(function() {
          while (startup[0]) {
            startup[0].parentNode.removeChild(startup[0]);
          }
        }, config.timeout);
      });
    }
  });
  Shiny.addCustomMessageHandler("shinybusy-remove-start-up", function(data) {
    var startup = document.getElementsByClassName("shinybusy-startup");
    setTimeout(function() {
      while (startup[0]) {
        startup[0].parentNode.removeChild(startup[0]);
      }
    }, data.timeout);
  });
});
