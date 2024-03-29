import $ from "jquery";
import "shiny";
import Freezeframe from "freezeframe";
import Nanobar from "nanobar";
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
  var configs = document.querySelectorAll('script[data-for="shinybusy"]');

  configs.forEach(function(element) {
    var id,
      timingbusy,
      intervalbusy,
      busytimeout,
      busymode,
      busypos,
      busyclassname,
      manualmode = false,
      busytype = "";

    var config = JSON.parse(element.innerHTML);
    if (config) {
      id = config.id;
      busytimeout = config.timeout;
      busymode = config.mode;
      busypos = config.position;
      busyclassname = config.classname;
      if (config.hasOwnProperty("type")) {
        busytype = config.type;
      }
    }
    // console.log(busymode);

    if (busymode == "spin") {
      if (busytype == "auto") {
        $(document).on("shiny:busy", function(event) {
          timingbusy = setTimeout(function() {
            $("#" + id).removeClass("shinybusy-ready");
            $("#" + id).addClass("shinybusy-busy");
            if (busypos == "full-page") {
              $("#" + id + "_overlay").removeClass("shinybusy-ready");
              $("#" + id + "_overlay").addClass("shinybusy-busy");
            }
          }, busytimeout);
        });

        $(document).on("shiny:idle", function(event) {
          clearTimeout(timingbusy);
          $("#" + id).removeClass("shinybusy-busy");
          $("#" + id).addClass("shinybusy-ready");
          if (busypos == "full-page") {
            $("#" + id + "_overlay").removeClass("shinybusy-busy");
            $("#" + id + "_overlay").addClass("shinybusy-ready");
          }
        });
      }
      if (busytype == "start") {
        $(document).on("shiny:idle", function(event) {
          $(".shinybusy").removeClass("shinybusy-busy");
          $(".shinybusy").addClass("shinybusy-ready");
        });
      }
    }

    if (busymode == "gif") {
      //$('.shinybusy-freezeframe').freezeframe();
      if (busypos != "full-page") {
        var gifbusy = new Freezeframe(".shinybusy-freezeframe"); //
        if (busypos !== "full-page") {
          //gifbusy.capture().setup();
        }
        if (busytype == "auto") {
          $(document).on("shiny:busy", function(event) {
            if (busypos == "full-page") {
              $(".shinybusy").removeClass("shinybusy-ready");
              $(".shinybusy").addClass("shinybusy-busy");
            }
            timingbusy = setTimeout(function() {
              gifbusy.start();
            }, busytimeout);
          });

          $(document).on("shiny:idle", function(event) {
            if (busypos == "full-page") {
              $(".shinybusy").removeClass("shinybusy-busy");
              $(".shinybusy").addClass("shinybusy-ready");
            }
            clearTimeout(timingbusy);
            gifbusy.stop();
          });
        } else {
          Shiny.addCustomMessageHandler("shinybusy-play-gif", function(data) {
            gifbusy.start();
          });
          Shiny.addCustomMessageHandler("shinybusy-stop-gif", function(data) {
            gifbusy.stop();
          });
        }
      } else {
        $(document).on("shiny:busy", function(event) {
          timingbusy = setTimeout(function() {
            $(".shinybusy").removeClass("shinybusy-ready");
            $(".shinybusy").addClass("shinybusy-busy");
          }, busytimeout);
        });
        $(document).on("shiny:idle", function(event) {
          clearTimeout(timingbusy);
          $(".shinybusy").removeClass("shinybusy-busy");
          $(".shinybusy").addClass("shinybusy-ready");
        });
      }
    }

    if (busymode == "nanobar") {
      var nanobar = new Nanobar({ classname: busyclassname });

      if (busytype == "manual") {
        Shiny.addCustomMessageHandler("shinybusy-update-nanobar", function(
          data
        ) {
          nanobar.go(data.value);
        });
      }
      if (busytype == "auto") {
        $(document).on("shiny:busy", function(event) {
          intervalbusy = setInterval(function() {
            nanobar.go(100);
          }, busytimeout);
        });

        $(document).on("shiny:idle", function(event) {
          clearInterval(intervalbusy);
        });
      }
    }
  });

  // Spin handlers
  Shiny.addCustomMessageHandler("shinybusy-show-spinner", function(data) {
    if (data.hasOwnProperty("spin_id")) {
      $("#" + data.spin_id).removeClass("shinybusy-ready");
      $("#" + data.spin_id).addClass("shinybusy-busy");
    } else {
      $(".shinybusy").removeClass("shinybusy-ready");
      $(".shinybusy").addClass("shinybusy-busy");
    }
  });
  Shiny.addCustomMessageHandler("shinybusy-hide-spinner", function(data) {
    if (data.hasOwnProperty("spin_id")) {
      $("#" + data.spin_id).removeClass("shinybusy-busy");
      $("#" + data.spin_id).addClass("shinybusy-ready");
    } else {
      $(".shinybusy").removeClass("shinybusy-busy");
      $(".shinybusy").addClass("shinybusy-ready");
    }
  });
});
