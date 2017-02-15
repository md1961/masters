# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('span#toggle_score_card_display').click ->
    $('table.score_card').toggle()
    if $(this).text() == '[+]'
      $(this).text('[-]')
    else
      $(this).text('[+]')

	setTimeout ->
		$('tr.delayed_display').show()
	, 1500
