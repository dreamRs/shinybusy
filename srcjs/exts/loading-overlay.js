import "shiny";
import { Loading } from "notiflix/build/notiflix-loading-aio";

// Pending delayed removal, must not remove an indicator shown afterwards.
var removeTimer = null;

function cancelRemove() {
  if (removeTimer !== null) {
    clearTimeout(removeTimer);
    removeTimer = null;
  }
}

Shiny.addCustomMessageHandler("shinybusy-loading-show", function(data) {
  cancelRemove();
  // Notiflix ignores a new indicator while the previous one is in the DOM, even when fading out.
  var previous = document.getElementById("NotiflixLoadingWrap");
  if (previous !== null) {
    previous.parentNode.removeChild(previous);
  }
  if (typeof data.text === "string") {
    Loading[data.type](data.text, data.config);
  } else {
    Loading[data.type](data.config);
  }
});

Shiny.addCustomMessageHandler("shinybusy-loading-update", function(data) {
  Loading.change(data.text);
});

Shiny.addCustomMessageHandler("shinybusy-loading-remove", function(data) {
  cancelRemove();
  if (data.timeout > 0) {
    removeTimer = setTimeout(function() {
      removeTimer = null;
      Loading.remove();
    }, data.timeout);
  } else {
    Loading.remove();
  }
});
