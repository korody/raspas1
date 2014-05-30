jQuery ->
  $('#micropost_author_name').autocomplete
    source: $('#micropost_author_name').data('autocomplete-source')

  $('#micropost_tag_names').autocomplete
    source: $('#micropost_tag_names').data('autocomplete-source')

  $('#micropost_origin_name').autocomplete
    source: $('#micropost_origin_name').data('autocomplete-source')

  $('#origin_author_name').autocomplete
    source: $('#origin_author_name').data('autocomplete-source')