import "shiny";
import { Block } from 'notiflix/build/notiflix-block-aio';

Shiny.addCustomMessageHandler("shinybusy-block-output", function(data) {
  if (data.hasOwnProperty("text")) {
    Block[data.type](data.selector, data.text, data.config);
  } else {
    Block[data.type](data.selector,data.config);
  }
});
Shiny.addCustomMessageHandler("shinybusy-unblock-output", function(data) {
  Block.remove(data.selector, data.timeout);
});
