$(function() {
  $("#micropost_tag_tokens").tokenInput("/tags.json", {
    crossDomain: false,
    prePopulate: $("#micropost_tag_tokens").data("pre"),
    theme: "facebook"
  });
});