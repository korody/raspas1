$('#micropost_content').live('keyup keydown', function(e) {
  var maxLen =345;
  var left = maxLen - $(this).val().length;
  $('#count').html(left);
});

$('#bio').live('keyup keydown', function(e) {
  var maxLen = 680;
  var left = maxLen - $(this).val().length;
  $('#count_bio').html(left);
});