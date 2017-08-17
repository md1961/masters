$ ->
  toggleCommand = ->
    if $('table.player_stat_table:visible').length == 2
      $('div#command').show()
    else
      $('div#command').hide()

  $('table#all_stats_table td.player_name').on 'click', ->
    player_id = $(this).parent().attr('id').replace('player-', '')
    $('div#player_stat table#player_stat_table-' + player_id).show()
    toggleCommand()

  $('table.player_stat_table span.close').on 'click', ->
    $(this).parents('table').hide()
    toggleCommand()

  $('table.player_stat_table tr.club_name').on 'click', ->
    $('div#command span#club_name').text($(this).data('club_name'))
