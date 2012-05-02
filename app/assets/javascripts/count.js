$('#micropost_content').live('keyup keydown', function(e) {
  var maxLen = 246;
  var left = maxLen - $(this).val().length;
  $('#count').html(left);
});

$('#bio').live('keyup keydown', function(e) {
  var maxLen = 321;
  var left = maxLen - $(this).val().length;
  $('#count_bio').html(left);
});