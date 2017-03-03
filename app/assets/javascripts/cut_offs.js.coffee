$ ->
  $('input[name=player_cut_off]').on 'click', ->
    in_bottom = parseInt($(this).val())
    if in_bottom % 2 == 0 then in_bottom++
    table = $('table#cut_offs')
    table.find('tr').removeClass('cut')
    table.find('tr:gt(' + in_bottom + ')').addClass('cut')
