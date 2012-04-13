jQuery ->
  $('#micropost_author_name').autocomplete
    source: $('#micropost_author_name').data('autocomplete-source')