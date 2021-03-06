$ ->
  $('#form_to_proceed').on 'ajax:error', (e, xhr, status, error) ->
    $('div').hide()
    $('div#debug').text(xhr.responseText)
    $('div#debug').show()

  toggleText = (elem, text1, text2) ->
    if elem.text() == text1
      elem.text(text2)
    else
      elem.text(text1)

  toggleCss = (elem, style, value1, value2) ->
    if elem.css(style) == value1
      elem.css(style, value2)
    else
      elem.css(style, value1)

  $('span#toggle_hole_map_display').on 'click', ->
    $('table.hole_map').toggle()
    toggleText($(this), '[+]', '[-]')

  $('span#toggle_leader_board_display').on 'click', ->
    $('table#leaders').toggle()
    toggleText($(this), '[+]', '[-]')

  $('span#toggle_leader_board_full_display').on 'click', ->
    $('table#leaders tr.not_to_display').toggle()
    $('table#result').toggle()
    $('div#players_info').toggle()
    is_displayed = $('span#toggle_leader_board_display').text() == '[-]'
    is_full = $(this).text() == '[ ^ ]'
    if (is_displayed && is_full) || (!is_displayed && !is_full)
      $('span#toggle_leader_board_display').click()
    toggleCss($('div#leader_board'), 'position', 'fixed', 'static')
    toggleText($(this), '[ ... ]', '[ ^ ]')

  $('span#toggle_players_info_full_display').on 'click', ->
    if $('div#players_info tr.not_to_display')[0]
      $('div#players_info tr.not_to_display').removeClass('not_to_display').addClass('to_be_not_to_display')
    else
      $('div#players_info tr.to_be_not_to_display').removeClass('to_be_not_to_display').addClass('not_to_display')
    toggleCss($('div#players_info'), 'position', 'fixed', 'static')
    $('table#result').toggle()
    $('div#hole_map').toggle()
    $('div#leader_board').toggle()
    $('div#score_cards').toggle()
    toggleText($(this), '[ ... ]', '[ ^ ]')

  $('span.hide_score_card_display').on 'click', ->
    $('table.score_card').hide()

  $('span.toggle_score_card_display').on 'click', ->
    num = $(this).text().replace(/\s|\r?\n/g, '')
    $('table.score_card').hide()
    $("table.score_card.group#{num}").show()

  $(window).on 'keydown', (e) ->
    return if e.ctrlKey || e.metaKey
    key = String.fromCharCode(e.which)
    isShifted = e.shiftKey
    switch key
      when 'P'
        if isShifted
          $('span#proceed_signal').removeClass('ready')
          $('#form_to_proceed').submit()
      when 'H'
        $('span#toggle_hole_map_display').click()
      when 'I'
        $('span#toggle_players_info_full_display').click()
      when 'L'
        if isShifted || !$('span#toggle_leader_board_display')[0]
          $('span#toggle_leader_board_full_display').click()
        else
          $('span#toggle_leader_board_display').click()
      when 'S'
        if $('table.score_card').is(':visible')
          $('table.score_card').hide()
        else
          $('span.toggle_score_card_display.current').click()
      when 'J'
        if $('#prev_snapshot')[0]
          $('#prev_snapshot')[0].click()
        else
          button = $('div#score_cards span.toggle_score_card_display.current')
          if button.prev().hasClass('toggle_score_card_display')
            button.removeClass('current').prev().addClass('current')
          card = $('table.score_card:visible').first()
          prev_card = card.prev().prev()
          if prev_card.hasClass('score_card')
            $('table.score_card').hide()
            prev_card.show()
            prev_card.next().show()
      when 'K'
        if $('#next_snapshot')[0]
          $('#next_snapshot')[0].click()
        else
          button = $('div#score_cards span.toggle_score_card_display.current')
          if button.next().hasClass('toggle_score_card_display')
            button.removeClass('current').next().addClass('current')
          card = $('table.score_card:visible').first()
          next_card = card.next().next()
          if next_card.hasClass('score_card')
            $('table.score_card').hide()
            next_card.show()
            next_card.next().show()
      when 'D'
        $('tr#info').toggle()
      when 'B'
        if $('div#db_backups').is(':visible') && isShifted
          $.post('/db_backups')
        else if !isShifted
          $.get('/db_backups')
          $('div#players_info').toggle()
          $('div#db_backups').toggle()
          $('span#stamp').toggle()

  setInterval ->
    $('span.blink').fadeOut 400, ->
      $(this).fadeIn 400
  , 1000
