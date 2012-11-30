
$(document).ready(function() {
  /*
  ** Toggle the scenario details when the title is clicked
  ** The `.expanded` CSS class on the caret makes it point downward, instead of to the right
  */
  $('.scenario a').click(function() {
    var scenario = $(this).next('.scenario-details');

    if (scenario.is(":visible")) {
      scenario.hide();
    } else {
      scenario.show();
    }

    $(this).children(":first").toggleClass("expanded");
  });
});
