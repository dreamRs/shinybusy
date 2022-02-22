import "shiny";
import { Report } from "notiflix/build/notiflix-report-aio";

Shiny.addCustomMessageHandler("shinybusy-report-success", function(data) {
  Report.success(
    data.title,
    data.text,
    data.button,
    data.config
  );
});
Shiny.addCustomMessageHandler("shinybusy-report-failure", function(data) {
  Report.failure(
    data.title,
    data.text,
    data.button,
    data.config
  );
});
Shiny.addCustomMessageHandler("shinybusy-report-warning", function(data) {
  Report.warning(
    data.title,
    data.text,
    data.button,
    data.config
  );
});
Shiny.addCustomMessageHandler("shinybusy-report-info", function(data) {
  Report.info(
    data.title,
    data.text,
    data.button,
    data.config
  );
});

