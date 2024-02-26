HTMLWidgets.widget({
  name: "progressbar",

  type: "output",

  factory: function(el, width, height) {
    var prgr;

    return {
      renderValue: function(x) {
        if (x.type == "Line") {
          el.style.marginBottom = "25px";
        } else {
          el.style.margin = "auto";
        }

        var config = x.config;
        if (x.hasOwnProperty("set_text")) {
          config.step = function(state, bar) {
            bar.setText(x.set_text(state, bar));
          };
        }

        prgr = new ProgressBar[x.type](el, x.config);

        prgr.animate(x.value);
      },

      resize: function(width, height) {},
      getWidget: function() {
        return prgr;
      }
    };
  }
});

// From Friss tuto (https://github.com/FrissAnalytics/shinyJsTutorials/blob/master/tutorials/tutorial_03.Rmd)
function get_progress(id) {
  // Get the HTMLWidgets object
  var htmlWidgetsObj = HTMLWidgets.find("#" + id);
  // Use the getChart method we created to get the underlying billboard chart
  var prgr;
  if (typeof htmlWidgetsObj != "undefined") {
    prgr = htmlWidgetsObj.getWidget();
  }
  return prgr;
}

if (HTMLWidgets.shinyMode) {
  Shiny.addCustomMessageHandler("shinybusy-progress-js", function(message) {
    var prgr = get_progress(message.id);
    if (typeof prgr != "undefined") {
      prgr.animate(message.value);
      if (message.hasOwnProperty("text")) {
        prgr.text.innerHTML = message.text;
        //prgr.setText(message.text);
      }
    }
  });
}

