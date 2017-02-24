# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#form_to_proceed').on 'ajax:error', (e, xhr, status, error) ->
    $('div').hide();
    $('div#debug').text(xhr.responseText);
    $('div#debug').show();

  toggle_text = (elem, text1, text2) ->
    if elem.text() == text1
      elem.text(text2)
    else
      elem.text(text1)

  toggle_css = (elem, style, value1, value2) ->
    if elem.css(style) == value1
      elem.css(style, value2)
    else
      elem.css(style, value1)

  $('span#toggle_leader_board_display').click ->
    $('table#leaders').toggle()
    toggle_text($(this), '[+]', '[-]')

  $('span#toggle_hole_map_display').click ->
    $('table.hole_map').toggle()
    toggle_text($(this), '[+]', '[-]')

  $('span#toggle_leader_board_full_display').click ->
    $('table#leaders tr.not_to_display').toggle()
    $('div#players_info').toggle()
    toggle_css($('div#leader_board'), 'position', 'fixed', 'static')
    toggle_text($(this), '[ ... ]', '[ ^ ]')

  $('span#toggle_players_info_full_display').click ->
    $('div#players_info table tr.not_to_display').toggle()
    $('div#leader_board').toggle()
    $('div#score_cards').toggle()
    toggle_text($(this), '[ ... ]', '[ ^ ]')

  $('span.hide_score_card_display').click ->
    $('table.score_card').hide()

  $('span.toggle_score_card_display').click ->
    num = $(this).text().replace(/\s|\r?\n/g, '');
    $('table.score_card').hide()
    $("table.score_card.group#{num}").show()

  animate_distance = (element, d_start, d1, t_interval1, d_end, t_interval2) ->
    d = d_start
    timer = setInterval ->
      d--
      element.text(d)
      if d <= d1
        if d_end >= 0 && t_interval2 > 0
          animate_distance(element, d1, d_end, t_interval2, 0, 0)
        element.text('IN') if element.text() == '0'
        clearInterval timer
    , t_interval1

  $('span#button_start').click ->
    display = $('span#distance_amination')
    distance = parseInt(display.text())
    result = Math.floor(Math.random() * 3)
    if distance <= 10
      animate_distance(display, distance, result, 200)
    else
      animate_distance(display, distance, 10, 50, result, 200)
###
    display = $('span#distance_amination')
    distance = parseInt(display.text())
    timed_loop = ->
      display.text(distance)
      return if distance <= 0
      distance--
      timeout = distance <= 10 ? 200 : 75
      setTimeout ->
        timed_loop()
      , timeout
    timed_loop()
###
