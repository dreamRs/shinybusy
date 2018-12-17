
$(function() {

  var timingbusy, busytimeout;

  // config
  var config = document.querySelectorAll('script[data-for="shinybusy"]');
  if (config.length > 0) {
    config = JSON.parse(config[0].innerHTML);
    busytimeout = config.timeout;
  } else {
    busytimeout = 500;
  }
  console.log(busytimeout);


  $(document).on('shiny:busy', function(event) {
    console.log("busy");
    timingbusy = setTimeout(function() {
      $(".shinybusy").removeClass("shinybusy-ready");
      $(".shinybusy").addClass("shinybusy-busy");
    }, busytimeout);
  });

  $(document).on('shiny:idle', function(event) {
    clearTimeout(timingbusy);
    console.log("idle");
    $(".shinybusy").removeClass("shinybusy-busy");
    $(".shinybusy").addClass("shinybusy-ready");
  });
});


