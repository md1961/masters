# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  toggle_text = (elem, text1, text2) ->
    if elem.text() == text1
      elem.text(text2)
    else
      elem.text(text1)

  $('span#toggle_leader_board_display').click ->
    $('table#leaders').toggle()
    toggle_text($(this), '[+]', '[-]')

  $('span#toggle_hole_map_display').click ->
    $('table.hole_map').toggle()
    toggle_text($(this), '[+]', '[-]')

  $('span#toggle_leader_board_full_display').click ->
    $('table#leaders tr.not_to_display').toggle()
    $('div#players_info').toggle()
    div = $('div#leader_board')
    if div.css('position') == 'fixed'
      div.css('position', 'static')
    else
      div.css('position', 'fixed')
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

  setTimeout ->
    $('tr.delayed_display').show()
    $('input[type="submit"]').prop('disabled', false)
  , parseInt($('div#message').attr('data-time_to_delay'))
