$ ->
  toggleCommandDivVisibility = ->
    if $('table.player_stat_table:visible').length == 2
      $('div#command_to_edit_player_club').show()
    else
      $('div#command_to_edit_player_club').hide()

  toggleCommandDivVisibility()

  $('table#all_stats_table td.player_name').on 'click', ->
    player_id = $(this).parent().attr('id').replace('player-', '')
    $('div#player_stat table#player_stat_table-' + player_id).show()
    $.get('/player_club_stat_suites/remember_player', {player_id: player_id})
    toggleCommandDivVisibility()

  $('table.player_stat_table span.close').on 'click', ->
    $table = $(this).parents('table')
    $table.hide()
    player_id = $table.attr('id').replace('player_stat_table-', '')
    $.get('/player_club_stat_suites/forget_player', {player_id: player_id})
    toggleCommandDivVisibility()

  $('table.player_stat_table tr.club_name').on 'click', ->
    $('div#command_to_edit_player_club span#club_name').text($(this).data('club_name'))
    $('div#command_to_edit_player_club div#buttons').show()

  $('table.player_stat_table span.old_club').on 'click', (e) ->
    e.stopPropagation()
    $table = $(this).parents('table')
    window.location.href = '/player_clubs/restore?' + $.param({
      player_id: $table.attr('id').replace('player_stat_table-', ''),
      club_name: $(this).parents('tr.club_name').data('club_name'),
    })

  $('div#command_to_edit_player_club div#buttons input[type="button"]').on 'click', ->
    unless $('table.player_stat_table:visible').length == 2
      alert('Exactly two players must be shown.  Call administrator')
      return
    player_ids = (table.id.replace('player_stat_table-', '') for table in $('table.player_stat_table:visible'))
    window.location.href = '/player_clubs/alter?' + $.param({
      command: $(this).attr('name'),
      club_name: $(this).parent().siblings('span#club_name').first().text(),
      player_left_id:  player_ids[0],
      player_right_id: player_ids[1],
    })
