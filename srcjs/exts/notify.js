import "shiny";
import { Notify } from "notiflix/build/notiflix-notify-aio";

Shiny.addCustomMessageHandler("shinybusy-notify-success", function(data) {
  Notify.success(data.text, data.config);
});
Shiny.addCustomMessageHandler("shinybusy-notify-failure", function(data) {
  Notify.failure(data.text, data.config);
});
Shiny.addCustomMessageHandler("shinybusy-notify-warning", function(data) {
  Notify.warning(data.text, data.config);
});
Shiny.addCustomMessageHandler("shinybusy-notify-info", function(data) {
  Notify.info(data.text, data.config);
});

