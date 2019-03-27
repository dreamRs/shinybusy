
$(function() {

  var timingbusy, intervalbusy, busytimeout, busymode, busypos, busyclassname;

  // config
  var config = document.querySelectorAll('script[data-for="shinybusy"]');
  if (config.length > 0) {
    config = JSON.parse(config[0].innerHTML);
    busytimeout = config.timeout;
    busymode = config.mode;
    busypos = config.position;
    busyclassname = config.classname;
  } else {
    busytimeout = 500;
    busymode = "spin";
    busypos = "top-right";
    busyclassname = 'shinybusy-bar';
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

    $(document).on('shiny:busy', function(event) {
      intervalbusy = setInterval(function() {
        nanobar.go(100);
      }, busytimeout);
    });

    $(document).on('shiny:idle', function(event) {
      clearInterval(intervalbusy);
    });
  }
});


