
$(function() {

  var timingbusy, intervalbusy, busytimeout, busymode, busypos, busyclassname, manualmode = false;

  // config
  var config = document.querySelectorAll('script[data-for="shinybusy"]');
  if (config.length > 0) {
    config = JSON.parse(config[0].innerHTML);
    busytimeout = config.timeout;
    busymode = config.mode;
    busypos = config.position;
    busyclassname = config.classname;
    if (config.hasOwnProperty("type")) {
      busytype = config.type;
    }
  }
  // console.log(busymode);


  if (busymode == 'spin') {

    if (busytype == 'manual') {
      Shiny.addCustomMessageHandler('show-spinner', function(data) {
        $(".shinybusy").removeClass("shinybusy-ready");
        $(".shinybusy").addClass("shinybusy-busy");
      });
      Shiny.addCustomMessageHandler('hide-spinner', function(data) {
        $(".shinybusy").removeClass("shinybusy-busy");
        $(".shinybusy").addClass("shinybusy-ready");
      });
    }
    if (busytype == 'auto') {
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
    if (busytype == 'start') {
      $(document).on('shiny:idle', function(event) {
        $(".shinybusy").removeClass("shinybusy-busy");
        $(".shinybusy").addClass("shinybusy-ready");
      });
    }

  }

  if (busymode == 'gif') {
    //$('.shinybusy-freezeframe').freezeframe();
    if (busypos != 'full-page') {
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
    } else {
      $(document).on('shiny:busy', function(event) {
        timingbusy = setTimeout(function() {
          $(".shinybusy").removeClass("shinybusy-ready");
          $(".shinybusy").addClass("shinybusy-busy");
        }, busytimeout);
      });
      $(document).on('shiny:idle', function(event) {
        clearTimeout(timingbusy);
        $(".shinybusy").removeClass("shinybusy-busy");
        $(".shinybusy").addClass("shinybusy-ready");
      });
    }
  }

  if (busymode == 'nanobar') {
    var nanobar = new Nanobar({classname: busyclassname});

    if (busytype == 'manual') {
      Shiny.addCustomMessageHandler('update-nanobar', function(data) {
        nanobar.go(data.value);
      });
    }
    if (busytype == 'auto') {
      $(document).on('shiny:busy', function(event) {
        intervalbusy = setInterval(function() {
          nanobar.go(100);
        }, busytimeout);
      });

      $(document).on('shiny:idle', function(event) {
        clearInterval(intervalbusy);
      });
    }
  }
});


