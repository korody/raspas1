$(document).ready(function() {
  $('#micropost_origin_name').focus(function() {
    $('.radio_raspa').css('visibility','visible')
  });
  $('#micropost_content, #micropost_author_name, #micropost_tag_names').click(function() {
    $('.radio_raspa').css('visibility','hidden')
  });
});