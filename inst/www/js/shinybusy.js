
$(function() {

  var timingbusy;

  $(document).on('shiny:busy', function(event) {
    console.log("busy");
    timingbusy = setTimeout(function() {
      $(".shinybusy").removeClass("shinybusy-ready");
      $(".shinybusy").addClass("shinybusy-busy");
    }, 500);
  });

  $(document).on('shiny:idle', function(event) {
    clearTimeout(timingbusy);
    console.log("idle");
    $(".shinybusy").removeClass("shinybusy-busy");
    $(".shinybusy").addClass("shinybusy-ready");
  });
});


