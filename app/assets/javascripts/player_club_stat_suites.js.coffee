$ ->
  $('table#all_stats_table td.player_name').on 'click', ->
    player_id = $(this).parent().attr('id').replace('player-', '')
    $('div#player_stat table#player_stat_table-' + player_id).show()

  $('table.player_stat_table').on 'click', ->
    $(this).hide()
