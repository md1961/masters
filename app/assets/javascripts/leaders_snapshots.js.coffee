$ ->
  $(window).on 'keydown', (e) ->
    return if e.ctrlKey || e.metaKey
    key = String.fromCharCode(e.which)
    switch key
      when 'J'
        $('#prev_snapshot')[0].click()
      when 'K'
        $('#next_snapshot')[0].click()
