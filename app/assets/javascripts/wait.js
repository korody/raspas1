$(document).ready(function() {
  $('#wait').click(function(e) {
   // e.preventDefault();
    $('#wait').css('visibility','hidden')
    $('#waiting').css('visibility','visible')
  });
});

$(document).ready(function() {
  $('#wait_favo').click(function(e) {
   // e.preventDefault();
    $('#wait_favo').css('background-color','#E2492F')
  });
});
