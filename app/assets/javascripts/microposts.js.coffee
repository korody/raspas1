jQuery ->
  $('#micropost_tag_names').autocomplete
    source: $('#micropost_tag_names').data('autocomplete-source')