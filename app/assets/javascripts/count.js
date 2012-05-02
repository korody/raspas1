$('#micropost_content').live('keyup keydown', function(e) {
  var maxLen = 240;
  var left = maxLen - $(this).val().length;
  $('#count').html(left);
});

$('#bio').live('keyup keydown', function(e) {
  var maxLen = 320;
  var left = maxLen - $(this).val().length;
  $('#count_bio').html(left);
});