$('#micropost_content').on('keyup keydown', function(e) {
  var maxLen =345;
  var left = maxLen - $(this).val().length;
  $('#count').html(left);
});

$('#bio').on('keyup keydown', function(e) {
  var maxLen = 680;
  var left = maxLen - $(this).val().length;
  $('#count_bio').html(left);
});

$('#origin_info').on('keyup keydown', function(e) {
  var maxLen = 680;
  var left = maxLen - $(this).val().length;
  $('#count_bio').html(left);
});