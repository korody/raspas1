$(document).ready(function() {
  $('#wait').click(function(e) {
   // e.preventDefault();
    $('#wait').css('visibility','hidden')
    $('#waiting').css('visibility','visible')
  });
  
  $('.wait_favo').click(function() {
    $(this).css('background-color','#E2492F')
  });

});