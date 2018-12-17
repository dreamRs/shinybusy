
$(function() {

  var timingbusy, busytimeout, busymode;

  // config
  var config = document.querySelectorAll('script[data-for="shinybusy"]');
  if (config.length > 0) {
    config = JSON.parse(config[0].innerHTML);
    busytimeout = config.timeout;
    busymode = config.mode;
  } else {
    busytimeout = 500;
    busymode = "spin";
  }
  console.log(busymode);


  if (busymode == 'spin') {
    $(document).on('shiny:busy', function(event) {
      //console.log("busy");
      timingbusy = setTimeout(function() {
        $(".shinybusy").removeClass("shinybusy-ready");
        $(".shinybusy").addClass("shinybusy-busy");
      }, busytimeout);
    });

    $(document).on('shiny:idle', function(event) {
      //console.log("idle");
      clearTimeout(timingbusy);
      $(".shinybusy").removeClass("shinybusy-busy");
      $(".shinybusy").addClass("shinybusy-ready");
    });
  }
  if (busymode == 'gif') {
    //$('.shinybusy-freezeframe').freezeframe();
    var gifbusy = new freezeframe('.shinybusy-freezeframe').capture().setup();
    $(document).on('shiny:busy', function(event) {
      timingbusy = setTimeout(function() {
        gifbusy.trigger();
      }, busytimeout);
    });

    $(document).on('shiny:idle', function(event) {
      clearTimeout(timingbusy);
      gifbusy.release();
    });
  }
});


