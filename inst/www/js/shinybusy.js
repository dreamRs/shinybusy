
$(function() {

  var timingbusy, busytimeout, busymode, busypos;

  // config
  var config = document.querySelectorAll('script[data-for="shinybusy"]');
  if (config.length > 0) {
    config = JSON.parse(config[0].innerHTML);
    busytimeout = config.timeout;
    busymode = config.mode;
    busypos = config.position;
  } else {
    busytimeout = 500;
    busymode = "spin";
    busypos = "top-right";
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
    var gifbusy = new freezeframe('.shinybusy-freezeframe');//
    if (busypos !== 'full-page') {
      gifbusy.capture().setup();
    }
    $(document).on('shiny:busy', function(event) {
      if (busypos == 'full-page') {
        $(".shinybusy").removeClass("shinybusy-ready");
        $(".shinybusy").addClass("shinybusy-busy");
      }
      timingbusy = setTimeout(function() {
        gifbusy.trigger();
      }, busytimeout);
    });

    $(document).on('shiny:idle', function(event) {
      if (busypos == 'full-page') {
        $(".shinybusy").removeClass("shinybusy-busy");
        $(".shinybusy").addClass("shinybusy-ready");
      }
      clearTimeout(timingbusy);
      gifbusy.release();
    });
  }
});


